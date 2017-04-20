<?php

namespace Domain\News;

class Lang extends \App\BaseModel {

    /**
     * Language RU EN FR ...
     *
     * @var string
     *
     */
    protected $lang;
    /**
     * News title
     *
     * @var string
     *
     */
    protected $title;
    /**
     * News description
     *
     * @var string
     *
     */
    protected $description;

    /**
     * @return string
     */
    public function getLang() {

        return $this->lang;
    }

    /**
     * @return string
     */
    public function getTitle() {

        return $this->title;
    }

    /**
     * @return string
     */
    public function getDescription() {

        return $this->description;
    }

    /**
     * @param $lang
     */
    public function setLang($lang) {

        $this->lang = $lang;
    }

    /**
     * @param $title
     */
    public function setTitle($title) {

        $this->title = $title;
    }

    /**
     * @param $description
     */
    public function setDescription($description) {

        $this->description = $description;
    }
}
