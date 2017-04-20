<?php

namespace App\Exceptions;

class FileNotFoundException extends NotFoundException {

    protected $_http_code = 404;

    public function __construct($filename) {

        parent::__construct("File {$filename} not found in {$this->file}.");
    }
}