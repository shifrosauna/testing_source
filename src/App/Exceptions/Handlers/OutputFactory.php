<?php

namespace App\Exceptions\Handlers;

class OutputFactory {

    /**
     * @return Output
     */
    public function getExceptionHandlerOutput() {

        if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
            return new OutputAjax();
        }

        if (!empty($_SERVER['CONTENT_TYPE']) && in_array($_SERVER['CONTENT_TYPE'], array(
                'application/json',
                'application/javascript',
            ))
        ) {
            return new OutputAjax();
        }

        if (php_sapi_name() == 'cli') {
            return new OutputCli();
        }

        return new OutputWeb();
    }
}