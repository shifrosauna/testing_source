<?php

namespace App\Viewers;

class JsonViewer extends AbstractViewer {

    protected $_output_type = 'json';

    protected function setData($data) {

        $this->http_headers[] = 'Content-type: application/json; charset=UTF-8';

        if (!empty($data)) {
            $this->data = json_encode($data);
        }
    }
}