<?php

namespace App\Viewers;

class XmlViewer extends AbstractViewer {

    protected $_output_type = 'xml';

    protected function setData($data) {

        $this->http_headers[] = 'Content-type: text/xml';
        $this->http_headers[] = 'Content-Disposition: attachment; filename="' . $data['filename'] . '"';
        $this->data = $data['data'];
    }
}