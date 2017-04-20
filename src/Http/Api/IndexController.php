<?php

namespace Http\Api;

class IndexController extends \App\BaseController {

    public function indexAction() {

        return array(
            'http_code'   => 404,
            'output_type' => 'json',
            'output'      => array(
                'error' => 'Method not found',
            ),
        );
    }
}