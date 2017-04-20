<?php

namespace Http\Account;

use Domain\Stat\StatService;
use Domain\Users\UsersService;
use App\Exceptions\BaseException;
use App\Exceptions\AccessDeniedException;
use App\Exceptions\EntityNotFoundException;

class StatController extends \App\BaseController {

    /**
     *  Pages
     */

    public function indexAction() {

        return array(
            'output' => array(
                'title'  => 'Статистика',
                '_admin' => UsersService::checkAccess('Stat', 'admin'),
            ),
        );
    }

    public function cohortAction() {

        return array(
            'output' => array(
                'title' => 'Когортный анализ',
            ),
        );
    }

    /**
     *  Handlers
     */

    public function loadAction() {

        if (empty($_SERVER['HTTP_X_REQUESTED_WITH']) || $_SERVER['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest') {
            return array(
                'redirect' => '/stat',
            );
        }

        $options = array(
            'filters'  => (!empty($_POST['filters'])) ? $_POST['filters'] : array(),
            'fields'   => (!empty($_POST['fields'])) ? $_POST['fields'] : array(
                'clicks',
                'installs',
                'conversions',
                'payout',
                'cr',
            ),
            'agregate' => (!empty($_POST['agregate'])) ? $_POST['agregate'] : array(),
        );

        $_admin = UsersService::checkAccess('Stat', 'admin');

        // $stat = StatService::findAllForUser($options, UsersService::current()->getId());

        $stat = ($_admin) ? StatService::findAllForAdmin($options) : StatService::findAllForUser($options, UsersService::current()
                                                                                                                       ->getId());

        return array(
            'output' => array(
                'status' => 'success',
                'stat'   => $stat,
            ),
        );
    }

    public function cohortloadAction() {

        $options = array(
            'filters'  => (!empty($_POST['filters'])) ? $_POST['filters'] : array(),
            'fields'   => (!empty($_POST['fields'])) ? $_POST['fields'] : array(
                'activations',
                'impressions',
                'payout',
                'revenue',
            ),
            'agregate' => (!empty($_POST['agregate'])) ? $_POST['agregate'] : array(),
        );

        return array(
            'output' => array(
                'status' => 'success',
                'stat'   => StatService::cohort($options),
            ),
        );
    }
}