<?php

namespace Infrastructure;

abstract class AbstractStorage {

    public function __construct() { }

    /**
     * Логирование в файл
     *
     * файл: logs/{$name}_yyyy-mm.log'
     * сообщение: Y-m-d H:i:s {$message}
     *
     * @param $name
     * @param $message
     */
    public function log($name, $message) {

        if (is_array($message)) {

            $msg = array();
            foreach ($message as $field => $value) {
                $msg[] = (is_array($value)) ? $field . ':[' . implode(',', $value) . ']' : $field . ':' . $value;
            }

            $msg = implode(' ', $msg);
        } else {
            $msg = $message;
        }

        $logFileName = $_SERVER['DOCUMENT_ROOT'] . '/../../logs/' . $name . '_' . date("Y-m") . '.log';
        error_log(PHP_EOL . date("Y-m-d H:i:s") . ' ' . $msg, 3, $logFileName);
    }

    /**
     * Удаление файла с диска
     *
     * @param string $path
     *
     * @return bool
     */
    public function deleteFile($path) {

        return unlink($path);
    }

    /**
     * Определение размера локальноо файла
     *
     * в баятах, если $human == false
     * в удобочитаемом виде, если $human == true
     *
     * @param string $path
     * @param bool   $human
     *
     * @return int|string
     */
    public function getFileSizeByPath($path, $human = false) {

        $filesize = 0;

        if (!file_exists($path)) {
            return $filesize;
        }

        if (is_dir($path)) {
            foreach (new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($path)) as $file) {
                $filesize += $file->getSize();
            }
        } else {
            $filesize = filesize($path);
        }

        if ($human) {
            $filesize = $this->humanSize($filesize);
        }

        return $filesize;
    }

    /**
     * Определение размера удалённого файла по ссылке
     *
     * в баятах, если $human == false
     * в удобочитаемом виде, если $human == true
     *
     * @param string $url
     * @param bool   $human
     *
     * @return int|string
     */
    public function getFileSizeByUrl($url, $human = false) {

        // Assume failure.
        $filesize = -1;

        $curl = curl_init($url);

        curl_setopt($curl, CURLOPT_NOBODY, true);
        curl_setopt($curl, CURLOPT_HEADER, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);

        $data = curl_exec($curl);
        curl_close($curl);

        if ($data) {

            $content_length = "unknown";
            $status = "unknown";

            if (preg_match("/^HTTP\/1\.[01] (\d\d\d)/", $data, $matches)) {
                $status = (int)$matches[1];
            }

            if (preg_match("/Content-Length: (\d+)/", $data, $matches)) {
                $content_length = (int)$matches[1];
            }

            // http://en.wikipedia.org/wiki/List_of_HTTP_status_codes
            if ($status == 200 || ($status > 300 && $status <= 308)) {

                $filesize = $content_length;

                if ($human) {
                    $filesize = $this->humanSize($filesize);
                }
            }
        }

        return $filesize;
    }

    /**
     * Приведение размера файла к удобочитаемому виду
     * 
     * @param int $filesize
     *
     * @return string
     */
    public function humanSize($filesize) {

        $filesize = round($filesize / 1024, 2);
        if ($filesize >= 1024) {
            $filesize = $filesize / 1024;
            $filesize = round($filesize, 2) . ' Mb';
        } else {
            $filesize = round($filesize, 2) . ' Kb';
        }

        return $filesize;
    }
}