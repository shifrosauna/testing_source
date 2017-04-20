<?php

namespace Domain\Offers;

use App\Exceptions\EntityNotFoundException;
use App\Exceptions\NotFoundException;
use App\Exceptions\ValidateException;
use Domain\Utils\UtilsService;
use Infrastructure\OffersStorage;
use Infrastructure\StatRepository;

class OffersService {

    private static $components = ['translates', 'tracking', 'goals'];

    /**
     * Restore Offer by unique id
     *
     * @param int    $id
     * @param string $lang
     * @param array  $joins
     *
     * @return Offer
     * @throws EntityNotFoundException
     */
    public static function findById($id, $lang = null, $joins = null) {

        if (empty($joins)) {
            $joins = self::$components;
        }

        $data = OffersFactory::repository()->findById($id, $lang, $joins);

        if (empty($data)) {
            throw new EntityNotFoundException('Offer', $id);
        }

        $offer = OffersFactory::createByData($data);

        return $offer;
    }

    /**
     * Find offers for user by user_id
     *
     * @param int     $userId
     * @param boolean $_admin
     *
     * @return array Offer[]
     */
    public static function findByUserId($userId, $_admin) {

        $offers = OffersFactory::repository()->findByUserId($userId, $_admin);

        foreach ($offers as $offer) {

            if (empty($offer->targeting->country)) {
                $offer->countries = 'Все страны';
            } else {

                $offer->countries_count = count($offer->targeting->country);
                $offer->countries = array();
                foreach ($offer->targeting->country as $country_code) {
                    $offer->countries[] = UtilsService::countryNameByCode($country_code);
                }
                $offer->countries = implode(', ', $offer->countries);
                if ($offer->countries_count > 5) {
                    $offer->countries_title = $offer->countries;
                    $offer->countries = $offer->countries_count . ' ' . UtilsService::pluralForm($offer->countries_count, array(
                            'страна',
                            'страны',
                            'стран',
                        ));
                }

                $offer->countries_payouts = array();
                $max_countries_payouts = 0;
                foreach ($offer->targeting->country as $i => $country_code) {
                    if (in_array($country_code, array('RU', 'US', 'CA')) && !empty($countriesPayouts[$country_code])) {
                        $country = $countriesPayouts[$country_code];
                        $offer->countries_payouts[$country->code] = $country;
                        if ($country->cpa > $max_countries_payouts) {
                            $max_countries_payouts = $country->cpa;
                        }
                    }
                }
                if (!empty($offer->countries_payouts)) {
                    usort($offer->countries_payouts, function ($a, $b) { return strcmp($b->cpa, $a->cpa); });
                    $offer->max_countries_payouts = $max_countries_payouts;
                }
            }
        }

        return $offers;
    }

    public static function loadUsersOptions($offer, $userId) {

        $offer->partner_tracking_link = self::$tracking_domain . '?offer_id=' . $offer->id . '&aff_id=' . $userId;
    }

    /**
     * @param array $joins
     *
     * @return Offer[] $offers
     */
    public static function findAllActive($joins = null) {

        if (empty($joins)) {
            $joins = self::$components;
        }

        $offers = OffersFactory::repository()->findBy([
            'joins'   => $joins,
            'filters' => [
                'offers' => ['status' => 'active'],
            ],
        ]);

        $result = [];
        foreach ($offers as $i => $offer) {
            $result[] = OffersFactory::createByData($offer);
        }

        return $result;
    }

    /**
     * @param array $joins
     *
     * @return Offer[] $offers
     */
    public static function findAll($joins = null) {

        if (empty($joins)) {
            $joins = self::$components;
        }

        $offers = OffersFactory::repository()->findBy(['joins' => $joins]);

        $result = [];
        foreach ($offers as $i => $offer) {
            $result[] = OffersFactory::createByData($offer);
        }

        return $result;
    }

    /**
     * Create
     *
     * @param array $data
     */
    public static function createOffer($data) {

        self::validate($data);

        $offer = OffersFactory::createByData($data);

        self::push($offer);
    }

    /**
     * Update
     *
     * @param Offer $offer
     * @param array $data
     *
     * @throws ValidateException
     */
    public static function updateOffer($offer, $data) {

        self::validate($data);

        $diff = $offer->diff(OffersFactory::createByData($data));

        if (!empty($diff)) {
            self::push($offer);
        }
    }

    /**
     * Delete
     *
     * @param Offer $offer
     */
    public static function deleteOffer($offer) {

        $offer->delete();

        self::push($offer);
    }

