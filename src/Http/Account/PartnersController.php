<?php

namespace Http\Account;

use Domain\Users\UsersService;

class PartnersController extends \App\BaseController {

    /**
     *  Pages
     */
    public function indexAction() {

        return array(
            'output' => array(
                'title'    => 'Партнеры',
                'partners' => UsersService::findPartners(),
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