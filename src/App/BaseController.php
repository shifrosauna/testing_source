<?php

namespace App;

class BaseController {

    protected $request;

    public function __construct() {

        $this->request = new Request;
    }
}