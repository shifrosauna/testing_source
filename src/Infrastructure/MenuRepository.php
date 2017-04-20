<?php

namespace Infrastructure;

class MenuRepository extends AbstractRepository {

    protected $db_table_name = 'menu';
    protected $db_join_id    = 'item_id';

    /**
     * Insert menu item into the main table
     *
     * @param MenuItem $item
     */
    public function insert($item) {

        $values = array(
            $item->getUrl(),
            $item->getTitle(),
            $item->getIcon(),
            $item->getParentId(),
            $item->getPermissionId(),
            $item->getWeight(),
        );

        $sth = $this->db->prepare("INSERT INTO {$this->db_table_name} (url,title,icon,parent_id,permission_id,weight) VALUES (?,?,?,?,?,?)");
        $sth->execute($values);
    }

    /**
     * Update menu item from the main table
     *
     * @param MenuItem $item
     */
    public function update($item) {

        $values = array(
            $item->getUrl(),
            $item->getTitle(),
            $item->getIcon(),
            $item->getParentId(),
            $item->getPermissionId(),
            $item->getWeight(),
            $item->getId(),
        );

        $sth = $this->db->prepare("UPDATE {$this->db_table_name} SET url=?, title=?, icon=?, parent_id=?, permission_id=?, weight=? WHERE id=?");
        $sth->execute($values);
    }

    /**
     * Get menu items by user's permissions
     *
     * @param array $permissions
     *
     * @return array
     */
    public function findByUserPermissions($permissions) {

        $sth = $this->db->prepare("
            SELECT * FROM {$this->db_table_name}
            WHERE permission_id IN (" . implode(",", $permissions) . ")
            ORDER BY parent_id, weight
        ");

        return $sth->execute()->fetchAll();
    }
}