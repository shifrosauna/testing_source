<?php

namespace App\Exceptions;

class LayoutFileNotFoundException extends FileNotFoundException {

    protected $_http_code = 404;

    public function __construct($view_name, $filename) {

        $temp = explode('Resources/Layouts', $filename);

        parent::__construct('Layout ' . $temp[1] . ' not found in ' . $this->file . '.');
    }
}