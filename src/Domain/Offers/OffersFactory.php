<?php

namespace Domain\Offers;

use Infrastructure\OffersRepository;

class OffersFactory {

    /**
     * @var OffersRepository
     */
    protected static $repository;

    public static function create() {

        return new Offer;
    }

    public static function createByData($data) {

        $offer = new Offer;

        foreach ($data as $field => $value) {

            switch ($field) {

                case 'payout':
                case 'revenue':

                    $offer->set($field, floatval($value));

                    break;

                case 'tracking':

                    $trackings = (array)$value;

                    foreach ($trackings as $trackingData) {
                        $offer->addTracking(new OfferTracking($trackingData));
                    }

                    break;

                case 'goals':

                    $goals = (array)$value;

                    foreach ($goals as $goalData) {
                        $offer->addGoal(new OfferGoal($goalData));
                    }

                    break;

                case 'translates':

                    $translates = (array)$value;

                    foreach ($translates as $translateData) {

                        $translateData = (array)$translateData;
                        $offer->addTranslate(new OfferTranslate($translateData));
                    }

                    break;

                default:

                    $offer->set($field, $value);

                    break;
            }
        }

        return $offer;
    }

    public static function repository() {

        if (empty(self::$repository)) {
            self::$repository = new OffersRepository;
        }

        return self::$repository;
    }
}