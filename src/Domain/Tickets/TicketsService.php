<?php

namespace Domain\Tickets;

use Infrastructure\TicketsRepository;
use App\Exceptions\EntityNotFoundException;
use App\Exceptions\ValidateException;

class TicketsService {

    /**
     * Restore Ticket by unique id
     *
     * @param int $id
     *
     * @return Ticket
     * @throws EntityNotFoundException
     */
    public static function findById($id) {

        $ticketsRepository = new TicketsRepository;
        $ticketData = $ticketsRepository->findById($id);

        if (empty($ticketData)) {
            throw new EntityNotFoundException('Ticket', $id);
        }

        return TicketsFactory::createByData($ticketData);
    }

    /**
     * Create Ticket
     *
     * @param array $data
     */
    public static function create($data) {

        $ticket = TicketsFactory::create();

        self::validate($data);
        self::fill($ticket, $data);

        $assigned_user = self::getAssignedUserByCategoryId($ticket->category_id);
        self::assignTo($ticket, $assigned_user);
        self::setStatus($ticket, 0);

        $ticket_id = self::push($ticket);

        return $ticket_id;
    }

    /**
     * Update
     *
     * @param int   $id
     * @param array $data
     */
    public static function update($id, $data) {

        self::validate($data);

        $ticket = self::findById($id);
        self::change($ticket, $data);
        self::push($ticket);
    }

    /**
     * Validate data
     *
     * @param array $data
     */
    public static function validate($data) {

        $errors = array();

        if (empty($data['theme'])) {
            $errors['theme'] = 'empty';
        }

        if (empty($data['description'])) {
            $errors['description'] = 'empty';
        }

        if (!empty($errors)) {
            throw new ValidateException('Ticket', $errors);
        }
    }

    /**
     * Fill data
     *
     * @param Ticket $ticket
     * @param array  $data
     */
    public static function fill($ticket, $data) {

        foreach ($data as $filed => $value) {
            $ticket->set($filed, $value);
        }
    }

    /**
     * Fill data
     *
     * @param Ticket $ticket
     * @param array  $data
     */
    public static function assignTo($ticket, $assigned_user) {

        $ticket->assigned_id = $assigned_user->id;

        // ToDo
        // Mail to admin ($assigned_user->getEmail())
        // self::mailToAssigned($ticket, $assigned_user);
    }

    public static function setStatus($ticket, $status) {

        $ticket->status = $status;
    }

    /**
     * Fill data
     *
     * @param Ticket $ticket
     * @param array  $data
     */
    public static function change($ticket, $data) {

        foreach ($data as $filed => $value) {
            $ticket->change($filed, $value);
        }
    }

    /**
     * Push to database
     *
     * @param Ticket $ticket
     */
    public static function push($ticket) {

        $ticketsRepository = new TicketsRepository;

        if (!empty($ticket->getId())) {
            $ticketsRepository->update($ticket);
        } else {
            $ticketsRepository->insert($ticket);
        }
    }

    /**
     * Find all tickets by user_id
     *
     * @param int $userId
     *
     * @return array Ticket[]
     */
    public static function findAllForUser($userId) {

        $ticketsRepository = new TicketsRepository;

        $tickets = $ticketsRepository->findBy(array(
            'filters' => array('owner_id' => $userId),
            'order'   => array('date_c' => 'DESC'),
        ));
        foreach ($tickets as $i => $ticketData) {
            $tickets[$i] = TicketsFactory::createByData($ticketData);
        }

        return $tickets;
    }

    /**
     * Find all tickets for admin
     *
     * @return array Ticket[]
     */
    public static function findAllForAdmin() {

        $ticketsRepository = new TicketsRepository;

        $tickets = $ticketsRepository->findBy(array('order' => array('date_c' => 'DESC')));
        foreach ($tickets as $i => $ticketData) {

            $ticket = TicketsFactory::createByData($ticketData);
            $ticket->links = array(
                'редактировать' => '/tickets/edit/' . $ticket->id,
            );

            $tickets[$i] = $ticket;
        }

        return $tickets;
    }

    public static function getCategories() {

        $ticketsRepository = new TicketsRepository;

        return $ticketsRepository->getCategories();
    }

    public static function getPriorities() {

        $ticketsRepository = new TicketsRepository;

        return $ticketsRepository->getPriorities();
    }

    /**
     *  STUB
     */

    // ToDo
    // выбрать ответственного по категории
    public static function getAssignedUserByCategoryId($category_id) {

        // ToDo    
        // $assigned_user = UsersService::createById($ticket->assidned_id);

        $assigned_user = new \stdClass;
        $assigned_user->id = 0;
        $assigned_user->email = 'php.vlad@gmail.com';

        return $assigned_user;
    }

    public static function loadComments($ticket) {

        return array();
    }

    public static function mailToAssigned($ticket, $assigned_user) {

    }
}