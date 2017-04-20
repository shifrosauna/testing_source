<?php

namespace App\Exceptions;

use Domain\Users\User;

class AccessDeniedException extends BaseException {

    protected $_http_code = 403;

    /**
     * AccessDeniedException constructor.
     *
     * @param User $user
     */
    public function __construct(User $user) {

        parent::__construct("Access denied", 0, $this);

        $this->setContext($user->__toString());
    }
}