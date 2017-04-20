<?php

namespace App\Exceptions;

class ViewFileNotFoundException extends FileNotFoundException {

    protected $_http_code = 404;

    public function __construct($view_name, $filename) {

        $temp = explode('Resources/Views', $filename);
        $view = (!empty($temp) && !empty($temp[1])) ? $temp[1] . ' ' : '';
        parent::__construct('View ' . $view . ' not found.');

    }
}