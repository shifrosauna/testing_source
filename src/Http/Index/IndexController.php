<?php

namespace Http\Index;

use App\Mailer\MailerFactory;

class IndexController extends \App\BaseController {

    /**
     *  Pages
     */
    public function indexAction() {

        $contacts_message = '';

        if (!empty($_GET['status'])) {
            if ($_GET['status'] == 'success') {
                $contacts_message = 'Сообщение отправлено';
            } elseif ($_GET['status'] == 'error') {
                $contacts_message = 'Пожалуйста, заполните все поля формы';
            }
        }

        return array(
            'output_type' => 'html',
            'view'        => 'Index/ru',
            'output'      => array(
                'contacts_message' => $contacts_message,
            ),
        );
    }

    public function enAction() {

        $contacts_message = '';

        if (!empty($_GET['status'])) {
            if ($_GET['status'] == 'success') {
                $contacts_message = 'The message was sent successfully';
            } elseif ($_GET['status'] == 'error') {
                $contacts_message = 'Please fill in all the fields';
            }
        }

        return array(
            'view'   => 'Index/en',
            'output' => array(
                'contacts_message' => $contacts_message,
            ),
        );
    }

    public function requestAction() {

        $lang = (!empty($_POST['lang'])) ? $_POST['lang'] : '';

        if (empty($_POST) || empty($_POST['name']) || empty($_POST['email']) || empty($_POST['subject']) || empty($_POST['message'])) {
            return array(
                'redirect' => '/' . $lang . '?status=error#contacts',
            );
        }

        $body = '<b>Имя:</b> ' . $_POST['name'] . '<br/>';
        $body .= '<b>Email:</b> ' . $_POST['email'] . '<br/><br/>';
        $body .= '<b>Тема:</b> ' . $_POST['subject'] . '<br/>';
        $body .= '<b>Сообщение:</b> ' . $_POST['message'];

        $mailer = MailerFactory::get('POP3');
        $mailer->init(array(
            'subject' => 'Сообщение с сайта MobiOffers.ru',
            'body'    => $body,
        ));

        $mailer->sendMail('support@mobioffers.ru');

        return array(
            'redirect' => '/' . $lang . '?status=success#contacts',
        );
    }
}