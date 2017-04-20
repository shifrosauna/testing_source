<?php
/**
 * @author  col.shrapnel@gmail.com
 * @license Apache license 2.0
 **/

namespace App;

use App\Exceptions\DataBaseException;

class DataBase {

    protected static $instance = null;

    final private function __construct() { }

    public static function instance() {

        if (self::$instance === null) {

            $conf = Configuration::get('database');

            $options = array(
                \PDO::ATTR_ERRMODE            => \PDO::ERRMODE_EXCEPTION,
                \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_OBJ,
                \PDO::ATTR_EMULATE_PREPARES   => true,
                \PDO::ATTR_STATEMENT_CLASS    => array('App\customPDOStatement'),
            );

            try {
                self::$instance = new \PDO('pgsql:host=' . $conf->host . ';port=' . $conf->port . ';dbname=' . $conf->name, $conf->user, $conf->pass, $options);
            } catch (\PDOException $e) {
                throw new DataBaseException($e);
            }

        }

        return self::$instance;
    }

    public static function __callStatic($method, $args) {

        try {
            return call_user_func_array(array(self::instance(), $method), $args);
        } catch (\PDOException $e) {
            throw new DataBaseException($e);
        }
    }

    final private function __clone() { }
}

class customPDOStatement extends \PDOStatement {

    function execute($data = array()) {

        try {
            parent::execute($data);
        } catch (\PDOException $e) {
            throw new DataBaseException($e);
        }

        return $this;
    }
}