<?php

namespace Domain\Offers;

use App\BaseModel;

class OfferTracking extends BaseModel {

    /**
     * @var int
     */
    protected $id;

    /**
     * @var string
     */
    protected $link;

    /**
     * @var int
     */
    protected $advertiserId;

    /**
     * @var float
     */
    protected $payout;

    /**
     * @var string
     */
    protected $payoutCurrency;

    /**
     * @var float
     */
    protected $revenue;

    /**
     * @var string
     */
    protected $revenueCurrency;

    /**
     * @var array
     */
    protected $countries;

    /**
     * @var array
     */
    protected $devices;

    /**
     * @return int
     */
    public function id() {

        return $this->id;
    }

    /**
     * @return string
     */
    public function link() {

        return $this->link;
    }

    /**
     * @return int
     */
    public function advertiserId() {

        return $this->advertiserId;
    }

    /**
     * @return float
     */
    public function payout() {

        return $this->payout;
    }

    /**
     * @return string
     */
    public function payoutCurrency() {

        return $this->payoutCurrency;
    }

    /**
     * @return float
     */
    public function revenue() {

        return $this->revenue;
    }

    /**
     * @return string
     */
    public function revenueCurrency() {

        return $this->revenueCurrency;
    }

    /**
     * @return array
     */
    public function countries() {

        return $this->countries;
    }

    /**
     * @return array
     */
    public function devices() {

        return $this->devices;
    }

    /**
     * @param OfferTracking $tracking
     *
     * @return array
     */
    public function diff($tracking) {

        $diff = [];

        if ($this->advertiserId() != $tracking->advertiserId()) {
            $diff['advertiser_id'] = [$this->advertiserId(), $tracking->advertiserId()];
        }

        if ($this->link() != $tracking->link()) {
            $diff['link'] = [$this->link(), $tracking->link()];
        }

        if ($this->payout() != $tracking->payout()) {
            $diff['payout'] = [$this->payout(), $tracking->payout()];
        }

        if ($this->payoutCurrency() != $tracking->payoutCurrency()) {
            $diff['payout_currency'] = [$this->payoutCurrency(), $tracking->payoutCurrency()];
        }

        if ($this->revenue() != $tracking->revenue()) {
            $diff['revenue'] = [$this->revenue(), $tracking->revenue()];
        }

        if ($this->revenueCurrency() != $tracking->revenueCurrency()) {
            $diff['revenue_currency'] = [$this->revenueCurrency(), $tracking->revenueCurrency()];
        }

        if (!empty(array_diff((array)$this->countries(), (array)$tracking->countries()))) {
            $diff['countries'] = [$this->countries(), $tracking->countries()];
        }

        if (!empty(array_diff((array)$this->devices(), (array)$tracking->devices()))) {
            $diff['devices'] = [$this->devices(), $tracking->devices()];
        }

        return $diff;
    }
}
