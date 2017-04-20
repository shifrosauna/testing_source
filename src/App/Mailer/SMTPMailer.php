<?php

namespace App\Mailer;

class SMTPMailer extends AbstractMailer {

    public function __construct() {

        parent::__construct();

        $this->mail->isSMTP();
        $this->mail->SMTPDebug = 0;
        $this->mail->SMTPAuth = 'login';
        $this->mail->Host = $this->conf->smtp_host;
        $this->mail->Username = $this->conf->smtp_user;
        $this->mail->Password = $this->conf->smtp_pass;
    }
}