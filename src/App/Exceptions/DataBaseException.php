<?php

namespace App\Exceptions;

class DataBaseException extends BaseException {

    public function __construct(\PDOException $e) {

        parent::__construct($e->getMessage(), 0, $e);
    }
}