<?php

namespace Http\Account;

use Domain\Tickets\TicketsService;
use Domain\Users\UsersService;

use App\Exceptions\BaseException;
use App\Exceptions\AccessDeniedException;

class TicketsController extends \App\BaseController {

    /**
     *  Pages
     */

    public function indexAction() {

        $_admin = UsersService::checkAccess('Tickets', 'admin');

        $tickets = ($_admin) ? TicketsService::findAllForAdmin() : TicketsService::findAllForUser(UsersService::current()
                                                                                                              ->getId());

        return array(
            'output' => array(
                'title'   => 'Тикеты',
                'tickets' => $tickets,
                '_admin'  => $_admin,
            ),
        );
    }

    public function addAction() {

        return array(
            'output' => array(
                'categories' => TicketsService::getCategories(),
                'priorities' => TicketsService::getPriorities(),
                'title'      => 'Тикеты',
            ),
        );
    }

    public function viewAction($id) {

        try {

            $ticket = TicketsService::findById(intval($id));
            $comments = TicketsService::loadComments($ticket);
        } catch (EntityNotFoundException $e) {

            return array(
                'redirect' => '/tickets',
            );
        }

        return array(
            'output' => array(
                'title'     => $ticket->theme,
                'ticket'    => $ticket,
                'comments'  => $comments,
                'user_name' => UsersService::current()->getLogin(),
            ),
        );
    }

    public function editAction($id = null) {

        try {
            $ticket = TicketsService::findById(intval($id));
        } catch (EntityNotFoundException $e) {
            return array(
                'redirect' => '/tickets',
            );
        }

        return array(
            'output' => array(
                'title'  => 'Тикеты', //$newItem->getTitle(),
                'ticket' => $ticket,
            ),
        );
    }

    /**
     *  Handlers
     */

    public function loadAction() {

        // Фильтры запроса
        $filters = array(
            'date_from' => (!empty($_POST['date_from']) && $this->checkDate($_POST['date_from'])) ? $_POST['date_from'] : date("Y-m-d", time() - 3600 * 24 * 31),
            'date_to'   => (!empty($_POST['date_to']) && $this->checkDate($_POST['date_to'])) ? $_POST['date_to'] : date("Y-m-d"),
        );

        if (!empty($_POST['status'])) {
            $filters['status'] = intval($_POST['status']);
        }

        if (!empty($_POST['priority_id'])) {
            $filters['priority_id'] = intval($_POST['priority_id']);
        }

        if (!empty($_POST['category_id'])) {
            $filters['category_id'] = intval($_POST['category_id']);
        }

        // Admin
        if (true) {

            if (!empty($_POST['user_id'])) {
                $filters['user_id'] = intval($_POST['user_id']);
            }

            if (!empty($_POST['assigned_id'])) {
                $filters['assigned_id'] = intval($_POST['assigned_id']);
            }

            if (!empty($_POST['search'])) {
                $filters['search'] = intval($_POST['search']);
            }

        } else {

            $current_user = UsersService::current();
            $filters['user_id'] = $current_user->getId();
        }

        return array(
            'output' => array(
                'tickets' => TicketsService::findByWith($filters, array('categories', 'priorities')),
            ),
        );
    }

    public function createAction() {

        $data = array(
            'theme'       => $_POST['theme'],
            'description' => $_POST['description'],
            'category_id' => intval($_POST['category_id']),
            'priority_id' => intval($_POST['priority_id']),
        );

        $current_user = UsersService::current();
        $data['owner_id'] = $current_user->getId();
        $data['owner_name'] = $current_user->getLogin();

        TicketsService::create($data);

        return array(
            'output' => array(
                'status'   => 'success',
                'action'   => 'continue',
                'location' => '/tickets',
            ),
        );
    }

    public function markAction($ticket_id = null, $mark = null) {

        $ticket_id = (empty($ticket_id) && !empty($_GET['id'])) ? intval($_GET['id']) : intval($ticket_id);
        $mark = (empty($mark) && !empty($_GET['mark'])) ? intval($_GET['mark']) : intval($mark);

        if (empty($ticket_id)) {
            $this->redirectBack();
        }

        $this->tickets->mark($ticket_id, $mark);
        $this->redirectBack();
    }

