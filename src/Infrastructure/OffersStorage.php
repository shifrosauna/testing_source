<?php

namespace Infrastructure;

use App\Exceptions\BaseException;
use Domain\Offers\Offer;

class OffersStorage extends AbstractStorage {

    protected $_path_icons = '';
    protected $_url_icons  = '';

    protected $_path_screens = '';
    protected $_url_screens  = '';

    public function __construct() {

        parent::__construct();

        $this->_path_icons = $_SERVER['DOCUMENT_ROOT'] . '/public/offers/icons/';
        $this->_url_icons = '/offers/icons/';

        $this->_path_screens = $_SERVER['DOCUMENT_ROOT'] . '/public/offers/screens/';
        $this->_url_screens = '/offers/screens/';
    }

    /**
     * Upload icon to server
     *
     * @param Offer $offer
     *
     * @throws BaseException
     */
    public function uploadIcon($offer) {

        $iconName = $offer->id() . '.png';
        $iconPath = $this->_path_icons . $iconName;

        // Upload to server
        if (!move_uploaded_file($offer->icon()['tmp_name'], $iconPath)) {
            throw new BaseException("File upload error (icon for offer#" . $offer->id() . ")");
        }
    }

    /**
     * Load icon to Offer model
     *
     * @param Offer $offer
     */
    public function loadIcon($offer) {

        $offer->set('icon', 'no_photo.png');

        $iconPath = $this->_path_icons . $offer->id() . '.png';
        if (file_exists($iconPath)) {
            $offer->set('icon', $this->_url_icons . $offer->id() . '.png');
        }
    }

    /**
     * Upload screens to server
     *
     * @param Offer $offer
     *
     * @throws BaseException
     */
    public function uploadScreens($offer) {

        $screensPath = $this->_path_screens . $offer->id();
        if (!is_dir($screensPath)) {
            mkdir($screensPath);
        }

        foreach ($offer->screens['name'] as $i => $name) {

            $screenPath = $screensPath . '/' . $name;

            // Upload to server
            if (!move_uploaded_file($offer->screens['tmp_name'][$i], $screenPath)) {
                throw new BaseException("File upload error (screen " . $name . " for offer#" . $offer->id() . ")");
            }
        }
    }

    /**
     * Load screens to Offer model
     *
     * @param Offer $offer
     */
    public function loadScreens($offer) {

        $offer->screens = array();

        $screensPath = $this->_path_screens . $offer->id();
        if (is_dir($screensPath)) {

            $screens = scandir($screensPath);
            foreach ($screens as $screen) {
                if ($screen != '.' && $screen != '..') {
                    $offer->screens[$screen] = $this->_url_screens . $offer->id() . '/' . $screen;
                }
            }
        }
    }

    /**
     * @param Offer $offer
     */
    public function deleteScreens($offer) {

        $screensPath = $this->_path_screens . $offer->id();
        foreach ($offer->delete_screens as $screen) {

            $screenPath = $screensPath . '/' . $screen;
            if (file_exists($screenPath)) {
                unlink($screenPath);
            }
        }
    }
}