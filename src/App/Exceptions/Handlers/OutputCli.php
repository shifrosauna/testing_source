<?php

namespace App\Exceptions\Handlers;

use App\Exceptions\BaseException;

class OutputCli extends OutputStandard {

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
     * This setting determines the format of the filepath that are made in the
     * display of stack traces where file names are used.
     * ': in %f on line %l' (Netbeans)<br>
     * The possible format specifiers are:<br>
     * %f - the filename<br>
     * %l - the line number<br>
     *
     * @param string $fileLinkFormat
     */
    public static function setFileLinkFormat($fileLinkFormat) {

        self::$fileLinkFormat = $fileLinkFormat;
    }

    /**
     * @param BaseException $exception
     * @param bool          $debug
     */
    public function output($exception, $debug) {

        if ($debug) {
            exit($this->format($exception));
        } else {
            exit(self::$productionMessage);
        }
    }

    /**
     * @param BaseException $exception
     *
     * @return string
     */
    public function format($exception) {

        return $this->_format($exception, false);
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

        $fileLink = str_replace(array('%f', '%l'), array($file, $line), $this->_fileLinkFormat);

        return '    ' . $fileLink;
    }
}