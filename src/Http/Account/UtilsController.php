<?php

namespace Http\Account;

use Domain\Users\UsersService;
use Domain\Utils\UtilsService;
use App\Exceptions\BaseException;
use App\Exceptions\AccessDeniedException;
use App\Exceptions\EntityNotFoundException;

class UtilsController extends \App\BaseController {

    public function countriesAction() {

        $output = array();
        foreach (UtilsService::$countries as $code => $name) {
            $output[] = array(
                'value' => $name,
                'data'  => $code,
            );
        }

        return array(
            'output' => $output,
        );
    }

    public function validateAction($field) {

        switch ($field) {
            case 'email':

                if (UsersService::isExistEmail($_GET['email'])) {
                    return array(
                        'http_code'   => 400,
                        'http_status' => 'Email already exist',
                    );
                }

                break;

            case 'login':

                if (UsersService::isExistLogin($_GET['login'])) {
                    return array(
                        'http_code'   => 400,
                        'http_status' => 'Login already exist',
                    );
                }

                break;
        }

        return array(
            'http_code'    => 200,
            'content_type' => 'text/plain',
        );
    }
}