    public function settingsAction() {

        if (!$this->user->access('tickets/settings')) {
            $this->redirect('/tickets?error=access_denied');
        }

        if (isset($_POST['tickets_support'])) {
            $tickets_support = intval($_POST['tickets_support']);
            $res = $this->settings->save('tickets_support', $tickets_support);

            if ($res) {
                $this->view->message = 'Сохранено';
            } else {
                $this->view->error = 'Ошибка';
            }
        } else {
            $tickets_support = $this->settings->getValue('tickets_support');
        }

        $this->view->current_support = $tickets_support;
        $this->view->supports = array(
            0     => 'По умолчанию',
            1186  => 'MobioffersSupport1',
            6554  => 'MobioffersSupport2',
            4778  => 'OfferSupport',
            9142  => 'Alexander Mobioffers',
            12245 => 'MobiOffersТechSupport',
            14759 => 'MobioffersSupport4',
            20866 => 'MobioffersSupport3',
            26836 => 'MobioffersSupport5',
        );

        $this->view->content = $this->getView('tickets/settings');
        $this->output = $this->getView('index');

        $this->outputPage();
    }

    public function mailAction() {

        if (!$this->user->_admin && (empty($_GET['sign']) || $_GET['sign'] != 'h7FdhEbq')) {
            exit;
        }

        $this->mailer->initMail();
        $mail = new mailModel;

        $accounts = array(
            array('name' => 'finance', 'category' => 1),
            array('name' => 'support', 'category' => 2),
            array('name' => 'offers', 'category' => 3),
            array('name' => 'traffic', 'category' => 4),
            array('name' => 'newpartner1', 'category' => 5),
            array('name' => 'newpartner2', 'category' => 5),
            array('name' => 'newpartner3', 'category' => 5),
        );

        foreach ($accounts as $account) {

            $accountName = $account['name'];
            $category = $account['category'];

            if ($mail->connect($accountName)) {

                $items = $mail->getAllUnseen();
                $this->log('tickets_mail', $accountName . ' success [' . count($items) . ']');

                foreach ($items as $item) {

                    $data = $mail->getTicketData($item);
                    $user = $this->user->findByEmail($data['from']);
                    if (empty($user->id)) {

                        $user = new stdClass;
                        $user->id = 0;
                        $user->login = $data['from'];
                        $user->email = $data['from'];
                    }

                    // ticket
                    if (empty($data['ticket_id']) || empty($data['sig'])) {

                        $ticket = new stdClass;
                        $ticket->theme = $data['subject'];
                        $ticket->description = $data['message'];
                        $ticket->priority = 2;
                        $ticket->category = $category;

                        $result = $tickets->add($ticket, $user);
                        if ($result['status']) {
                            $ticket->id = $result['id'];
                            $mailData = $tickets->mailAddAdmin($ticket, $user, $result['assignedId']);
                            //$this->mailer->sendMail($mailData);
                            print_r($mailData);
                        }
                    } // comment
                    else {

                        $ticket = $tickets->findById($data['ticket_id']);

                        $sig = substr(md5(intval($user->id) . '|' . intval($ticket->id) . '|' . $ticket->date_c), 0, 10);
                        if ($data['sig'] == $sig) {

                            $comment = new stdClass;
                            $comment->user_id = $user->id;
                            $comment->user_name = $user->login;
                            $comment->user_email = $user->email;
                            $comment->message = $data['message'];
                            $comment->ticket_id = $ticket->id;
                            $comment->status = 1;

                            $result = $tickets->commentAdd($comment);

                            if ($result) {

                                $tickets_support = $this->settings->getValue('tickets_support');
                                $assigned_id = (empty($tickets_support) || $tickets_support == 0) ? $ticket->assigned_id : $tickets_support;

                                $mailData = $tickets->mailCommentAdmin($ticket, $comment, $user, $assigned_id);
                                //$this->mailer->sendMail($mailData);

                                print_r($mailData);
                            }
                        }
                    }
                }

                $mail->close();
            } else {
                $this->log('tickets_mail', $accountName . ' failed');
            }
        }
    }
}