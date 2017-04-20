<?php

namespace App\Exceptions;

class UnauthorizedException extends BaseException {

    protected $_http_code = 401;

    public function __construct() {

        parent::__construct('Unauthorized', 0);
    }
}