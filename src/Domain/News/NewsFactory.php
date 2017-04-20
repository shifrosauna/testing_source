<?php

namespace Domain\News;

class NewsFactory {

    /**
     * @return Item
     */
    public static function createItem() {

        return new Item;
    }

    /**
     * @param $data
     *
     * @return Item
     */
    public static function createByData($data) {

        return new Item($data);
    }

    /**
     * @param $data
     *
     * @return Lang
     */
    public static function createLangByData($data) {

        return new Lang($data);
    }
}