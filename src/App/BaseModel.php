<?php

namespace App;

abstract class BaseModel {

    /**
     * @var array
     */
    protected $changes = [];
    
    /**
     * @var array
     */
    protected $diff = [];

    public function __construct($data = array()) {

        if (!empty($data)) {
            foreach ($data as $field => $value) {
                $field = self::prepareField($field);
                $this->$field = $value;
            }
        }
    }

    /**
     * @return array
     */
    public function log() {

        $log = array('before' => array(), 'after' => array());

        foreach ($this->changes as $field => $value) {
            $log['before'][$field] = $value;
            $log['after'][$field] = $this->$field;
        }

        return $log;
    }

    /**
     * Existing object must have non-empty property id
     *
     * @return boolean
     */
    public function isExist() {

        return !empty($this->id);
    }

    protected function prepareField($field) {

        $arr = explode('_', $field);
        if (count($arr) == 1) {
            return $field;
        }

        $result = '';
        foreach ($arr as $value) {
            $result = $result . ucfirst($value);
        }

        return lcfirst($result);
    }
}