    public static function accessOffer($offer, $partner_id, $status) {

        switch ($status) {
            case 'approve':

                if (!empty($offer->blocked_affiliates)) {
                    if (($key = array_search($partner_id, $offer->blocked_affiliates)) !== false) {
                        unset($offer->blocked_affiliates[$key]);
                    }
                }

                $offer->approved_affiliates[] = $partner_id;

                OffersFactory::repository()->approvePartner($offer, $partner_id);

                break;
            case 'nonapprove':

                if (($key = array_search($partner_id, $offer->approved_affiliates)) !== false) {
                    unset($offer->approved_affiliates[$key]);
                }

                if (($key = array_search($partner_id, $offer->blocked_affiliates)) !== false) {
                    unset($offer->blocked_affiliates[$key]);
                }

                OffersFactory::repository()->nonapprovePartner($offer, $partner_id);

                break;
            case 'block':

                if (($key = array_search($partner_id, $offer->approved_affiliates)) !== false) {
                    unset($offer->approved_affiliates[$key]);
                }

                $offer->blocked_affiliates[] = $partner_id;

                OffersFactory::repository()->blockPartner($offer, $partner_id);

                break;

            default:
                throw new NotFoundException("Partner access status not found");
        }
    }

    /**
     * Push to database
     *
     * @param Offer $offer
     */
    public static function push($offer) {

        if (!$offer->isExist()) {

            OffersFactory::repository()->insert($offer);
        } else {

            OffersFactory::repository()->update($offer);
        }
    }

    public static function view($offer) {

        $offer->view = new \stdClass;

        if (!empty($offer->targeting->country)) {
            $countries = array();
            foreach ($offer->targeting->country as $country_code) {
                $countries[] = UtilsService::countryNameByCode($country_code) . ' (' . $country_code . ')';
            }
            $offer->view->countries = implode(', ', $countries);
        } else {
            $offer->view->countries = 'Все страны';
        }
    }

    public static function countriesPayouts($offer) {

        $offer->countries_payouts = array();

        $statRepository = new StatRepository;
        $countriesPayouts = $statRepository->loadCountriesPayouts();

        foreach ($offer->targeting->country as $i => $country_code) {
            if (!empty($countriesPayouts[$country_code])) {

                $country = $countriesPayouts[$country_code];
                $offer->countries_payouts[$country->code] = $country;
            }
        }

        usort($offer->countries_payouts, function ($a, $b) { return strcmp($b->cpa, $a->cpa); });
    }

    public static function log($name, $message) {

        $storage = new OffersStorage;
        $storage->log('offers/' . $name, $message);
    }

    /**
     * Проверка входных данных
     *
     * @param array $data
     *
     * @throws ValidateException
     */
    private static function validate($data) {

        $errors = [];

        if (empty($data['previewUrl'])) {
            $errors['previewUrl'] = 'empty';
        }

        if (empty($data['status'])) {
            $errors['status'] = 'empty';
        } elseif (!in_array($data['status'], ['active', 'paused', 'deleted', 'pending', 'expired'])) {
            $errors['status'] = 'wrong';
        }

        if (empty($data['availability'])) {
            $errors['availability'] = 'empty';
        } elseif (!in_array($data['availability'], ['open', 'alert', 'private'])) {
            $errors['availability'] = 'wrong';
        }

        /*if (empty($data['expiration_date'])) {
            $errors['expiration_date'] = 'empty';
        } elseif (!preg_match('/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/', $data['expiration_date'])) {
            $errors['expiration_date'] = 'wrong';
        }*/

        if (empty($data['translates'])) {
            $errors['translates'] = 'empty';
        } elseif ($errorsTranslates = self::validateTranslates($data['translates'])) {
            $errors['translates'] = $errorsTranslates;
        }

        if (empty($data['tracking'])) {
            $errors['tracking'] = 'empty';
        } elseif ($errorsTracking = self::validateTracking($data['tracking'])) {
            $errors['tracking'] = $errorsTracking;
        }

        if (!empty($data['goals'])) {
            if ($errorsTracking = self::validateGoals($data['goals'])) {
                $errors['goals'] = $errorsTracking;
            }
        }

        if (!empty($errors)) {
            throw new ValidateException($errors);
        }
    }

