<?php

namespace App\Exceptions\Handlers;

use App\Exceptions\BaseException;

abstract class Log {

    const uncaughtException = 0;
    const caughtException   = 1;
    const ignoredError      = 2;
    const lowPriorityError  = 3;
    const assertion         = 4;

    /**
     * @param BaseException $exception
     *
     * @return string
     */
    public static function getUid($exception) {

        return md5(get_class($exception) . $exception->getFile() . $exception->getLine() . $exception->getCode());
    }

    /**
     * @param BaseException $exception
     * @param int           $logType
     */
    abstract public function log($exception, $logType);
}