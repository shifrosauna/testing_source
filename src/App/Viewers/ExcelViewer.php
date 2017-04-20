<?php

namespace App\Viewers;

class ExcelViewer extends AbstractViewer {

    protected $_output_type = 'excel';

    protected function setData($data) {

        $this->http_headers[] = 'Content-type: vnd.ms-excel';
        $this->http_headers[] = 'Content-Disposition: attachment; filename="' . $data['filename'] . '"';
        $this->data = $data['data'];
    }
}