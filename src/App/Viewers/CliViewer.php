<?php

namespace App\Viewers;

class CliViewer extends AbstractViewer {

    protected $_output_type = 'cli';

    protected function setData($data) {

        if (!empty($data['output'])) {

            if (is_array($data['output'])) {

                $output = '';

                foreach ($data['output'] as $key => $value) {
                    $output .= $key . ': ' . $value . PHP_EOL;
                }

                $this->data = $output;

            } else {
                $this->data = $data['output'] . PHP_EOL;
            }
        }
    }
}