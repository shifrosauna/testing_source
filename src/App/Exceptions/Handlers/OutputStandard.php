<?php

namespace App\Exceptions\Handlers;

use App\Exceptions\BaseException;

abstract class OutputStandard extends Output {

    /**
     * @param BaseException $exception
     */
    abstract public function format($exception);

    /**
     * @param BaseException $exception
     * @param string        $html
     *
     * @return string
     */
    protected function _format($exception, $html) {

        $aTrace = self::getTrace($exception);

        $sTrace = '[' . get_class($exception) . ']:' . "\r\n";
        $sTrace .= self::getMessage($exception) . "\r\n";
        $sTrace .= $this->getFileLink($exception->getFile(), $exception->getLine()) . "\r\n" . "\r\n";

        if ($html) {
            $sTrace = htmlspecialchars($sTrace, ENT_COMPAT, 'UTF-8');
        }

        $prevArg = null;
        foreach ($aTrace as $aTraceNo => $aTraceLine) {

            $sTraceLine = '#' . $aTraceNo . ': ';

            if (array_key_exists('class', $aTraceLine)) {
                $sTraceLine .= $aTraceLine['class'] . $aTraceLine['type'];
            }

            if (array_key_exists('function', $aTraceLine)) {
                $sTraceLine .= $aTraceLine['function'];
                if (!empty($aTraceLine['args'])) {
                    $sTraceLine .= self::argumentsToString($aTraceLine['args']);
                }
            }

            if ($html) {
                $sTraceLine = htmlspecialchars($sTraceLine, ENT_COMPAT, 'UTF-8');
            }

            if (array_key_exists('file', $aTraceLine)) {
                $sTraceLine .= "\n" . $this->getFileLink($aTraceLine['file'], $aTraceLine['line']);
            } else {
                $sTraceLine .= "\n" . $this->getFileLink(null, null);
            }

            $sTrace .= $sTraceLine . "\n";
        }

        if ($html) {
            $sTrace = '<pre>' . $sTrace . '</pre>';
        }

        return $sTrace;
    }
}