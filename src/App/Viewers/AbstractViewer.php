<?php

namespace App\Viewers;

class AbstractViewer {

    protected $http_code    = 200;
    protected $http_status  = 'OK';
    protected $http_headers = array();
    protected $data         = '';
    protected $viewVariables;

    protected $_output_type = 'html';
    protected $_site_name   = 'Index';
    protected $_layout      = 'index';
    protected $_view        = 'Index/index';

    public static function codeToHttpStatus($code) {

        switch ($code) {

            // Informational
            case 100:
                return 'Continue';
            case 102:
                return 'Processing';

            // Success
            case 200:
                return 'OK';
            case 201:
                return 'Created';
            case 202:
                return 'Accepted';
            case 204:
                return 'No Content';
            case 205:
                return 'Reset Content';
            case 206:
                return 'Partial Content';

            // Success
            case 302:
                return 'Moved Temporarily';

            // Client Error
            case 400:
                return 'Bad Request';
            case 401:
                return 'Unauthorized';
            case 403:
                return 'Forbidden';
            case 404:
                return 'Not Found';
            case 405:
                return 'Method Not Allowed';
            case 423:
                return 'Locked';
            case 429:
                return 'Too Many Requests';

            // Server Error
            case 500:
                return 'Internal Server Error';
            case 502:
                return 'Bad Gateway';
            case 503:
                return 'Service Unavailable';
        }
    }

    public function output($data) {

        $this->setData($data);
        $this->sendHttpHeaders();

        if (isset($this->data)) {
            $this->printData();
        }

        exit;
    }

    public function setSiteName($siteName) {

        $this->_site_name = $siteName;
    }

    public function getOutputType() {

        return $this->_output_type;
    }

    public function setLayout($layout) {

        $this->_layout = $layout;
    }

    public function setView($view) {

        $this->_view = $view;
    }

    public function setStatus($data) {

        if (!empty($data['http_code'])) {

            $http_status = (!empty($data['http_status'])) ? $data['http_status'] : self::codeToHttpStatus($data['http_code']);
            if (!empty($http_status)) {
                $this->http_code = $data['http_code'];
                $this->http_status = $http_status;
            }
        }
    }

    protected function setData($data) {

    }

    private function sendHttpHeaders() {

        header('Server: The Death Star');
        header('X-Powered-By: Darth Vader');
        header('HTTP/1.1 ' . $this->http_code . ' ' . $this->http_status, true, $this->http_code);
        header('Status: ' . $this->http_code . ' ' . $this->http_status, true, $this->http_code);

        foreach ($this->http_headers as $header) {
            header($header);
        }
    }

    private function printData() {

        echo $this->data;
    }
}