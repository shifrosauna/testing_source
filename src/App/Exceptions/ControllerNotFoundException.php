<?php

namespace App\Exceptions;

class ControllerNotFoundException extends NotFoundException {

    protected $_http_code = 404;

}