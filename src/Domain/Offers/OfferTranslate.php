<?php

namespace Domain\Offers;

use App\BaseModel;

class OfferTranslate extends BaseModel {

    /**
     * @var string
     */
    protected $lang;

    /**
     * @var string
     */
    protected $name;

    /**
     * @var string
     */
    protected $description;

    /**
     * @return string
     */
    public function lang() {

        return $this->lang;
    }

    /**
     * @return string
     */
    public function name() {

        return $this->name;
    }

    /**
     * @return string
     */
    public function description() {

        return $this->description;
    }

    /**
     * @param $name
     */
    public function setName($name) {

        $this->name = $name;
    }

    /**
     * @param $description
     */
    public function setDescription($description) {

        $this->description = $description;
    }

    /**
     * @param OfferTranslate $lang
     *
     * @return array
     */
    public function diff($lang) {

        $diff = [];

        if ($this->name() != $lang->name()) {
            $diff['name'] = [$this->name(), $lang->name()];
        }

        if ($this->description() != $lang->description()) {
            $diff['description'] = [$this->description(), $lang->description()];
        }
        

        return $diff;
    }
}
