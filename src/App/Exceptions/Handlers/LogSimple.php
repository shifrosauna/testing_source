<?php

namespace App\Exceptions\Handlers;

use App\Exceptions\BaseException;

class LogSimple extends Log {

    /**
     * @param BaseException $exception
     * @param int           $logType
     */
    public function log($exception, $logType) {

        switch ($logType) {
            case self::uncaughtException:

                $formatter = new OutputCli('');
                error_log($formatter->format($exception));

                break;
        }
    }
}