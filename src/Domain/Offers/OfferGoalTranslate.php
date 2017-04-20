<?php
/**
 * Created by PhpStorm.
 * User: user
 * Date: 09.06.16
 * Time: 15:12
 */

namespace Domain\Offers;

use App\BaseModel;

class OfferGoalTranslate extends BaseModel{
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
     * @param OfferGoalTranslate $lang
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