<?php

namespace App;

use App\Exceptions\FatalException;
use App\Exceptions\NotFoundException;

class Configuration {

    private static $config = array();

    /**
     * Get settings for config section
     *
     * @param string $name Section name
     *
     * @return \stdClass
     * @throws FatalException
     * @throws NotFoundException
     */
    public static function get($name) {

        if (empty(self::$config)) {

            $settings = self::getSettings();
            self::setSections($settings);
            self::setNetworkId();
        }

        if (!isset(self::$config[$name])) {
            throw new NotFoundException("Config not found.");
        }

        return self::$config[$name];
    }

    /**
     * Read config file and return it as array of sections
     *
     * @return array
     * @throws NotFoundException
     */
    private static function getSettings() {

        $filename = realpath(__DIR__ . "/../Resources/Configs/settings.local.ini");
        if (!file_exists($filename)) {
            throw new NotFoundException("Config not found.");
        }

        return parse_ini_file($filename, true);
    }

    /**
     * Set config variable by sections settings
     *
     * @param array $settings
     */
    private static function setSections($settings) {

        foreach ($settings as $section => $values) {

            self::$config[$section] = new \stdClass;

            foreach ($values as $field => $value) {
                self::$config[$section]->$field = $value;
            }
        }
    }

    /**
     * Set global variable nid to the System section
     *
     * @throws FatalException
     */
    private static function setNetworkId() {

        $nid = 0;

        if (!empty($_SERVER['HTTP_HOST'])) {

            $domain = $_SERVER['HTTP_HOST'];
            if (empty(self::$config['networks_domains']->$domain)) {
                throw new FatalException('Unknown network');
            }

            $nid = self::$config['networks_domains']->$domain;
        }

        self::$config['system']->nid = $nid;
    }
}