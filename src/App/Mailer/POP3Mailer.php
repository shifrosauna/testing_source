<?php

namespace App\Mailer;

class POP3Mailer extends AbstractMailer {

    public function __construct() {

        parent::__construct();

        $this->mail->Sender = $this->conf->from;
    }
}