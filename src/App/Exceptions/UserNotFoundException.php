<?php

namespace App\Exceptions;

class UserNotFoundException extends NotFoundException {

    protected $_http_code = 401;

    public function __construct() {

        parent::__construct('Unauthorized', 0);
    }

}