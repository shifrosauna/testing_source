<?php

namespace App\Interfaces;

interface RepositoryInterface {

    /**
     * Find one row from table by unique id
     *
     * @param int $id
     *
     * @return object
     */
    public function findById($id);

    /**
     * Find many rows from table by filters
     *
     * @param array $filters
     *
     * @return array
     */
    public function findBy($filters);
}