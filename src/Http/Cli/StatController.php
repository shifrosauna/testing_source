<?php

namespace Http\Cli;

use Domain\Stat\StatService;

use App\Exceptions\BaseException;
use App\Exceptions\AccessDeniedException;
use App\Exceptions\EntityNotFoundException;

class StatController extends \App\BaseController {

    public function syncAction() {

        $state = StatService::getState('sync');

        if ($state->busy) {
            return;
        }

        // indicate start working
        StatService::setState('sync', array('busy' => true));

        $min_timestamp = (date("Y-m-d H", $state->last_timestamp) < date("Y-m-d H")) ? $state->last_timestamp : $state->last_timestamp - 3600;

        // save conversions
        try {
            $min_date = StatService::syncConversions();
        } catch (\Exception $e) {
            StatService::log('sync', '|                  conversions | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage());
            StatService::setState('sync', array(
                'busy'           => false,
                'last_timestamp' => $min_timestamp,
            ));

            return;
        }

        // sync impressions and clicks
        $timestamp = $min_timestamp;
        while (date("Y-m-d H", $timestamp) <= date("Y-m-d H")) {

            try {

                StatService::syncClicks($timestamp);
                StatService::syncImpressions($timestamp);

            } catch (\Exception $e) {
                StatService::log('sync', '|         sync of ' . date("d M H", $timestamp) . ':00 | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage());
                StatService::setState('sync', array(
                    'busy'           => false,
                    'last_timestamp' => $min_timestamp,
                ));

                return;
            }

            $timestamp += 3600;
        }

        // agregate
        if (!empty($min_date) && strtotime($min_date) < $min_timestamp) {
            $min_timestamp = ($min_date > date("Y-m-d", strtotime("-2weeks"))) ? strtotime($min_date) : strtotime("-2weeks");
        }

        try {

            StatService::agregateHour($min_timestamp);
            StatService::agregateDate($min_timestamp);
            StatService::agregateMonth($min_timestamp);
            // StatService::agregateYear($state->last_timestamp);

        } catch (\Exception $e) {

            StatService::log('sync', '|                     agregate | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage());
            StatService::setState('sync', array(
                'busy'           => false,
                'last_timestamp' => $min_timestamp,
            ));

            return;
        }

        // indicate end working
        StatService::setState('sync', array(
            'busy'           => false,
            'last_timestamp' => $_SERVER['REQUEST_TIME'],
        ));

        return;
    }

    public function appmetrikaAction() {

        $state = StatService::getState('appmetrika');
        if (empty($state->last_timestamp)) {
            $state->last_timestamp = strtotime("-7days");
        }
        if ($state->busy) {
            return;
        }

        // indicate start working
        StatService::setState('appmetrika', array('busy' => true));

        $min_timestamp = (date("Y-m-d", $state->last_timestamp) < date("Y-m-d")) ? $state->last_timestamp : strtotime("-1day");

        // sync appmetrika installs
        $timestamp = $min_timestamp;
        while (date("Y-m-d", $timestamp) <= date("Y-m-d")) {

            StatService::log('appmetrika', '|          installs for ' . date("d M", $timestamp) . ' | >>> begin');

            try {

                StatService::syncInstalls($timestamp);

            } catch (\Exception $e) {

                StatService::log('appmetrika', '|         appmetrika of ' . date("d M", $timestamp) . ' | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage());

                StatService::setState('appmetrika', array(
                    'busy'           => false,
                    'last_timestamp' => $min_timestamp,
                ));

                return;
            }

            StatService::log('appmetrika', '|          installs for ' . date("d M", $timestamp) . ' | end <<<');

            $timestamp += 3600 * 24;
        }

        // indicate end working
        StatService::setState('appmetrika', array(
            'busy'           => false,
            'last_timestamp' => $_SERVER['REQUEST_TIME'],
        ));

        return;
    }

    public function cohortAction() {

        $state = StatService::getState('cohort');

        if ($state->busy) {
            return;
        }

        // indicate start working
        StatService::setState('cohort', array('busy' => true));

        $timestamp = $state->last_timestamp + 3600 * 24;
        $date = date("Y-m-d", $timestamp);
        if ($date == date("Y-m-d")) {
            $timestamp = strtotime("-2months");
            $date = date("Y-m-d", $timestamp);
        }

        try {

            StatService::syncEcpm($date);
            StatService::agregateImpressions($date);
            StatService::agregateCohort($date);

        } catch (\Exception $e) {
            StatService::log('cohort', '|                       ' . date("d M", $timestamp) . ' | ' . "\033[0;31m" . 'error.' . "\033[0m" . ' ' . $e->getMessage());
            StatService::setState('cohort', array(
                'busy'           => false,
                'last_timestamp' => $state->last_timestamp,
            ));

            return;
        }

        // indicate end working
        StatService::setState('cohort', array(
            'busy'           => false,
            'last_timestamp' => $timestamp,
        ));

        return;
    }
}