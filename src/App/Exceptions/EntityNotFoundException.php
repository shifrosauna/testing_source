<?php

namespace App\Exceptions;

class EntityNotFoundException extends NotFoundException {
    
    protected $_http_code = 404;

    public function __construct($entity, $filters) {

        $message = (is_array($filters)) ? $entity . ' not found by query [' . http_build_query($filters, null, ', ') . ']' : $entity . '#' . $filters . ' not found';

        parent::__construct($message);
    }
}