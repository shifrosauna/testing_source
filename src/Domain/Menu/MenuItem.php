<?php

namespace Domain\Menu;

use \App\BaseModel;

class MenuItem extends BaseModel {

    /**
     * @var int
     */
    protected $id;

    /**
     * @var string
     */
    protected $url;

    /**
     * @var string
     */
    protected $icon;

    /**
     * @var string
     */
    protected $title;

    /**
     * @var int
     */
    protected $parent_id;

    /**
     * @var int
     */
    protected $weight;

    /**
     * @return int $id
     */
    public function getId() {

        return $this->id;
    }

    /**
     * @return string $url
     */
    public function getUrl() {

        return $this->url;
    }

    /**
     * @return string $icon
     */
    public function getIcon() {

        return $this->icon;
    }

    /**
     * @return string $title
     */
    public function getTitle() {

        return $this->title;
    }

    /**
     * @return int $parent_id
     */
    public function getParentId() {

        return $this->parent_id;
    }

    /**
     * @return int $weight
     */
    public function getWeight() {

        return $this->weight;
    }

    /**
     * @param string $url
     */
    public function setUrl($url) {

        $this->url = $url;
    }

    /**
     * @param string $icon
     */
    public function setIcon($icon) {

        $this->icon = $icon;
    }

    /**
     * @param string $title
     */
    public function setTitle($title) {

        $this->title = $title;
    }
}