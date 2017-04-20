<?php

namespace App\Exceptions\Handlers;

use \App\Exceptions\BaseException;

class OutputAjax extends OutputStandard {

    /**
     * @var string
     */
    protected static $fileLinkFormat;

    /**
     * @var string
     */
    protected $_fileLinkFormat;

    /**
     * @param string $fileLinkFormat
     */
    public function __construct($fileLinkFormat = null) {

        if (is_null($fileLinkFormat)) {
            $this->_fileLinkFormat = self::$fileLinkFormat;
        } else {
            $this->_fileLinkFormat = $fileLinkFormat;
        }
    }

    /**
     * This setting determines the format of the links that are made in the
     * display of stack traces where file names are used. This allows IDEs to
     * set up a link-protocol that makes it possible to go directly to a line
     * and file by clicking on the filenames that shows in stack traces.
     * An example format might look like:
     * 'txmt://open/?file://%f&line=%l' (TextMate)
     * 'gvim://%f@%l' (gVim - with additional hack)
     * 'nb://%f:%l' (NetBeans - with additional hack)
     * The possible format specifiers are:
     * %f - the filename
     * %l - the line number
     *
     * @see https://bugs.eclipse.org/bugs/show_bug.cgi?id=305345
     * @see http://code.google.com/p/coda-protocol/
     *
     * @param string $fileLinkFormat
     */
    public static function setFileLinkFormat($fileLinkFormat) {

        ini_set('xdebug.file_link_format', self::$fileLinkFormat);
        self::$fileLinkFormat = $fileLinkFormat;
    }

    /**
     * @see http://bugs.php.net/bug.php?id=50921
     *
     * @param BaseException $exception
     * @param bool          $debug
     */
    public function output($exception, $debug) {

        $context = $this->context($exception);

        if ($debug) {

            $data = $context ?? $this->format($exception);
        } else {

            $http_status = self::codeToHttpStatus($exception->getHttpCode());
            $data = $context ?? $http_status ?? self::$productionMessage;
        }

        self::$viewer->setStatus(array('http_code' => $exception->getHttpCode()));
        self::$viewer->output($data);
    }

    /**
     * @param BaseException $exception
     *
     * @return string
     */
    public function format($exception) {

        $sTrace = new \stdClass;
        $exceptionReflect = new \ReflectionClass($exception);

        $sTrace->exception = $exceptionReflect->getShortName();
        $sTrace->message = self::getMessage($exception);

        $sTrace->file = $exception->getFile();
        $sTrace->line = $exception->getLine();
        $sTrace->filename = basename($sTrace->file);
        $sTrace->dir = str_replace($sTrace->filename, '', $sTrace->file);
        $sTrace->path = $this->getFileLink($sTrace->file, $sTrace->line);

        return $sTrace;
    }

    /**
     * @param BaseException $exception
     *
     * @return string
     */
    public function context($exception) {

        $context = '';

        if (get_parent_class($exception) == 'App\Exceptions\BaseException') {
            $context = $exception->getContext();
        }

        return $context;
    }

    /**
     * @param string $file
     * @param int    $line
     *
     * @return string
     */
    protected function getFileLink($file, $line) {

        if (is_null($file) || !strlen($this->_fileLinkFormat)) {
            return parent::getFileLink($file, $line);
        }

        $fileLink = str_replace(array('%f', '%l'), array(urlencode($file), $line), $this->_fileLinkFormat);

        return '    <a href="' . $fileLink . '">' . self::formatString(parent::getFileLink($file, $line)) . '</a>';
    }
}