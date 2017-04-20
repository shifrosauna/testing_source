<?php

namespace App\Viewers;

class CsvViewer extends AbstractViewer {

    protected $_output_type = 'csv';

    protected function setData($data) {

        $this->http_headers[] = 'Content-type: text/csv; charset=UTF-8';
        $this->http_headers[] = 'Content-Disposition: attachment; filename="' . $data['filename'] . '"';
        $this->data = $data['data'];
    }
}