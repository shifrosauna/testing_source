<?php

namespace App\Exceptions\Handlers;

use App\Exceptions\BaseException;
use App\Exceptions\ErrorException;
use App\Exceptions\FatalException;
use App\Viewers\AbstractViewer;

final class Control {

    /**
     * @var bool
     */
    public static $debug = false;

    /**
     * if true ignores @-operator and generates exception
     * if false doesn't generate exceptions for errors slashed with @-operator, but logs it
     * @var bool
     */
    public static $scream = false;

    /**
     * Which type of error convert to exception
     * @var int
     */
    public static $errorTypesException = E_ALL;

    /**
     * @var bool
     */
    public static $assertionThrowException = true;

    /**
     * @var int
     */
    public static $assertionErrorType = E_USER_ERROR;

    /**
     * If set to instance of ExceptionHandlerLog, will log
     * If set to null will not log
     * @var Log
     */
    public static $exceptionHandlerLog = null;

    /**
     * @var Output
     */
    private static $exceptionHandlerOutput;

    /**
     * @var array
     */
    private static $previousAssertOptions;

    /**
     * @var bool
     */
    private static $setupFlag = false;

    /**
     * @param string $error_log
     */
    public static function setupEnvironment($error_log) {

        if (self::$debug) {
            ini_set('error_reporting', E_ALL | E_STRICT);
            ini_set('display_errors', 'On');
            ini_set('display_startup_errors', 'On');
        } else {
            ini_set('error_reporting', E_ERROR);
            ini_set('display_errors', 'Off');
            ini_set('display_startup_errors', 'Off');
        }

        ini_set('html_errors', 'Off');
        ini_set('docref_root', '');
        ini_set('docref_ext', '');

        ini_set('log_errors', 'On');
        ini_set('log_errors_max_len', 0);
        ini_set('ignore_repeated_errors', 'Off');
        ini_set('ignore_repeated_source', 'Off');
        ini_set('report_memleaks', 'Off');
        ini_set('track_errors', 'On');
        ini_set('xmlrpc_errors', 'Off');
        ini_set('xmlrpc_error_number', 'Off');
        ini_set('error_prepend_string', '');
        ini_set('error_append_string', '');
        ini_set('error_log', $error_log);
    }

    /**
     * setup handlers
     *
     * @param Output $exceptionHandlerOutput
     * @param int    $errorTypesHandle which errors will be converted to exceptions
     * @param null   $viewer
     */
    public static function setupHandlersOutput($exceptionHandlerOutput = null, $errorTypesHandle = null, $viewer = null) {

        if (is_null($errorTypesHandle)) {
            $errorTypesHandle = E_ALL | E_STRICT;
        }

        if (is_null($exceptionHandlerOutput)) {
            $exceptionHandlerOutput = new OutputFactory();
        }

        if ($exceptionHandlerOutput instanceof OutputFactory) {
            self::$exceptionHandlerOutput = $exceptionHandlerOutput->getExceptionHandlerOutput();
        } else {
            self::$exceptionHandlerOutput = $exceptionHandlerOutput;
        }

        Output::$exceptionHandlerClass = __CLASS__;

        if (!self::$setupFlag) {

            set_error_handler(__CLASS__ . '::errorHandler', $errorTypesHandle);
            set_exception_handler(__CLASS__ . '::exceptionHandler');

            // Interception of critical errors
            register_shutdown_function(__CLASS__ . '::fatalityHandler');

            // Creation of the output buffer
            ob_start();

            self::$previousAssertOptions[ASSERT_ACTIVE] = assert_options(ASSERT_ACTIVE);
            self::$previousAssertOptions[ASSERT_WARNING] = assert_options(ASSERT_ACTIVE);
            self::$previousAssertOptions[ASSERT_BAIL] = assert_options(ASSERT_BAIL);
            self::$previousAssertOptions[ASSERT_QUIET_EVAL] = assert_options(ASSERT_QUIET_EVAL);
            self::$previousAssertOptions[ASSERT_CALLBACK] = assert_options(ASSERT_CALLBACK);

            assert_options(ASSERT_ACTIVE, 1);
            assert_options(ASSERT_WARNING, 0);
            assert_options(ASSERT_BAIL, 0);
            assert_options(ASSERT_QUIET_EVAL, 0);
            assert_options(ASSERT_CALLBACK, __CLASS__ . '::assertionHandler');

            self::$setupFlag = true;
        }
    }

