<?php

namespace Domain\Offers;

use App\BaseModel;

class Offer extends BaseModel {

    /**
     * @var int
     */
    protected $id;
    /**
     * @var string
     */
    protected $status;
    /**
     * @var string
     */
    protected $availability;
    /**
     * @var string
     */
    protected $icon;
    /**
     * @var string
     */
    protected $previewUrl;
    /**
     * @var OfferTracking[]
     */
    protected $tracking;
    /**
     * @var OfferGoal[]
     */
    protected $goals;
    /**
     * @var OfferTranslate[]
     */
    protected $translates;
    /**
     * @var string
     */
    protected $dateC;
    /**
     * @var string
     */
    protected $dateU;

    /**
     * @return int $id
     */
    public function id() {

        return $this->id;
    }

    /**
     * @return string
     */
    public function status() {

        return $this->status;
    }

    /**
     * @return string
     */
    public function availability() {

        return $this->availability;
    }

    /**
     * @return string
     */
    public function icon() {

        return $this->icon;
    }

    /**
     * @return string
     */
    public function previewUrl() {

        return $this->previewUrl;
    }

    /**
     * @return OfferTracking[]
     */
    public function tracking() {

        return $this->tracking;
    }

    /**
     * @return OfferGoal[]
     */
    public function goals() {

        return $this->goals;
    }

    /**
     * @return OfferTranslate[]
     */
    public function translates() {

        return $this->translates;
    }

    /**
     * @return string
     */
    public function dateC() {

        return $this->dateC;
    }

    /**
     * @return string
     */
    public function dateU() {

        return $this->dateU;
    }

    /**
     * @param $id
     */
    public function setId($id) {

        if (!empty($this->id)) {
            // ToDo
            // throw exception: id already set
        }

        $this->id = $id;
    }

    /**
     * @param OfferTracking $tracking
     */
    public function addTracking($tracking) {

        if (!empty($tracking->id())) {
            $this->tracking[$tracking->id()] = $tracking;
        } else {
            $this->tracking[] = $tracking;
        }
    }

    /**
     * @param OfferGoal $goal
     */
    public function addGoal($goal) {

        if (!empty($goal->id())) {
            $this->goals[$goal->id()] = $goal;
        } else {
            $this->goals[] = $goal;
        }
    }

    /**
     * @param int $trackingId
     *
     * @return OfferTracking
     */
    public function trackingById($trackingId) {

        if (empty($this->tracking[$trackingId])) {

            return new OfferTracking();
        }

        return $this->tracking[$trackingId];
    }

    /**
     * @param int $goalId
     *
     * @return OfferGoal
     */
    public function goalById($goalId) {

        if (empty($this->goals[$goalId])) {

            return new OfferGoal();
        }

        return $this->goals[$goalId];
    }

    /**
     * @param OfferTranslate $translate
     */
    public function addTranslate($translate) {

        $this->translates[$translate->lang()] = $translate;
    }

    /**
     * @param string $lang
     *
     * @return OfferTranslate
     */
    public function translate($lang) {

        if (empty($this->translates[$lang])) {
            return new OfferTranslate;
        }

        return $this->translates[$lang];
    }

    /**
     * @param $field
     * @param $value
     */
    public function set($field, $value) {

        $field = $this->prepareField($field);
        $this->$field = $value;
    }

    /**
     * @param Offer $offer
     *
     * @return array
     */
    public function diff($offer = null) {

        if (empty($offer)) {
            return $this->diff;
        }

        $diff = [];

        if ($this->status() != $offer->status()) {
            $diff['fields']['status'] = [$this->status(), $offer->status()];
        }

        if ($this->previewUrl() != $offer->previewUrl()) {
            $diff['fields']['preview_url'] = [$this->previewUrl(), $offer->previewUrl()];
        }

        if ($this->availability() != $offer->availability()) {
            $diff['fields']['availability'] = [$this->availability(), $offer->availability()];
        }

        if ($this->icon() != $offer->icon()) {
            $diff['fields']['icon'] = [$this->icon(), $offer->icon()];
        }

        $diffTranslates = $this->diffTranslates($offer);
        if (!empty($diffTranslates)) {
            $diff['translates'] = $diffTranslates;
        }

        $diffTracking = $this->diffTracking($offer);
        if (!empty($diffTracking)) {
            $diff['tracking'] = $diffTracking;
        }

        $diffGoals = $this->diffGoals($offer);
        if (!empty($diffGoals)) {
            $diff['goals'] = $diffGoals;
        }

        $this->diff = $diff;

        return $diff;
    }

    public function delete() {

        $this->diff = ['fields' => ['status' => [$this->status(), 'deleted']]];
    }

    /**
     * @param Offer $offer
     *
     * @return array
     */
    private function diffTranslates($offer) {

        $diff = [];

        $languages = array_merge(array_keys($this->translates()), array_keys($offer->translates()));
        foreach ($languages as $language) {

            $change = $this->translate($language)->diff($offer->translate($language));
            if (!empty($change)) {
                $diff[$language] = $change;
            }
        }

        return $diff;
    }

    /**
     * @param Offer $offer
     *
     * @return array
     */
    private function diffTracking($offer) {

        $diff = [];

        $updatedTrackingsIds = [];
        $existTrackingsIds = (!empty($this->tracking())) ? array_keys($this->tracking()) : [];

        if (!empty($offer->tracking())) {
            foreach ($offer->tracking() as $tracking) {

                // update tracking
                if (!empty($tracking->id())) {

                    $change = $this->trackingById($tracking->id())->diff($tracking);
                    if (!empty($change)) {

                        if (empty($diff['upd'])) {
                            $diff['upd'] = [];
                        }

                        $diff['upd'][$tracking->id()] = $change;
                    }

                    $updatedTrackingsIds[] = $tracking->id();
                } else {
                    if (empty($diff['ins'])) {
                        $diff['ins'] = [];
                    }

                    $diff['ins'][] = $tracking;
                }
            }
        }

        $deleteTrackingsIds = array_diff($existTrackingsIds, $updatedTrackingsIds);
        if (!empty($deleteTrackingsIds)) {
            $diff['del'] = $deleteTrackingsIds;
        }

        return $diff;
    }

    /**
     * @param Offer $offer
     *
     * @return array
     */
    private function diffGoals($offer) {

        $diff = [];

        $updatedGoalsIds = [];
        $existGoalsIds = (!empty($this->goals())) ? array_keys($this->goals()) : [];

        if (!empty($offer->goals())) {
            foreach ($offer->goals() as $goal) {

                // update goal
                if (!empty($goal->id())) {

                    $change = $this->goalById($goal->id())->diff($goal);
                    if (!empty($change)) {

                        if (empty($diff['upd'])) {
                            $diff['upd'] = [];
                        }

                        $diff['upd'][$goal->id()] = $change;
                    }

                    $updatedGoalsIds[] = $goal->id();
                } else {
                    if (empty($diff['ins'])) {
                        $diff['ins'] = [];
                    }

                    $diff['ins'][] = $goal;
                }
            }
        }

        $deleteGoalsIds = array_diff($existGoalsIds, $updatedGoalsIds);
        if (!empty($deleteGoalsIds)) {
            $diff['del'] = $deleteGoalsIds;
        }

        return $diff;
    }
}