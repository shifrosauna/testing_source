<?php

namespace Domain\Tickets;

class Ticket extends \App\BaseModel {

    public $id;
    public $subject;
    public $description;

    private $changes = array();

    public function __construct() {

    }

    public function set($field, $value) {

        $this->$field = $value;
    }

    public function getId() {

        return $this->id;
    }

    public function getSubject() {

        return $this->subject;
    }

    public function getDescription() {

        return $this->description;
    }

    public function change($field, $value) {

        if (isset($this->$field)) {
            $changes[$field] = array(
                'before' => $this->$field,
                'after'  => $value,
            );

            $this->set($field, $value);
        }
    }

    public function getValuesForInsert() {

        return array(
            $this->date_c,
            $this->title,
            $this->description,
        );
    }

    public function toDate($field) {

        return substr($this->$field, 0, 10);
    }

    public function toDateTime($field) {

        return substr($this->$field, 0, 16);
    }

    public function toTime($field) {

        return trim(substr($this->$field, 11, 5));
    }
}