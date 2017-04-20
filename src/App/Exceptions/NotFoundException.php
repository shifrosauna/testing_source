<?php

namespace App\Exceptions;

class NotFoundException extends BaseException {

    protected $_http_code = 404;

}