<?php

namespace App\Exceptions;

class FatalException extends BaseException {

    public function __construct($error) {

        parent::__construct($error['message'], 0);

        $this->file = $error['file'];
        $this->line = $error['line'];
    }
}