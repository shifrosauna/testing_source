<?php

namespace Domain\Stat;

use Domain\Offers\OffersService;
use Infrastructure\StatRepository;
use Infrastructure\OffersRepository;
use Infrastructure\OffersArcRepository;

use App\APKWrapper;
use App\Exceptions\EntityNotFoundException;
use App\Exceptions\ValidateException;
use App\Exceptions\CurlException;

class StatService {

    /**
     * Get state of statistics synchronization
     *
     * @return object
     */
    public static function getState($action) {

        $statRepository = new StatRepository;

        return $statRepository->getState($action);
    }

    public static function setState($action, $state) {

        $statRepository = new StatRepository;
        $statRepository->setState($action, (object)$state);
    }

    /**
     * find all Statistics
     *
     * @return array
     */
    public static function findAllForAdmin($options) {

        $statRepository = new StatRepository;
        $stat = $statRepository->loadBy($options);

        return $stat;
    }

    public static function findAllForUser($options, $user_id) {

        if (empty($options['filters'])) {
            $options['filters'] = array();
        }
        $options['filters']['aff_id'] = array($user_id);

        $statRepository = new StatRepository;
        $stat = $statRepository->loadBy($options);

        return $stat;
    }

    public static function cohort($options) {

        $statRepository = new StatRepository;

        return $statRepository->cohort($options);
    }

