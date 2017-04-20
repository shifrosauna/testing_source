<?php

namespace App\Exceptions;

class JsonException extends BaseException {

    public function __construct($jsonErrorCode) {

        parent::__construct('API response not well-formed (json error code: ' . $jsonErrorCode . ')', 0);
    }
}