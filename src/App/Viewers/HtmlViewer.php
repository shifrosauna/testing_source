<?php

namespace App\Viewers;

use App\Exceptions\ViewFileNotFoundException;
use App\Exceptions\LayoutFileNotFoundException;

class HtmlViewer extends AbstractViewer {

    protected $_output_type = 'html';

    public function __construct() {

        $this->viewVariables = new \stdClass;
    }

    protected function setData($data) {

        $this->setViews($data);

        if (!empty($data['view'])) {
            $this->setView($data['view']);
        }

        if (!empty($data['layout'])) {
            $this->setLayout($data['layout']);
        }

        $this->viewVariables->content = $this->view($this->_view);

        $this->data = $this->layout();
    }

    public function setViews($data) {

        if (!empty($data['output'])) {
            foreach ($data['output'] as $field => $value) {
                $this->viewVariables->$field = $value;
            }
        }

        if (!empty($data['views'])) {
            foreach ($data['views'] as $field => $viewName) {
                $this->viewVariables->$field = $this->view($viewName);
            }
        }
    }

    /**
     * Cast timestamp field to date format (YYYY-mm-dd HH:ii)
     *
     * @param timestamp $date
     *
     * @return string
     */
    public function toDatetime($date) {

        return substr($date, 0, 16);
    }

    /**
     * Cast timestamp field to date format (YYYY-mm-dd)
     *
     * @param timestamp $date
     *
     * @return string
     */
    public function toDate($date) {

        return substr($date, 0, 10);
    }

    /**
     * Cast timestamp field to time format (HH:ii)
     *
     * @param timestamp $date
     *
     * @return string
     */
    public function toTime($date) {

        return trim(substr($date, 11, 5));
    }

    /**
     * @param string $name
     *
     * @return string
     * @throws ViewFileNotFound
     */
    private function view($viewName) {

        $viewFilename = __DIR__ . '/../../../www/' . $this->_site_name . '/views/' . $viewName . '.tpl';

        if (!file_exists($viewFilename)) {
            throw new ViewFileNotFoundException($viewName, $viewFilename);
        }

        return $this->getFileContent($viewFilename);
    }

    /**
     * @param string $name
     *
     * @throws LayoutFileNotFound
     * @return string
     */
    private function layout() {

        $layoutFilename = __DIR__ . '/../../../www/' . $this->_site_name . '/layouts/' . $this->_layout . '.tpl';

        if (!file_exists($layoutFilename)) {
            throw LayoutFileNotFoundException($this->_layout);
        }

        return $this->getFileContent($layoutFilename);
    }

    /**
     * @param string $filename
     *
     * @return string
     */
    private function getFileContent($filename) {

        $output = '';
        $view = $this->viewVariables;
        // $lang = $this->lang;

        ob_start();
        require $filename;
        $output = ob_get_contents();
        ob_end_clean();

        return $output;
    }
}