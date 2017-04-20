<?php

namespace Http\Account;

use \App\BaseController;

class FaqController extends BaseController {

    /**
     *  Pages
     */
    public function indexAction() {

        return array(
            'output' => array(
                'title' => 'FAQ',
            ),
        );
    }
}