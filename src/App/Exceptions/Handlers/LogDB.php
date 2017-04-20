<?php

namespace App\Exceptions\Handlers;

use App\Exceptions\BaseException;

class LogDB extends Log {

    /**
     * @param BaseException $exception
     * @param int           $logType
     */
    public function log($exception, $logType) {

        // echo date("H:i:s") .' log in DB<br/>';
    }
}