    /**
     * setup log handlers
     *
     * @param Log $exceptionHandlerLog
     */
    public static function setupHandlersLog($exceptionHandlerLog = null) {

        self::$exceptionHandlerLog = $exceptionHandlerLog;
    }

    /**
     * setup viewer
     *
     * @param AbstractViewer $viewer
     */
    public static function setupHandlersViewer($viewer = null) {

        self::$exceptionHandlerOutput->setViewer($viewer);
    }

    /**
     * Restores error, exception and assertion handlers
     */
    public static function restoreHandlers() {

        if (self::$setupFlag) {

            restore_error_handler();
            restore_exception_handler();
            assert_options(ASSERT_ACTIVE, self::$previousAssertOptions[ASSERT_ACTIVE]);
            assert_options(ASSERT_WARNING, self::$previousAssertOptions[ASSERT_WARNING]);
            assert_options(ASSERT_BAIL, self::$previousAssertOptions[ASSERT_BAIL]);
            assert_options(ASSERT_QUIET_EVAL, self::$previousAssertOptions[ASSERT_QUIET_EVAL]);
            assert_options(ASSERT_CALLBACK, self::$previousAssertOptions[ASSERT_CALLBACK]);
            self::$setupFlag = false;
        }
    }

    /**
     * Handles uncaught exceptions
     *
     * @param BaseException $exception
     *
     * @throws ErrorException
     */
    public static function exceptionHandler($exception) {

        if ($exception instanceof \Error) {
            $exception = new ErrorException($exception->getMessage(), $exception->getCode(), E_ERROR, $exception->getFile(), $exception->getLine());
        }

        self::exceptionLog($exception, Log::uncaughtException);
        self::$exceptionHandlerOutput->output($exception, self::$debug);
    }

    /**
     * Convert error to exception
     *
     * @param int    $severity The severity level of the exception
     * @param string $message  The Exception message to throw
     * @param string $file     The filename where the exception is thrown
     * @param int    $line     The filename where the exception is thrown
     * @param array  $context
     *
     * @throws ErrorException
     */
    public static function errorHandler($severity, $message, $file = null, $line = null, $context = null) {

        $exception = new ErrorException($message, $severity, E_ERROR, $file, $line, $context);

        /**
         * don't throw exception if '@' operator used
         */
        if (error_reporting() === 0 && !self::$scream) {

            self::exceptionLog($exception, Log::ignoredError);

            return;
        } elseif (!($severity & self::$errorTypesException)) {

            self::exceptionLog($exception, Log::lowPriorityError);

            return;
        }

        if ($severity & self::$errorTypesException) {
            throw $exception;
        }
    }

    /**
     * Convert assertion fail to exception
     *
     * @param string $file    The filename where the exception is thrown
     * @param int    $line    The filename where the exception is thrown
     * @param string $message The Exception message to throw
     *
     * @throws ErrorException
     */
    public static function assertionHandler($file, $line, $message) {

        $exception = new ErrorException($message, 0, self::$assertionErrorType, $file, $line);

        if (!self::$assertionThrowException) {

            self::exceptionLog($exception, Log::assertion);
            self::$exceptionHandlerOutput->output($exception, self::$debug);

            return;
        }

        throw $exception;
    }

    /**
     * Convert uncaught exception to exception
     *
     * @throws FatalException
     */
    public static function fatalityHandler() {

        $error = error_get_last();

        if (isset($error)) {
            if ($error['type'] & (E_ERROR | E_PARSE | E_COMPILE_ERROR | E_CORE_ERROR)) {

                // Reset the buffer, the buffer exit
                ob_end_clean();

                $exception = new FatalException($error);

                self::exceptionLog($exception, Log::uncaughtException);
                self::$exceptionHandlerOutput->output($exception, self::$debug);

                return;
            } else {

                // The output buffer, the buffer exit
                ob_end_flush();
            }
        } else {

            // The output buffer, the buffer exit
            ob_end_flush();
        }
    }

    /**
     * @param BaseException $exception
     * @param int           $logPriority
     */
    public static function exceptionLog($exception, $logPriority = null) {

        if (!is_null(self::$exceptionHandlerLog)) {
            self::$exceptionHandlerLog->log($exception, $logPriority);
        }
    }
}