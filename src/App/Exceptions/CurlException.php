<?php

namespace App\Exceptions;

class CurlException extends BaseException {

    public function __construct($curlHandle) {

        parent::__construct('API call failed with cURL error: ' . curl_error($curlHandle), 0);
    }
}