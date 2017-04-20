<?php

namespace App\Exceptions;

class BaseException extends \Exception {

    protected $_context = null;
    protected $_http_code = 500;

    public function getContext() {

        return $this->_context;
    }

    public function setContext($value) {

        $this->_context = $value;
    }

    public function getHttpCode() {

        return $this->_http_code;
    }
}