    private static function validateGoals($data) {

        $errors = [];
        foreach ($data as $goalId => $goal) {
            if (empty($goal['payout'])) {
                $errors[$goalId]['payout'] = 'empty';
            }
            if (empty($goal['payoutCurrency'])) {
                $errors[$goalId]['payoutCurrency'] = 'empty';
            }
            if (empty($goal['revenue'])) {
                $errors[$goalId]['revenue'] = 'empty';
            }
            if (empty($goal['revenueCurrency'])) {
                $errors[$goalId]['revenueCurrency'] = 'empty';
            }

            if (empty($goal['translates'])) {
                $errors[$goalId]['translates'] = 'empty';
            } elseif ($errorsTranslates = self::validateTranslates($goal['translates'])) {
                $errors[$goalId]['translates'] = $errorsTranslates;
            }
        }

        return $errors;
    }

    /**
     * Проверка переводов оффера
     *
     * @param array $data
     *
     * @return array $errors
     */
    private static function validateTranslates($data) {

        $errors = [];

        if (empty($data['ru'])) {

            $errors['ru'] = ['name' => 'empty', 'description' => 'empty'];
        } else {

            if (empty($data['ru']['name'])) {
                $errors['ru'] = ['name' => 'empty'];
            }

            if (empty($data['ru']['description'])) {

                if (empty($errors['ru'])) {
                    $errors['ru'] = ['description' => 'empty'];
                } else {
                    $errors['ru']['description'] = 'empty';
                }
            }
        }

        return $errors;
    }

    /**
     * Проверка настроек трекинга
     *
     * @param array $data
     *
     * @return array $errors
     */
    private static function validateTracking($data) {

        $errors = [];

        foreach ($data as $trackingId => $tracking) {

            if (empty($tracking['advertiserId'])) {
                $errors[$trackingId]['advertiserId'] = 'empty';
            }

            if (empty($tracking['link'])) {
                $errors[$trackingId]['link'] = 'empty';
            }

            if (!isset($tracking['payout'])) {
                $errors[$trackingId]['payout'] = 'empty';
            }

            if (empty($tracking['payoutCurrency'])) {
                $errors[$trackingId]['payoutCurrency'] = 'empty';
            } elseif (!in_array($tracking['payoutCurrency'], ['USD', 'RUB', 'EUR'])) {
                $errors[$trackingId]['payoutCurrency'] = 'wrong';
            }

            if (!isset($tracking['revenue'])) {
                $errors[$trackingId]['revenue'] = 'empty';
            }

            if (empty($tracking['revenueCurrency'])) {
                $errors[$trackingId]['revenueCurrency'] = 'empty';
            } elseif (!in_array($tracking['revenueCurrency'], ['USD', 'RUB', 'EUR'])) {
                $errors[$trackingId]['revenueCurrency'] = 'wrong';
            }
        }

        return $errors;
    }

    /**
     * Validate data
     *
     * @param $data
     *
     * @throws ValidateException
     * @internal param array $errors
     */
    private static function validateUser($data) {

        $errors = array();

        if (empty($data['user_id'])) {
            $errors['user_id'] = 'empty';
        }

        if (empty($data['name'])) {
            $errors['name'] = 'empty';
        }

        if (empty($data['advertiser_id'])) {
            $errors['advertiser_id'] = 'empty';
        }

        if (empty($data['status'])) {
            $errors['status'] = 'empty';
        } elseif (!in_array($data['status'], array('active', 'paused', 'deleted', 'pending', 'expired'))) {
            $errors['status'] = 'wrong';
        }

        if (empty($data['expiration_date'])) {
            $errors['expiration_date'] = 'empty';
        } elseif (!preg_match('/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/', $data['expiration_date'])) {
            $errors['expiration_date'] = 'wrong';
        }

        if (empty($data['cpa_currency'])) {
            $errors['cpa_currency'] = 'empty';
        } elseif (!in_array($data['cpa_currency'], array('USD', 'RUB', 'EUR'))) {
            $errors['cpa_currency'] = 'wrong';
        }

        if (empty($data['rpa_currency'])) {
            $errors['rpa_currency'] = 'empty';
        } elseif (!in_array($data['rpa_currency'], array('USD', 'RUB', 'EUR'))) {
            $errors['rpa_currency'] = 'wrong';
        }

        if (!empty($data['apk_file'])) {

            if (empty($data['apk_file']['name']) || empty($data['apk_file']['tmp_name']) || $data['apk_file']['error'] == 4 || $data['apk_file']['error'] != UPLOAD_ERR_OK) {
                $errors['apk_file'] = 'Ошибка загрузки';
            } /*else {
                
                $finfo = finfo_open(FILEINFO_MIME_TYPE);
                $mimeType = finfo_file($finfo, $data['apk_file']['tmp_name']);
                finfo_close($finfo);
                
                if (!in_array($mimeType, array('application/vnd.android.package-archive', 'application/zip', 'application/jar'))) {
                    $errors['apk_file'] = 'Неправильный apk-файл';
                }
            }*/
        }

        if (!empty($data['options']['wrapper_storepass']) && strlen($data['options']['wrapper_storepass']) < 6) {
            $errors['storepass'] = 'Значение должно быть не менее 6 символов';
        }

        if (!empty($data['options']['wrapper_keypass']) && strlen($data['options']['wrapper_keypass']) < 6) {
            $errors['keypass'] = 'Значение должно быть не менее 6 символов';
        }

        //if (!empty($data['options'])) {
        //    foreach ($data['options'] as $option => $value) {
        //        if (empty($value)) {
        //            $errors[$option] = 'empty';
        //        }
        //    }
        //}

        if (!empty($errors)) {
            throw new ValidateException('Offer', $errors);
        }
    }

