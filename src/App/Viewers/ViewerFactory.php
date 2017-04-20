<?php

namespace App\Viewers;

use \App\Exceptions\BaseException;

class ViewerFactory {

    /**
     * Create Viewer object based on the type of connection
     *
     * @param string $site_name
     * @param string $output_type
     *
     * @return AbstractViewer
     * @throws \App\Exceptions\BaseException
     */
    public static function create($site_name, $output_type = null) {

        if (empty($output_type)) {
            $output_type = self::getOutputType();
        }

        switch ($output_type) {

            case 'cli':
                return new CliViewer();

            case 'csv':
                return new CsvViewer();

            case 'excel':
                return new ExcelViewer();

            case 'html':
                return new HtmlViewer();

            case 'json':
                return new JsonViewer();

            case 'xml':
                return new XmlViewer();

            default:
                throw new BaseException("Unknown output_type {$output_type}.");
        }
    }

    /**
     * Determining the type of server connection
     *
     * @return string (html|json|cli)
     */
    public static function getOutputType() {

        if ((!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') || !empty($_SERVER['CONTENT_TYPE']) && in_array($_SERVER['CONTENT_TYPE'], array(
                'application/json',
                'application/javascript',
            ))
        ) {

            return 'json';
        }

        if (php_sapi_name() == 'cli') {
            return 'cli';
        }

        return 'html';
    }
}