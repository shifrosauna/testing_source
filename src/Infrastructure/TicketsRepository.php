<?php

namespace Infrastructure;

class TicketsRepository extends AbstractRepository {

    protected $db_table_name = 'tickets';
    protected $db_join_id    = 'ticket_id';

    public function insert($ticket) {

        $values = array(
            $ticket->theme,
            $ticket->description,
            $ticket->category_id,
            $ticket->priority_id,
            $ticket->owner_id,
            $ticket->owner_name,
            $ticket->assigned_id,
            $ticket->status,
        );

        $stmt = $this->db->prepare("
            INSERT INTO {$this->db_table_name} (theme,description,category_id,priority_id,owner_id,owner_name,assigned_id,status)
            VALUES (?,?,?,?,?,?,?,?)
        ");

        $stmt->execute($values);
    }

    public function update($ticket) {

        $values = array(
            $ticket->theme,
            $ticket->description,
            $ticket->category_id,
            $ticket->priority_id,
            $ticket->owner_id,
            $ticket->owner_name,
            $ticket->assigned_id,
            $ticket->status,
            $ticket->id,
        );

        $stmt = $this->db->prepare("
            UPDATE {$this->db_table_name}
            SET theme=?, description=?, category_id=?, priority_id=?, owner_id=?, owner_name=?, assigned_id=?, status=?, date_u=now()
            WHERE id=?
        ");

        $stmt->execute($values);
    }

    public function getCategories() {

        $sth = $this->db->prepare("SELECT * FROM tickets_categories ORDER BY id");

        return $sth->execute(array())->fetchAll();
    }

    public function getPriorities() {

        $sth = $this->db->prepare("SELECT * FROM tickets_priorities ORDER BY id");

        return $sth->execute()->fetchAll();
    }
}