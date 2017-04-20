<?php

namespace App\Interfaces;

interface MailerInterface {

    /**
     * Init mail connection
     */
    public function __construct();

    /**
     * init mail
     *
     * @param array $options
     *
     *      required
     *          string $subject: mail subject
     *          string $body: mail body
     *          string $from: sender address
     *
     *      optional:
     *          string $from_name: sender name
     *          array $attachments: mail attachments
     *              file: path to file
     *              name: filename
     */
    public function init($options);

    /**
     * Send mail
     *
     * @param string $email
     */
    public function sendMail($email);

    /**
     * Send mails
     *
     * @param array $receivers
     */
    public function sendMails($receivers);
}