    public static function syncImpressions($timestamp) {

        $statRepository = new StatRepository;

        $date = date("Y-m-d", $timestamp);
        $hour = date("H", $timestamp);

        $response_success = false;
        $attempt = 0;

        while (!$response_success && $attempt < 3) {

            $attempt++;

            try {

                $stat = $statRepository->uploadImpressions($date, $hour);
                if (!empty($stat)) {
                    $statRepository->saveImpressions($stat, $date, $hour);
                }

                $response_success = true;
                $attempt_msg = ($attempt > 1) ? ' (' . $attempt . ')' : '';

                self::log('sync', '| impressions for ' . date("d M H", $timestamp) . ':00 | saved' . $attempt_msg);

            } catch (CurlException $e) {

                $response_success = false;
                self::log('sync', '| impressions for ' . date("d M H", $timestamp) . ':00 | ' . "\033[0;31m" . 'CurlError' . "\033[0m" . '(' . $attempt . '): ' . $e->getMessage() . '');

            } catch (\Exception $e) {

                self::log('sync', '| impressions for ' . date("d M H", $timestamp) . ':00 | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage() . '');
                throw $e;
            }
        }
    }

    public static function syncClicks($timestamp) {

        $statRepository = new StatRepository;

        $date = date("Y-m-d", $timestamp);
        $hour = date("H", $timestamp);

        $response_success = false;
        $attempt = 0;

        while (!$response_success && $attempt < 3) {

            $attempt++;

            try {

                $stat = $statRepository->uploadClicks($date, $hour);
                if (!empty($stat)) {
                    $statRepository->saveClicks($stat, $date, $hour);
                }

                $response_success = true;
                $attempt_msg = ($attempt > 1) ? '(' . $attempt . ')' : '';
                self::log('sync', '|      clicks for ' . date("d M H", $timestamp) . ':00 | saved' . $attempt_msg);

            } catch (CurlException $e) {

                $response_success = false;
                self::log('sync', '|      clicks for ' . date("d M H", $timestamp) . ':00 | ' . "\033[0;31m" . 'CurlError(' . $attempt . ')' . "\033[0m" . ' ' . $e->getMessage() . '');
            } catch (\Exception $e) {

                self::log('sync', '|      clicks for ' . date("d M H", $timestamp) . ':00 | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage() . '');
                throw $e;
            }
        }
    }

    public static function syncInstalls($timestamp) {

        $offersRepository = new OffersRepository;
        $statRepository = new StatRepository;
        $arcRepository = new OffersArcRepository;

        $date = date("Y-m-d", $timestamp);

        $offers = $arcRepository->getAllActive();
        foreach ($offers as $offer) {

            sleep(1);

            $count = $statRepository->uploadInstalls($date, $offer);
            self::log('appmetrika', '|          installs for ' . date("d M", $timestamp) . ' |  #' . $offer->id . ' = ' . $count);

            if ($count > 0) {
                $statRepository->saveInstalls($date, $offer->id, $offer->aff_id, $count);
            }
        }

        $offers = $offersRepository->getAllCustomActive();
        foreach ($offers as $offer) {

            sleep(1);

            $count = $statRepository->uploadInstalls($date, $offer);
            self::log('appmetrika', '|          installs for ' . date("d M", $timestamp) . ' |  #' . $offer->id . ' = ' . $count);

            if ($count > 0) {
                $statRepository->saveInstalls($date, $offer->id, $offer->aff_id, $count);
            }
        }
    }

    public static function syncConversions() {

        $statRepository = new StatRepository;

        $lastId = $statRepository->getLastConversionId();
        $countriesPayouts = $statRepository->loadCountriesPayouts();

        $attempt = 0;
        $min_date = date("Y-m-d H:i:s");
        $response_success = false;
        while (!$response_success && $attempt < 3) {

            $attempt++;

            try {

                $stat = $statRepository->uploadConversions($lastId);
                $response_success = true;

            } catch (CurlException $e) {

                $response_success = false;
                self::log('sync', '| 	              conversions | ' . "\033[0;31m" . 'CurlError' . "\033[0m" . '(' . $attempt . '): ' . $e->getMessage() . '');

                if ($attempt == 3) {
                    throw $e;
                }
            } catch (\Exception $e) {

                self::log('sync', '|                  conversions | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage() . '');
                throw $e;
            }
        }

        if (!empty($stat)) {

            $offers = array();

            foreach ($stat as $conversion) {

                try {

                    // Offers cache
                    if (empty($offers[$conversion->offer_id])) {
                        $offer = OffersService::findById($conversion->offer_id);
                        OffersService::loadTargeting($offer);
                        $offers[$conversion->offer_id] = $offer;
                    } else {
                        $offer = $offers[$conversion->offer_id];
                    }

                    if ($conversion->status == 'approved') {

                        if ($offer->status != 'active' && $offer->status != 'pending') {
                            self::rejectConversion($conversion);
                        } elseif ($conversion->goal_id > 0) {

                            $checkTargeting = OffersService::checkTargeting($offer, array('country' => $conversion->country_code));
                            $checUnique = $statRepository->checkUniqueConversion($conversion->offer_id, $conversion->goal_id, $conversion->affiliate_id, $conversion->affiliate_info1);

                            if ($checkTargeting && $checUnique) {

                                // Load payout for country
                                if ($conversion->payout > 0 && !empty($countriesPayouts[$conversion->country_code])) {

                                    self::updateConversionPayout($conversion, $countriesPayouts[$conversion->country_code]->cpa);

                                    $conversion_install_date = urldecode($conversion->affiliate_info4);

                                    if ($conversion_install_date < $min_date) {
                                        $min_date = $conversion_install_date;
                                    }

                                    // $conversion->currency = $countriesPayouts[$conversion->country_code]->cpa_currency;
                                    // $statRepository->updateConversion($conversion->id, 'currency', $conversion->currency);
                                }
                            } else {
                                //self::updateConversionPayout($conversion, 0);
                                self::rejectConversion($conversion);
                            }
                        }
                    }
                } catch (EntityNotFoundException $e) {

                    self::rejectConversion($conversion);
                    continue;
                }
            }

            $statRepository->saveConversions($stat);

            $attempt_msg = ($attempt > 1) ? '(' . $attempt . ')' : '';
            self::log('sync', '|                  conversions | saved = ' . $min_date . $attempt_msg);
        }

        return $min_date;
    }

    public static function syncEcpm($date) {

        $wrapper = new APKWrapper(false);
        $statRepository = new StatRepository;

        if (empty($date)) {
            $date = date("Y-m-d", strtotime("-2months"));
        }

        $msg = '|     ecpm for ' . date("d M", strtotime($date));

        while ($date < date("Y-m-d")) {

            try {

                $stat = array();
                $data = $wrapper->stat($date);
                if (!empty($data) && !empty($data->result)) {

                    foreach ($data->result as $row) {
                        if (!empty($row->ecpm)) {

                            if (empty($row->country)) {
                                $row->country = 'INT';
                            }

                            $stat[] = $row;
                        }
                    }

                    $statRepository->saveEcpm($date, $stat);

                }
            } catch (\Exception $e) {

                self::log('cohort', '|              ecpm for ' . date("d M", strtotime($date)) . ' | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage());
                throw $e;
            }

            $date = date("Y-m-d", strtotime($date . "+1day"));
        }

        if (!empty($stat)) {
            self::log('cohort', $msg . '...' . date("d M", strtotime($date)) . ' | saved');
        }
    }

    public static function agregateHour($timestamp) {

        $statRepository = new StatRepository;

        while (date("Y-m-d H", $timestamp) <= date("Y-m-d H")) {

            $date = date("Y-m-d", $timestamp);
            $hour = date("H", $timestamp);
            $stat = $statRepository->agregateHour($date, $hour);

            self::log('sync', '|                     agregate | ' . date("d M H", $timestamp) . ':00');
            $timestamp += 3600;
        }
    }

    public static function agregateDate($timestamp) {

        $statRepository = new StatRepository;

        while (date("Y-m-d", $timestamp) <= date("Y-m-d")) {

            $date = date("Y-m-d", $timestamp);
            $stat = $statRepository->agregateDate($date);

            self::log('sync', '|                     agregate | ' . date("d M", $timestamp));
            $timestamp += 3600 * 24;
        }
    }

    public static function agregateMonth($timestamp) {

        $statRepository = new StatRepository;

        while (date("Y-m", $timestamp) <= date("Y-m")) {

            $date = date("Y-m-d", $timestamp);
            $stat = $statRepository->agregateMonth($date);

            self::log('sync', '|                     agregate | ' . date("F", $timestamp));
            $timestamp = strtotime(date("Y-m-d", $timestamp) . "+1month");
        }
    }

    public static function agregateImpressions($date) {

        $statRepository = new StatRepository;
        $statRepository->agregateImpressionsLive($date);

        self::log('cohort', '|       impressions for ' . date("d M", strtotime($date)) . ' | success');
    }

    public static function agregateCohort($date) {

        $statRepository = new StatRepository;
        $statRepository->agregateCohort($date);

        self::log('cohort', '|            cohort for ' . date("d M", strtotime($date)) . ' | success');
    }

    public static function updateConversionPayout($conversion, $payout) {

        $conversion->payout = $payout;

        $statRepository = new StatRepository;

        try {
            $statRepository->updateConversion($conversion->id, 'payout', $payout);
        } catch (CurlException $e) {
            self::log('sync', '| 	              conversions | ' . $conversion->id . ' ' . "\033[0;31m" . 'update payout failure (CurlError)' . "\033[0m" . ': ' . $e->getMessage() . '');
        }
    }

    public static function rejectConversion($conversion) {

        $conversion->status = 'rejected';

        $statRepository = new StatRepository;

        try {
            $statRepository->updateConversion($conversion->id, 'status', 'rejected');
        } catch (CurlException $e) {
            self::log('sync', '| 	              conversions | ' . $conversion->id . ' ' . "\033[0;31m" . 'reject failure (CurlError)' . "\033[0m" . ': ' . $e->getMessage() . '');
        }
    }

    public static function getCohortDate() {

        $statRepository = new StatRepository;
        $date = $statRepository->getLastCohortDate();

        $date = min(date("Y-m-d", strtotime($date . "+1day")), date("Y-m-d", strtotime("-45days")));

        return $date;
    }

    public static function getEcpmDate() {

        $statRepository = new StatRepository;
        $date = $statRepository->getLastEcpmDate();

        $date = date("Y-m-d", strtotime($date . "+1day"));

        return $date;
    }

    public static function getImpressionsLiveDate() {

        $statRepository = new StatRepository;
        $date = $statRepository->getLastImpressionsLiveDate();

        // $date = date("Y-m-d", strtotime($date ."+1day"));

        return $date;
    }

    public static function getPaymentsWeeks() {

        $weeks = array();

        $statRepository = new StatRepository;

        $today = date("Y-m-d");
        $date_from = '2015-11-09';
        $date_to = '2015-11-15';

        while ($today > $date_from && $today > $date_to) {

            $weeks[] = array(
                'date_from' => $date_from,
                'date_to'   => $date_to,
                'sum'       => $statRepository->sumWeekPayouts($date_from, $date_to),
            );

            $date_from = date("Y-m-d", strtotime($date_from . "+1week"));
            $date_to = date("Y-m-d", strtotime($date_to . "+1week"));
        }

        rsort($weeks);

        return $weeks;
    }

    public static function csvPayments($date_from, $date_to) {

        $statRepository = new StatRepository;
        $data = $statRepository->getWeekPayouts($date_from, $date_to);

        $csv = 'login;wmz;sum' . "\r\n";
        foreach ($data as $row) {
            $csv .= $row->login . ';' . $row->wmz . ';' . $row->sum . "\r\n";
        }

        return $csv;
    }

    public static function xmlPayments($date_from, $date_to) {

        $statRepository = new StatRepository;
        $data = $statRepository->getWeekPayouts($date_from, $date_to);

        $xml = '';

        foreach ($data as $row) {

            $xml .= '
				<payment>
					<Destination>' . $row->wmz . '</Destination>
					<Amount>' . round($row->sum, 2) . '</Amount>
					<Currency>WMZ</Currency>
					<Description>MobiOffers_' . $row->login . '_' . $date_from . '-' . $date_to . '</Description>
					<Id>' . 123 . '</Id>
				</payment>
            ';
        }

        $xml = '<?xml version="1.0" encoding="WINDOWS-1251" ?>
        <payments xmlns="http://tempuri.org/ds.xsd">
        ' . $xml . '
        </payments>';

        return $xml;
    }

    public static function log($name, $message) {

        $statRepository = new StatRepository;
        $statRepository->log('stat/' . $name, $message);
    }
}