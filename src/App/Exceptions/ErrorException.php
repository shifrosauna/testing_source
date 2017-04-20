<?php

namespace App\Exceptions;

class ErrorException extends BaseException {

    public function __construct($message, $code, $severity, $file, $line, $context = null) {

        parent::__construct($message, 0);

        $this->file = $file;
        $this->line = $line;

        $this->setContext($context);
    }
}