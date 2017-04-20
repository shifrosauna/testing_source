<?php

namespace App\Exceptions;

class ActionNotFoundException extends NotFoundException {

    protected $_http_code = 404;

}