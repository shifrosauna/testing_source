<?php

namespace App;

/**
 * Класс для работы с данными, полученными от клиента ($_GET, $_POST, $_COOKIE, $_SERVER, php://input)
 */
class Request {

    private $_get;
    private $_post;
    private $_cookie;
    private $_server;
    private $_input_stream;

    public function __construct() {

        $this->_get = $_GET;
        $this->_post = $_POST;
        $this->_cookie = $_COOKIE;
        $this->_server = $_SERVER;
        $this->_input_stream = $this->getInputStream();
    }

    /**
     * @param string            $key
     * @param string|array|null $default
     *
     * @return string|array
     */
    public function get($key = null, $default = null) {

        return $this->query($this->_get, $key, $default);
    }

    /**
     * @param string            $key
     * @param string|array|null $default
     *
     * @return int
     */
    public function getInt($key = null, $default = null) {

        return intval($this->get($key, $default));
    }

    /**
     * @param string            $key
     * @param string|array|null $default
     *
     * @return float
     */
    public function getFloat($key = null, $default = null) {

        return floatval($this->get($key, $default));
    }

    /**
     * @param string            $key
     * @param string|array|null $default
     *
     * @return string|array
     */
    public function post($key = null, $default = null) {

        return $this->query($this->_post, $key, $default);
    }

    /**
     * @param string            $key
     * @param string|array|null $default
     *
     * @return string|array
     */
    public function cookie($key = null, $default = null) {

        return $this->query($this->_cookie, $key, $default);
    }

    /**
     * @param string            $key
     * @param string|array|null $default
     *
     * @return string|array
     */
    public function server($key = null, $default = null) {

        return $this->query($this->_server, $key, $default);
    }

    /**
     * @param string            $key
     * @param string|array|null $default
     *
     * @return string|array
     */
    public function input($key = null, $default = null) {

        return $this->query($this->_input_stream, $key, $default);
    }

    /**
     * Извлечение данных из тела запроса
     *
     * @return array
     */
    private function getInputStream() {

        $input = file_get_contents('php://input');

        return (!empty($input)) ? json_decode($input, true) : array();
    }

    /**
     * @param array             $array
     * @param string            $key
     * @param string|array|null $default
     *
     * @return array|string
     */
    private function query($array, $key, $default) {

        if (!empty($key)) {
            if (!empty($array[$key])) {
                return $array[$key];
            } else {
                return (isset($default)) ? $default : null;
            }
        }

        return $array;
    }
}