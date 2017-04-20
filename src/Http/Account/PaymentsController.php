<?php

namespace Http\Account;

use Domain\Users\UsersService;
use Domain\Stat\StatService;

class PaymentsController extends \App\BaseController {

    /**
     *  Pages
     */
    public function indexAction() {

        $user = UsersService::current();
        UsersService::loadInfo($user);

        $_admin = UsersService::checkAccess('Payments', 'admin');
        if ($_admin) {
            $weeks = StatService::getPaymentsWeeks();
        }

        return array(
            'output' => array(
                'title'  => 'Выплаты',
                'wmz'    => $user->getInfo('wmz'),
                '_admin' => $_admin,
                'weeks'  => ($_admin) ? $weeks : array(),
            ),
        );
    }

    public function csvAction() {

        $date_from = $_GET['date_from'];
        $date_to = $_GET['date_to'];

        return array(
            'output_type' => 'csv',
            'data'        => StatService::csvPayments($date_from, $date_to),
            'filename'    => 'mobioffers_payments_' . $date_from . '_' . $date_to,
        );
    }

    public function xmlAction() {

        $date_from = $_GET['date_from'];
        $date_to = $_GET['date_to'];

        return array(
            'output_type' => 'xml',
            'data'        => StatService::xmlPayments($date_from, $date_to),
            'filename'    => 'Mobioffers_masspayment_' . $date_from . '-' . $date_to . '.xml',
        );
    }
}