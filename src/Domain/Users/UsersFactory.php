<?php

namespace Domain\Users;

class UsersFactory {

    /**
     * @return User
     */
    public static function create() {

        return new User;
    }

    /**
     * @param $data
     *
     * @return User
     */
    public static function createByData($data) {

        return new User($data);
    }
}
