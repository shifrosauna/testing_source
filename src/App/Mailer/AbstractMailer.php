<?php

namespace App\Mailer;

use App\Configuration;
use App\Exceptions\BaseException;
use App\Exceptions\FileNotFoundException;

/**
 * Examples of use
 *
 * $mailer = MailerFactory::get('POP3');
 * $mailer->init(array(
 *     'subject'    => 'Hello',
 *     'body'       => 'Can you find me?'
 * ));
 *
 * $mailer->sendMail('bing@microsoft.ru');
 *
 * $mailer->sendMails(array(
 *     'support@google.com',
 *     'support@yandex.ru'
 * ));
 */
abstract class AbstractMailer {

    /**
     * @var Configuration
     */
    protected $conf;
    
    /**
     * @var \PHPMailer
     */
    protected $mail;

    /**
     * Init default settings of PHPMailer
     */
    public function __construct() {

        $this->conf = Configuration::get('mailer');

        $this->mail = new \PHPMailer;
        $this->mail->isHTML(true);
        $this->mail->CharSet = "utf-8";
    }

    /**
     * Set a subject and body of the email.
     * And also, if desired, attachments, and the sender's name.
     *
     * @param array $options
     *
     *      required
     *          string $subject: mail subject
     *          string $body: mail body
     *
     *      optional:
     *          string $from: sender address
     *          string $from_name: sender name
     *          array $attachments: mail attachments
     *              file: path to file
     *              name: filename
     *
     * @throws BaseException
     * @throws FileNotFoundException
     */
    public function init($options) {

        if (empty($options) || empty($options['subject']) || empty($options['body'])) {
            throw new BaseException('Wrong params');
        }

        if (empty($options['from'])) {
            $options['from'] = $this->conf->from;
            $options['from_name'] = $this->conf->from_name;
        }

        if (empty($options['from_name'])) {
            $options['from_name'] = '';
        }

        $this->mail->Subject = $options['subject'];
        $this->mail->Body = $options['body'];
        $this->mail->setFrom($options['from'], $options['from_name']);

        if (!empty($options['attachments'])) {
            foreach ($options['attachments'] as $attachment) {

                if (empty($attachment['file']) && !empty($attachment['name'])) {
                    throw new BaseException('Wrong params');
                }

                if (!file_exists($attachment['file'])) {
                    throw new FileNotFoundException($attachment['file']);
                }

                $this->mail->addAttachment($attachment['file'], $attachment['name']);
            }
        }

        if (!empty($options['attachment']) && !empty($options['attachment']['file']) && !empty($options['attachment']['name']) && file_exists($options['attachment']['file'])) {
            $this->mail->addAttachment($options['attachment']['file'], $options['attachment']['name']);
        }
    }

    /**
     * Send an email to the given address
     *
     * @param string $email
     *
     * @throws BaseException
     */
    public function sendMail($email) {

        $this->mail->clearAddresses();
        $this->mail->addAddress($email, '');

        if (!$this->mail->send()) {
            throw new BaseException($this->mail->ErrorInfo);
        }
    }

    /**
     * Send an email to the given addresses
     *
     * @param array $receivers
     *
     * @throws BaseException
     */
    public function sendMails($receivers) {

        $errors = array();

        foreach ($receivers as $email) {

            $this->mail->clearAddresses();
            $this->mail->addAddress($email, '');

            if (!$this->mail->send()) {
                $errors[] = $email . ': ' . $this->mail->ErrorInfo;
            }
        }

        if (!empty($errors)) {
            throw new BaseException($errors);
        }
    }
}