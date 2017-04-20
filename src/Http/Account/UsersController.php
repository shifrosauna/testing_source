<?php

namespace Http\Account;

use Domain\Users\UsersService;

class UsersController extends \App\BaseController {

    /**
     *  Pages
     */
    public function indexAction() {

        return array(
            'output' => array(
                'title' => 'Пользователи',
                // 'partners' => UsersService::findPartners()
            ),
        );
    }

    public function groupsAction() {

        return array(
            'output' => array(
                'title'  => 'Группы пользователей',
                'groups' => UsersService::findGroups(),
            ),
        );
    }

    /**
     *  Handlers
     */
    public function autocompleteAction() {

        $partners = UsersService::findAllActive();

        $output = array();
        foreach ($partners as $partner) {
            $output[] = array(
                'value' => $partner->id . '. ' . $partner->login,
                'data'  => $partner->id,
            );
        }

        return array(
            'output' => $output,
        );
    }
}