    public static function checkTargeting($offer, $conditions) {

        foreach ($conditions as $condition => $value) {
            if (!empty($offer->targeting->$condition) && !in_array($value, $offer->targeting->$condition)) {
                return false;
            }
        }

        return true;
    }

    /**
     * @param Offer[] $offers
     *
     * @return object
     */
    public static function exportOffers($offers) {

        $res = [];

        foreach ($offers as $offer) {
            $obj = new \stdClass;

            $obj->id = $offer->id();
            $obj->status = $offer->status();
            $obj->availability = $offer->availability();
            $obj->icon = $offer->icon();
            $obj->previewUrl = $offer->previewUrl();
            $obj->translates = self::exportTranslates($offer);
            $obj->tracking = self::exportTracking($offer);

            $res[] = $obj;
        }

        return $res;
    }

    /**
     * @param Offer $offer
     *
     * @return object
     */
    public static function exportOffer($offer) {

        $obj = new \stdClass;

        $obj->id = $offer->id();
        $obj->status = $offer->status();
        $obj->availability = $offer->availability();
        $obj->icon = $offer->icon();
        $obj->previewUrl = $offer->previewUrl();
        $obj->translates = self::exportTranslates($offer);
        $obj->tracking = self::exportTracking($offer);
        $obj->goals = self::exportGoals($offer);

        return $obj;
    }

    /**
     * @param Offer $offer
     *
     * @return array
     */
    private static function exportTranslates($offer) {

        $translates = new \stdClass;

        if (!empty($offer->translates())) {
            foreach ($offer->translates() as $translate) {

                $lang = $translate->lang();

                $obj = new \stdClass;

                $obj->lang = $lang;
                $obj->name = $translate->name();
                $obj->description = $translate->description();

                $translates->$lang = $obj;
            }
        }

        return $translates;
    }

    /**
     * @param Offer $offer
     *
     * @return object
     */
    private static function exportTracking($offer) {

        $trackings = [];

        if (!empty($offer->tracking())) {
            foreach ($offer->tracking() as $tracking) {

                $obj = new \stdClass;

                $obj->id = $tracking->id();
                $obj->advertiserId = $tracking->advertiserId();
                $obj->link = $tracking->link();
                $obj->payout = $tracking->payout();
                $obj->payoutCurrency = $tracking->payoutCurrency();
                $obj->revenue = $tracking->revenue();
                $obj->revenueCurrency = $tracking->revenueCurrency();
                $obj->devices = $tracking->devices();
                $obj->countries = $tracking->countries();

                $trackings[] = $obj;
            }
        }

        return $trackings;
    }

    /**
     * @param Offer $offer
     *
     * @return array
     */
    private static function exportGoals($offer) {

        $goals = [];

        if (!empty($offer->goals())) {
            foreach ($offer->goals() as $goal) {

                $obj = new \stdClass;
                $obj->id = $goal->id();
                $obj->payout = $goal->payout();
                $obj->payoutCurrency = $goal->payoutCurrency();
                $obj->revenue = $goal->revenue();
                $obj->revenueCurrency = $goal->revenueCurrency();

                $objTranslate = new \stdClass;
                if (!empty($goal->translates())) {
                    foreach ($goal->translates() as $translate) {
                        $lang = $translate->lang();

                        $objFields = new \stdClass;

                        $objFields->lang = $lang;
                        $objFields->name = $translate->name();
                        $objFields->description = $translate->description();

                        $objTranslate->$lang = $objFields;
                    }
                }

                $obj->translates = $objTranslate;

                $goals[] = $obj;
            }
        }

        return $goals;
    }
}