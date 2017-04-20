<?php
/**
 * Created by PhpStorm.
 * User: user
 * Date: 09.06.16
 * Time: 15:12
 */

namespace Domain\Offers;

use App\BaseModel;

class OfferGoal extends BaseModel {

    /**
     * @var int
     */
    protected $id;
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
     * @var OfferGoalTranslate[]
     */
    protected $translates;

    /**
     * OfferGoal constructor.
     *
     * @param array $data
     */
    public function __construct($data = array()) {

        if (!empty($data)) {
            foreach ($data as $field => $value) {
                if ($field == 'translates') {

                    foreach ($value as $lang) {
                        $lang = (array)$lang;
                        $this->addTranslate(new OfferGoalTranslate($lang));
                    }
                } else {

                    $field = self::prepareField($field);
                    $this->$field = $value;
                }
            }
        }
    }

    /**
     * @return int
     */
    public function id() {

        return $this->id;
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
     * @return OfferGoalTranslate[]
     */
    public function translates() {

        return $this->translates;
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
     * @param OfferTranslate $translate
     */
    public function addTranslate($translate) {

        $this->translates[$translate->lang()] = $translate;
    }

    /**
     * @param string $lang
     *
     * @return OfferGoalTranslate
     */
    public function translate($lang) {

        if (empty($this->translates[$lang])) {
            return new OfferGoalTranslate;
        }

        return $this->translates[$lang];
    }

    /**
     * @param OfferGoal $goal
     *
     * @return array
     */
    public function diff($goal) {

        $diff = [];

        if ($this->payout() != $goal->payout()) {
            $diff['payout'] = [$this->payout(), $goal->payout()];
        }

        if ($this->payoutCurrency() != $goal->payoutCurrency()) {
            $diff['payout_currency'] = [$this->payoutCurrency(), $goal->payoutCurrency()];
        }

        if ($this->revenue() != $goal->revenue()) {
            $diff['revenue'] = [$this->revenue(), $goal->revenue()];
        }

        if ($this->revenueCurrency() != $goal->revenueCurrency()) {
            $diff['revenue_currency'] = [$this->revenueCurrency(), $goal->revenueCurrency()];
        }

        $diffTranslates = $this->diffTranslates($goal);
        if (!empty($diffTranslates)) {
            $diff['translates'] = $diffTranslates;
        }

        return $diff;
    }

    /**
     * @param OfferGoal $goal
     *
     * @return array
     */
    public function diffTranslates($goal) {

        $diff = [];

        $languages = array_merge(array_keys($this->translates()), array_keys($goal->translates()));
        foreach ($languages as $language) {

            $change = $this->translate($language)->diff($goal->translate($language));
            if (!empty($change)) {
                $diff[$language] = $change;
            }
        }

        return $diff;
    }
}