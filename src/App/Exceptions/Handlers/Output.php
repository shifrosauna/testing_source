<?php

namespace App\Exceptions\Handlers;

use App\Exceptions\BaseException;
use App\Viewers\AbstractViewer;

abstract class Output {

    /**
     * @var string
     */
    public static $exceptionHandlerClass;

    /**
     * @var string
     */
    public static $productionMessage = 'Internal Server Error';

    /**
     * @var int
     */
    public static $maxChars = 40;

    /**
     * @var AbstractViewer
     */
    protected static $viewer;

    /**
     * @param int $severity
     *
     * @return string
     */
    public static function severityToString($severity) {

        switch ($severity) {
            case 1:
                return 'E_ERROR';
                break;
            case 2:
                return 'E_WARNING';
                break;
            case 4:
                return 'E_PARSE';
                break;
            case 8:
                return 'E_NOTICE';
                break;
            case 16:
                return 'E_CORE_ERROR';
                break;
            case 32:
                return 'E_CORE_WARNING';
                break;
            case 64:
                return 'E_COMPILE_ERROR';
                break;
            case 128:
                return 'E_COMPILE_WARNING';
                break;
            case 256:
                return 'E_USER_ERROR';
                break;
            case 512:
                return 'E_USER_WARNING';
                break;
            case 1024:
                return 'E_USER_NOTICE';
                break;
            case 2048:
                return 'E_STRICT';
                break;
            case 4096:
                return 'E_RECOVERABLE_ERROR';
                break;
            case 8192:
                return 'E_DEPRECATED';
                break;
            case 16384:
                return 'E_USER_DEPRECATED';
                break;
            case 30719:
                return 'E_ALL';
                break;
        }

        return '';
    }

    public static function codeToHttpStatus($code) {

        switch ($code) {

            // Informational
            case 100:
                return 'Continue';
                break;
            case 102:
                return 'Processing';
                break;

            // Success
            case 200:
                return 'OK';
                break;
            case 201:
                return 'Created';
                break;
            case 202:
                return 'Accepted';
                break;
            case 204:
                return 'No Content';
                break;
            case 205:
                return 'Reset Content';
                break;
            case 206:
                return 'Partial Content';
                break;
            case 302:
                return 'Moved Temporarily';
                break;

            // Client Error
            case 400:
                return 'Bad Request';
                break;
            case 401:
                return 'Unauthorized';
                break;
            case 403:
                return 'Forbidden';
                break;
            case 404:
                return 'Not Found';
                break;
            case 405:
                return 'Method Not Allowed';
                break;
            case 423:
                return 'Locked';
                break;
            case 429:
                return 'Too Many Requests';
                break;

            // Server Error
            case 500:
                return 'Internal Server Error';
                break;
            case 502:
                return 'Bad Gateway';
                break;
            case 503:
                return 'Service Unavailable';
                break;
        }

        return '';
    }

    /**
     * @param BaseException $exception
     *
     * @return string
     */
    public static function getMessage($exception) {

        $result = '';
        if ($exception instanceof \ErrorException) {

            $result = self::severityToString($exception->getSeverity());
            if (strlen($exception->getMessage())) {
                $result .= ' - ';
            }
        }

        $result .= $exception->getMessage();

        return $result;
    }

    /**
     * @param BaseException $exception
     *
     * @return array
     */
    public static function getTrace($exception) {

        $backtrace = $exception->getTrace();
        $count = count($backtrace);

        /**
         * bug
         * @see http://www.php.net/manual/en/class.errorexception.php#86985
         */
        if (strpos(phpversion(), '5.2') === 0 && $exception instanceof \ErrorException) {

            for ($i = $count - 1; $i > 0; --$i) {
                $backtrace[$i]['args'] = $backtrace[$i - 1]['args'];
            }

            $backtrace[0]['args'] = null;
        }

        $result = array();
        for ($i = 0; $i < $count; $i++) {

            if (array_key_exists('class', $backtrace[$i]) && $backtrace[$i]['class'] == self::$exceptionHandlerClass) {
                continue;
            }

            $result[] = $backtrace[$i];
        }

        return $result;
    }

    /**
     * @param mixed $arg
     *
     * @return string utf-8
     */
    public static function argToString($arg) {

        switch (gettype($arg)) {
            case 'boolean':
                $arg = $arg ? 'true' : 'false';
                break;
            case 'NULL':
                $arg = 'null';
                break;
            case 'integer':
            case 'double':
            case 'float':

                $arg = (string)$arg;
                $arg = str_replace('INF', '∞', $arg); //is_infinite($arg)

                break;
            case 'string':

                if (is_callable($arg, false, $callable_name)) {
                    $arg = 'fs:' . $callable_name;
                } elseif (class_exists($arg, false)) {
                    $arg = 'c:' . $arg;
                } elseif (interface_exists($arg, false)) {
                    $arg = 'i:' . $arg;
                } else {

                    $strlen = self::stringLength($arg);
                    $arg = self::formatString($arg);

                    if ($strlen <= self::$maxChars) {
                        $arg = '"' . $arg . '"';
                    } else {
                        $arg = '"' . $arg . '"(' . $strlen . ')';
                    }

                    return $arg = str_replace("\n", '\n', $arg);
                }

                break;
            case 'array':

                if (is_callable($arg, false, $callable_name)) {
                    $arg = 'fa:' . $callable_name;
                } else {
                    $arg = 'array(' . count($arg) . ')';
                }

                break;
            case 'object':
                $arg = get_class($arg) . '()';//.':'.spl_object_hash($arg);
                break;
            case 'resource':
                // @see http://php.net/manual/en/resource.php
                $arg = 'r:' . get_resource_type($arg);
                break;
            default:
                $arg = 'unknown type';
                break;
        }

        return $arg;
    }

    /**
     * @param string $str
     *
     * @return string
     */
    public static function formatString($str) {

        if (self::stringLength($str) > self::$maxChars) {
            $str = trim(mb_substr($str, 0, self::$maxChars / 2)) . '...' . trim(mb_substr($str, -self::$maxChars / 2));
        }

        return $str;
    }

    /**
     * @param string $str
     *
     * @return int
     */
    public static function stringLength($str) {

        return mb_strlen($str);
    }

    /**
     * @param array $args
     *
     * @return string
     */
    public static function argumentsToString($args) {

        if (!is_null($args)) {
            foreach ($args as $iArg => $arg) {
                $args[$iArg] = self::argToString($arg);
            }

            return '(' . implode(', ', $args) . ')';
        }

        return '()';
    }

    public function setViewer($viewer) {

        self::$viewer = $viewer;
    }

    /**
     * @param BaseException $exception
     * @param bool          $debug
     */
    abstract public function output($exception, $debug);

    /**
     * @param string $file
     * @param int    $line
     *
     * @return string
     */
    protected function getFileLink($file, $line) {

        if (is_null($file)) {
            return '    unknown file';
        }

        return '    ' . $file . ':' . $line;
    }
}