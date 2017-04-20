<?php

namespace App\Mailer;

use App\Exceptions\NotFoundException;

class MailerFactory {

    public static function get($mailer_protocol) {

        switch ($mailer_protocol) {
            case 'SMTP':
            case 'POP3':

                $mailer_class = '\App\Mailer\\' . $mailer_protocol . 'Mailer';

                return new $mailer_class;

            default:
                throw new NotFoundException('Mailer for ' . $mailer_protocol . ' protocol not found.');
        }
    }
}