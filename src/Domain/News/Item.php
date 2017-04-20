<?php

namespace Domain\News;

use App\BaseModel;

class Item extends BaseModel {

    /**
     * @var int
     */
    protected $id;
    /**
     *  Переводы новости
     *
     * @var Lang[]
     */
    protected $langs;
    /**
     * @var string
     */
    protected $dateC;
    /**
     * @var string
     */
    protected $date;

    /**
     * @return array
     */
    public function output() {

        return [
            'id'    => $this->id,
            'date'  => $this->date,
            'langs' => $this->langs,
        ];
    }

    /**
     * @return Lang[]
     */
    public function getLangs() {

        return $this->langs;
    }

    /**
     * @return int $id
     */
    public function getId() {

        return $this->id;
    }

    public function getDate() {

        return $this->date;
    }

    /**
     * @return string $date_c
     */
    public function getDateC() {

        return $this->dateC;
    }

    /**
     * @param array $langs
     *
     * @return Lang[] $result
     */
    public function setLangs($langs) {

        foreach ($langs as $key => $value) {
            $item = new Lang();
            $item->setLang($key);
            $item->setTitle($value['title']);
            $item->setDescription($value['description']);

            $result[] = $item;
        }
        $this->langs = $result;
    }

    /**
     * @param string $dateC
     */
    public function setDateC($dateC) {

        if ($this->dateC !== $dateC) {

            $this->changes['dateC'] = $this->dateC;
            $this->dateC = $dateC;
        }
    }

    /**
     * @param string $date
     */
    public function setDate($date) {

        if ($this->date !== $date) {

            $this->changes['date'] = $this->date;
            $this->date = $date;
        }
    }

    /**
     * @return int $id
     */
    public function setId($id) {

        if ($this->id !== $id) {

            $this->id = $id;
        }
    }
}