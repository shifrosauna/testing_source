<?php

namespace Infrastructure;

use App\BaseModel;
use App\DataBase;

abstract class AbstractRepository {

    /**
     * Хранитель подключения к БД
     *
     * @var DataBase
     */
    protected $db;

    /**
     * Имя основной таблицы репозитория
     *
     * @var string
     */
    protected $table;

    /**
     * Алиас для таблицы
     *
     * @var string
     */
    protected $name;

    /**
     * Название колонки в дочерних таблицах для связи с основной таблицей
     *
     * @var string
     */
    protected $joinId;

    /**
     * @deprecated
     */
    protected $db_table_name;

    /**
     * @deprecated
     */
    protected $db_join_id;

    public function __construct() {

        $this->db = DataBase::instance();
    }

    /**
     * Insert entity into the main table
     *
     * @param BaseModel $item
     *
     * @return int $id
     */
    abstract public function insert($item);

    /**
     * Update entity from the main table
     *
     * @param BaseModel $item
     */
    abstract public function update($item);

    /**
     * Find one row from table by unique id
     *
     * @param int $id
     *
     * @return object
     */
    public function findById($id) {

        $sth = $this->db->prepare("SELECT * FROM {$this->table} WHERE id=?");
        $sth->execute([$id]);

        return $sth->fetch();
    }

    /**
     * Find many rows from table by filters
     *
     * @param array $options
     *
     * @return array
     */
    public function findBy($options = []) {

        $where = [];
        $params = [];
        $order = "";

        if (!empty($options['joins'])) {
            foreach ($options['joins'] as $table) {
                $fields[] = $this->fieldsTable($table);
                $joins[] = $this->joinTable($table);
            }
        }

        if (!empty($options['filters'])) {
            foreach ($options['filters'] as $field => $value) {
                $params[] = $value;
                $where[] = $field . "=?";
            }
        }

        if (!empty($options['order'])) {

            $order = [];
            foreach ($options['order'] as $field => $direction) {
                $order[] = $field . " " . $direction;
            }
            $order = "ORDER BY " . implode(", ", $order);
        }

        $where = (!empty($where)) ? " WHERE " . implode(" AND ", $where) : "";

        $sth = $this->db->prepare("SELECT * FROM {$this->db_table_name} {$where} {$order}");
        $sth->execute($params);

        return $sth->fetchAll();
    }

    /**
     * Find one row from table by filters
     *
     * @param array $filters
     *
     * @return object
     */
    public function findOneBy($filters) {

        $params = [];
        $where = [];

        foreach ($filters as $field => $value) {
            $params[] = $value;
            $where[] = $field . "=?";
        }

        $where = (!empty($where)) ? "WHERE " . implode(" AND ", $where) : "";

        $sth = $this->db->prepare("SELECT * FROM {$this->db_table_name} {$where} LIMIT 1");
        $sth->execute($params);

        return $sth->fetch();
    }

    /**
     * Find one row from main and joined tables by unique id
     *
     * @param int   $id
     * @param array $with - joined tables
     *
     * @return object
     */
    public function findByIdWith($id, $with) {

        $fields = ["{$this->db_table_name}.*"];
        $joins = [];

        foreach ($with as $table) {
            $fields[] = "{$table}.* EXCEPT {$table}.{$this->db_join_id}";
            $joins[] = "{$this->db_table_name}_{$table} as {$table} ON ({$this->db_table_name}.id = {$table}.{$this->db_join_id})";
        }

        $fields = implode(", ", $fields);
        $joins = implode(" ", $joins);

        $sth = $this->db->prepare("SELECT {$fields} FROM {$this->db_table_name} {$joins} WHERE {$this->db_table_name}.id=?");
        $sth->execute([$id]);

        return $sth->fetch();
    }

    /**
     * Delete one row from table by unique id
     *
     * @param int $id
     */
    public function deleteById($id) {

        $sth = $this->db->prepare("DELETE FROM {$this->db_table_name} WHERE id=?");
        $sth->execute([$id]);
    }

    protected function joinTable($joinTable) {

        $joinMethod = 'joinTable' . lcfirst($joinTable);
        if (!method_exists($this, $joinMethod)) {
            $joinMethod = 'joinTableDefault';
        }

        return $this->$joinMethod(lcfirst($joinTable));
    }

    protected function fieldsTable($joinTable, $filters = []) {

        $fieldsMethod = 'fieldsTable' . lcfirst($joinTable);
        if (!method_exists($this, $fieldsMethod)) {
            $fieldsMethod = 'fieldsTableDefault';
        }

        return $this->$fieldsMethod(lcfirst($joinTable), $filters);
    }

    protected function parseTable($joinTable, $value) {

        $parseMethod = 'parseTable' . lcfirst($joinTable);
        if (!method_exists($this, $parseMethod)) {
            $parseMethod = 'parseTableDefault';
        }

        return $this->$parseMethod($value);
    }

    /**
     * @param $joinTable
     *
     * @return string
     */
    private function joinTableDefault($joinTable) {

        return "LEFT JOIN {$this->table}_{$joinTable} AS {$joinTable} ON ({$joinTable}.{$this->joinId} = {$this->name}.id)";
    }

    /**
     * @param $joinTable
     *
     * @return string
     */
    private function fieldsTableDefault($joinTable, $filters) {

        return "array_agg(row_to_json({$joinTable}.*)) as {$joinTable}";
    }

    /**
     * @param $value
     *
     * @return mixed
     */
    private function parseTableDefault($value) {

        return json_decode($value);
    }
}