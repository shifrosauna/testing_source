<?php

namespace Domain\Users;

use \App\BaseModel;

class User extends BaseModel {

    /**
     * @var int
     */
    protected $id;

    /**
     * @var string
     */
    protected $login;

    /**
     * @var string
     */
    protected $email;

    /**
     * @var string
     */
    protected $hash;

    /**
     * @var array
     */
    protected $info;

    /**
     * @var string
     */
    protected $lang;

    /**
     * @var array
     */
    protected $permissions;

    /**
     * @return int $id
     */
    public function getId() {

        return $this->id;
    }

    /**
     * @param int $id
     */
    public function setId($id) {

        $this->id = $id;
    }

    /**
     * @return string $login
     */
    public function getLogin() {

        return $this->login;
    }

    /**
     * @param string $login
     */
    public function setLogin($login) {

        if ($this->login != $login) {

            $this->changes['login'] = $this->login;
            $this->login = $login;
        }
    }

    /**
     * @return string $email
     */
    public function getEmail() {

        return $this->email;
    }

    /**
     * @param string $email
     */
    public function setEmail($email) {

        if ($this->email != $email) {

            $this->changes['email'] = $this->email;
            $this->email = $email;
        }
    }

    /**
     * @return array $permissions
     */
    public function getPermissions() {

        return $this->permissions;
    }

    /**
     * @return string $hash
     */
    public function getHash() {

        return $this->hash;
    }

    /**
     * @param string $hash
     */
    public function setHash($hash) {

        $this->hash = $hash;
    }

    /**
     * @param string $field
     *
     * @return mixed $value
     */
    public function getInfo($field = '') {

        if (!empty($field)) {
            if (!empty($this->info->$field)) {
                return $this->info->$field;
            }
        } elseif (!empty($this->info)) {
            return $this->info;
        }

        return null;
    }

    /**
     * @param array $info
     */
    public function setInfo($info) {

        $this->info = $info;

        //if ($this->email != $email) {
        //    
        //    $this->changes['email'] = $this->email;
        //    $this->info = $info;
        //}
    }

    public function getLang() {

        return 'ru';
    }

    public function __toString() {

        return $this->id . '. ' . $this->login;
    }
}