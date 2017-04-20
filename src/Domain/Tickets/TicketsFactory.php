<?php

namespace Domain\Tickets;

class TicketsFactory {

    public static function create() {

        return new Ticket;
    }

    public static function createByData($data) {

        $ticket = new Ticket;

        foreach ($data as $field => $value) {
            $ticket->set($field, $value);
        }

        return $ticket;
    }
}