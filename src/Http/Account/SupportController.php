<?php

namespace Http\Account;

class SupportController extends \App\BaseController {

    /**
     *  Pages
     */
    public function indexAction() {

        return array(
            'output' => array(
                'title' => 'Техподдержка',
            ),
        );
    }
}