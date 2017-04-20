<?php

namespace App\Exceptions;

class ValidateException extends BaseException {

    protected $_http_code = 400;

    /**
     * ValidateException constructor.
     *
     * @param array $errors
     */
    public function __construct($errors) {

        parent::__construct('Wrong data', 0);

        $this->setContext($errors);
    }
}