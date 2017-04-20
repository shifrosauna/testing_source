<?php

namespace Infrastructure;

use App\Configuration;
use Domain\Users\User;

class UsersRepository extends AbstractRepository {

    protected $name   = 'users';
    protected $joinId = 'user_id';

    // Backward capability
    protected $join_id = 'user_id';

    public function __construct() {

        parent::__construct();

        $this->table = '_' . Configuration::get('system')->nid . '_' . $this->name;

        // Backward capability
        $this->db_table_name = '_' . Configuration::get('system')->nid . '_' . $this->name;
    }

    /**
     * Insert user into the main table
     *
     * @param User $user
     *
     * @return int $affId
     */
    public function insert($user) {

        $values = array($user->getLogin(), $user->getEmail(), $user->getHash());

        $sth = $this->db->prepare("INSERT INTO {$this->table} (login,email,hash) VALUES (?,?,?) RETURNING id");
        $sth->execute($values);
        $affId = $sth->fetchColumn();

        return $affId;
    }

    /**
     * Update user from the main table
     *
     * @param User $user
     */
    public function update($user) {

        $values = array($user->getLogin(), $user->getEmail(), $user->getHash(), $user->getId());

        $sth = $this->db->prepare("UPDATE {$this->table} SET login=?, email=?, hash=?, date_u=now() WHERE id=?");
        $sth->execute($values);
    }

    public function updateRefId($aff_id, $ref_id) {

        $sth = $this->db->prepare("UPDATE {$this->table} SET ref_id=?, date_u=now() WHERE id=?");
        $sth->execute([$ref_id, $aff_id]);
    }

    /**
     * Insert sub-fields of user into the info table
     *
     * @param User $user
     */
    public function insertInfo($user) {

        $params = array('?');
        $fields = array('user_id');
        $values = array($user->getId());

        foreach ($user->getInfo() as $field => $value) {
            $fields[] = $field;
            $values[] = $value;
            $params[] = '?';
        }

        $sth = $this->db->prepare("INSERT INTO {$this->table}_info (" . implode(",", $fields) . ") VALUES (" . implode(",", $params) . ")");
        $sth->execute($values);
    }

    public function updateHash($user) {

        $values = array($user->getHash(), $user->getId());

        $sth = $this->db->prepare("UPDATE {$this->table} SET hash=?, date_u=now() WHERE id=?");
        $sth->execute($values);
    }

    /**
     * Get array of User's permissions by id
     *
     * @param int $id
     *
     * @return array
     */
    public function getPermissionsByUserId($id) {

        $permissions = array();

        $sth = $this->db->prepare("
            SELECT permissions.module, permissions.action
            FROM {$this->table} AS users
            LEFT JOIN {$this->table}_access AS access ON (access.group_id = ANY (users.groups) OR access.group_id = 0)
            LEFT JOIN {$this->table}_permissions AS permissions ON (access.permission_id = permissions.id AND permissions.status = 1)
            WHERE users.id=?
        ");

        $sth->execute([$id]);
        while ($row = $sth->fetch()) {

            if (empty($permissions[$row->module])) {
                $permissions[$row->module] = array();
            }

            $permissions[$row->module][] = $row->action;
        }

        return $permissions;
    }

    /**
     * Get array of User's permission_id by id
     *
     * @param int $id
     *
     * @return array
     */
    public function getPermissionsIdsByUserId($id) {

        $permissions = array();

        $sth = $this->db->prepare("
            SELECT permissions.id
            FROM {$this->table} AS users
            LEFT JOIN {$this->table}_access AS access ON (access.group_id = ANY (users.groups) OR access.group_id = 0)
            LEFT JOIN {$this->table}_permissions AS permissions ON (access.permission_id = permissions.id AND permissions.status = 1)
            WHERE {$this->table}.id=?
        ");

        $sth->execute([$id]);
        while ($row = $sth->fetch()) {
            $permissions[] = $row->id;
        }

        return $permissions;
    }

    public function getFinance($user_id) {

        $sth = $this->db->prepare("SELECT SUM(payout) AS total FROM stat_month WHERE aff_id=?");

        return $sth->execute([$user_id])->fetch();
    }

    public function getInfo($user_id) {

        $sth = $this->db->prepare("SELECT * FROM {$this->table}_info WHERE user_id=?");
        $info = $sth->execute([$user_id])->fetch();

        if (!$info) {
            return null;
        }

        return $info;
    }

    public function findPartners($with) {

        $fields = array("{$this->table}.*");
        $joins = array();

        foreach ($with as $table) {

            if ($table == 'referrals') {
                $fields[] = "referrals.login AS ref_partner";
                $joins[] = "LEFT JOIN {$this->table} AS referrals ON (referrals.id = {$this->table}.ref_id)";
            } else {
                $fields[] = "row_to_json({$table}.*) AS {$table}";
                $joins[] = "LEFT JOIN {$this->table}_{$table} AS {$table} ON ({$this->table}.id = {$table}.{$this->joinId})";
            }
        }

        $fields = implode(", ", $fields);
        $joins = implode(" ", $joins);

        $sth = $this->db->prepare("
            SELECT {$fields}
            FROM {$this->table} AS users
            {$joins}
            WHERE 0 = ANY ({$this->table}.groups) OR 6 = ANY (users.groups) OR COALESCE(array_length(users.groups, 1), 0) = 0
        ");

        $rows = $sth->execute([])->fetchAll();
        foreach ($rows as $row) {
            if (!empty($row->info)) {
                $row->info = json_decode($row->info);
            }
        }

        return $rows;
    }
}