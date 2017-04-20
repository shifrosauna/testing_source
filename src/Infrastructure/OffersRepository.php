<?php

namespace Infrastructure;

use App\Configuration;
use App\Exceptions\DataBaseException;
use App\Exceptions\EntityNotFoundException;
use Domain\Offers\Offer;
use Domain\Offers\OfferTracking;
use Domain\Offers\OfferGoal;
use Domain\Offers\OfferGoalTranslate;

class OffersRepository extends AbstractRepository {

    protected $name   = 'offers';
    protected $joinId = 'offer_id';
    // Backward capability
    protected $db_join_id = 'offer_id';
    private   $viewFields = ['offers.id', 'offers.status', 'offers.availability', 'offers.preview_url'];

    public function __construct() {

        parent::__construct();

        $nid = Configuration::get('system')->nid;

        $this->table = (!empty($nid)) ? '_' . Configuration::get('system')->nid . '_' . $this->name : $this->name;

        // Backward capability
        $this->db_table_name = '_' . Configuration::get('system')->nid . '_' . $this->name;
    }

    /**
     * Find offer from the main table by unique id
     *
     * @param int    $id
     * @param string $lang
     * @param array  $joins
     *
     * @return object $data
     * @throws EntityNotFoundException
     */
    public function findById($id, $lang = null, $joins = null) {

        $options = [
            'filters' => ['offers' => ['id' => $id]],
            'joins'   => $joins,
        ];

        if (!empty($lang)) {
            $options['filters']['translates'] = ['lang' => $lang];
        }

        $data = $this->findOneBy($options);

        if (empty($data)) {
            throw new EntityNotFoundException('Offer', $id);
        }

        return $data;
    }

    /**
     * Find many rows from table by filters
     *
     * @param array $options
     *
     * @return array
     */
    public function findBy($options = []) {

        list($sql, $variables) = $this->getFindQuery($options);

        $sth = $this->db->prepare($sql);
        $sth->execute($variables);
        $rows = $sth->fetchAll();

        if (!empty($rows)) {
            foreach ($rows as $row) {

                if (!empty($options['joins'])) {
                    foreach ($options['joins'] as $table) {
                        $row->$table = $this->parseTable($table, $row->$table);
                    }
                }
            }
        }

        return $rows;
    }

    /**
     * Find offer from the main table by unique id
     *
     * @param array $options
     *
     * @return object $data
     */
    public function findOneBy($options) {

        list($sql, $variables) = $this->getFindQuery($options);

        $sth = $this->db->prepare($sql);
        $sth->execute($variables);
        $data = $sth->fetchObject();

        if (!empty($data)) {

            if (!empty($options['joins'])) {
                foreach ($options['joins'] as $table) {
                    $data->$table = $this->parseTable($table, $data->$table);
                }
            }
        }

        return $data;
    }

    protected function getFindQuery($options) {

        $fields = ['offers.*'];
        $where = [];
        $variables = [];

        if (!empty($options['joins'])) {
            foreach ($options['joins'] as $table) {

                $filters = [];

                if (!empty($options['filters']) && !empty($options['filters'][$table])) {
                    foreach ($options['filters'][$table] as $field => $value) {
                        $filters[] = $field . "=?";
                        $variables[] = $value;
                    }
                }

                $fields[] = $this->fieldsTable($table, $filters);
            }
        }

        if (!empty($options['filters']) && !empty($options['filters']['offers'])) {
            foreach ($options['filters']['offers'] as $field => $value) {
                $where[] = $field . "=?";
                $variables[] = $value;
            }
        }

        $fields = (!empty($fields)) ? implode(", ", $fields) : "*";
        $where = (!empty($where)) ? " WHERE " . implode(" AND ", $where) : "";

        return [
            "SELECT {$fields} FROM {$this->table} AS {$this->name} {$where}",
            $variables,
        ];
    }

    /**
     * Добавление в базу: offers, offers_translates, offers_tracking, offers_goals, offers_goals_translates
     *
     * @param Offer $offer
     *
     * @return int|void
     * @throws DataBaseException
     */
    public function insert($offer) {

        $this->db->beginTransaction();

        try {

            $offerId = $this->insertOffer($offer);
            $offer->setId($offerId);

            $this->insertOfferTracking($offer, $offer->tracking());
            $this->insertOfferTranslates($offer);

            if (!empty($offer->goals())) {
                $this->insertOfferGoals($offer, $offer->goals());
            }
        } catch (DataBaseException $e) {

            $this->db->rollBack();

            throw $e;
        }

        $this->db->commit();
    }

    /**
     * Обновление оффера: offers, offers_lang
     *
     * @param Offer $offer
     *
     * @return int|void
     * @throws DataBaseException
     */
    public function update($offer) {

        $diff = $offer->diff();

        $this->db->beginTransaction();

        try {

            if (!empty($diff['fields'])) {
                $this->updateOffer($offer, $diff['fields']);
            }

            if (!empty($diff['tracking'])) {

                if (!empty($diff['tracking']['ins'])) {
                    $this->insertOfferTracking($offer, $diff['tracking']['ins']);
                }

                if (!empty($diff['tracking']['upd'])) {
                    $this->updateOfferTracking($diff['tracking']['upd']);
                }

                if (!empty($diff['tracking']['del'])) {
                    $this->deleteOfferTracking($diff['tracking']['del']);
                }
            }

            if (!empty($diff['goals'])) {

                if (!empty($diff['goals']['ins'])) {
                    $this->insertOfferGoals($offer, $diff['goals']['ins']);
                }

                if (!empty($diff['goals']['upd'])) {
                    $this->updateOfferGoals($diff['goals']['upd']);
                }

                if (!empty($diff['goals']['del'])) {
                    $this->deleteOfferGoals($diff['goals']['del']);
                }
            }

            if (!empty($diff['translates'])) {
                $this->updateOfferTranslates($offer, $diff['translates']);
            }
        } catch (DataBaseException $e) {

            $this->db->rollBack();

            throw $e;
        }

        $this->db->commit();
    }

    public function approvePartner($offer, $partner_id) {

        $sth = $this->db->prepare("UPDATE {$this->table} SET approved_affiliates = approved_affiliates || " . $partner_id . ", blocked_affiliates = array_remove(blocked_affiliates, " . $partner_id . ") WHERE id=?");
        $sth->execute([$offer->id]);
    }

    public function nonapprovePartner($offer, $partner_id) {

        $sth = $this->db->prepare("UPDATE {$this->table} SET approved_affiliates = array_remove(approved_affiliates, " . $partner_id . "), blocked_affiliates = array_remove(blocked_affiliates, " . $partner_id . ") WHERE id=?");
        $sth->execute([$offer->id]);
    }

    public function blockPartner($offer, $partner_id) {

        $sth = $this->db->prepare("UPDATE {$this->table} SET blocked_affiliates = blocked_affiliates || " . $partner_id . ", approved_affiliates = array_remove(approved_affiliates, " . $partner_id . ") WHERE id=?");
        $sth->execute([$offer->id]);
    }

    /**
     * Find offers for user by user_id
     *
     * @param int $userId
     *
     * @return array Offer[]
     */
    public function findByUserId($userId, $_admin) {

        $where = array();

        if (!$_admin) {
            $where[] = "offers.status='active'";
            $where[] = "(is_private = 0 OR ? = ANY(approved_affiliates))";
        }

        $where = (!empty($where)) ? "WHERE " . implode(" AND ", $where) : "";

        $sth = $this->db->prepare("
            SELECT
                offers.*,
                options.return_type AS options_return_type,
                options.appmetrika_app_id AS options_appmetrika_app_id,
                array_to_string(targeting.country, ',') AS targeting_country,
                goals.cpa AS goals_cpa,
                arc.id AS arc_id
            FROM {$this->table} AS offers
            LEFT JOIN {$this->table}_targeting AS targeting ON (offers.id = targeting.offer_id)
            LEFT JOIN {$this->table}_options AS options ON (offers.id = options.offer_id)
            LEFT JOIN {$this->table}_goals AS goals ON (offers.id = goals.offer_id AND goals.cpa > 0)
            LEFT JOIN {$this->table}_arc AS arc ON (arc.offer_id = offers.id)
            {$where}
            ORDER BY id
        ");

        $sth->execute([$userId]);
        $offers = $sth->fetchAll();

        foreach ($offers as $offer) {

            $offer->name = htmlspecialchars_decode($offer->name, ENT_QUOTES);
            $offer->description = htmlspecialchars_decode($offer->description, ENT_QUOTES);
            $offer->expiration_date = substr($offer->expiration_date, 0, 10);

            $offer->options = new \stdClass;
            $offer->options->return_type = $offer->options_return_type;
            $offer->options->appmetrika_app_id = $offer->options_appmetrika_app_id;

            $offer->targeting = new \stdClass;
            $offer->targeting->country = (!empty($offer->targeting_country)) ? explode(',', $offer->targeting_country) : array();

            $iconPath = $this->_path_icons . $offer->id . '.png';
            if (file_exists($iconPath)) {
                $offer->icon = $this->_url_icons . $offer->id . '.png';
            }

            if (!empty($offer->arc_id)) {
                $offer->arc = new \stdClass;
                $offer->arc->id = $offer->arc_id;
            }
        }

        return $offers;
    }

    /**
     * @param Offer $offer
     *
     * @return int $offerId
     */
    private function insertOffer($offer) {

        $values = array(
            $offer->previewUrl(),
            $offer->availability(),
            $offer->status(),

        );

        $sth = $this->db->prepare("INSERT INTO {$this->table} (preview_url,availability, status) VALUES (?,?,?) RETURNING id");
        $sth->execute($values);

        $offerId = $sth->fetchColumn();

        return $offerId;
    }

    /**
     * @param Offer $offer
     * @param array $diff
     */
    private function updateOffer($offer, $diff) {

        $variables = [];
        $values = [];

        foreach ($diff as $field => $value) {
            $variables[] = "{$field}=?";
            $values[] = $value[1];
        }

        $values[] = $offer->id();
        $variables[] = "date_u=now()";
        $variables = implode(",", $variables);

        $sth = $this->db->prepare("UPDATE {$this->table} SET {$variables} WHERE id=?");
        $sth->execute($values);
    }

    /**
     * @param Offer           $offer
     * @param OfferTracking[] $trackings
     */
    private function insertOfferTracking($offer, $trackings) {

        $sth = $this->db->prepare("
            INSERT INTO {$this->table}_tracking
            (offer_id, advertiser_id, link, payout, payout_currency, revenue, revenue_currency, countries, devices) 
            VALUES (?,?,?,?,?,?,?,?,?)
         ");

        foreach ($trackings as $tracking) {

            $countries = (!empty($tracking->countries())) ? "{" . implode(",", $tracking->countries()) . "}" : "{}";
            $devices = (!empty($tracking->devices())) ? "{" . implode(",", $tracking->devices()) . "}" : "{}";

            $values = [
                $offer->id(),
                $tracking->advertiserId(),
                $tracking->link(),
                $tracking->payout(),
                $tracking->payoutCurrency(),
                $tracking->revenue(),
                $tracking->revenueCurrency(),
                $countries,
                $devices,
            ];

            $sth->execute($values);
        }
    }

    /**
     * @param Offer       $offer
     * @param OfferGoal[] $goals
     */
    private function insertOfferGoals($offer, $goals) {

        $sth = $this->db->prepare("
            INSERT INTO {$this->table}_goals
            (offer_id,payout, payout_currency, revenue, revenue_currency) 
            VALUES (?,?,?,?,?) RETURNING id
         ");

        foreach ($goals as $goal) {

            $values = [
                $offer->id(),
                $goal->payout(),
                $goal->payoutCurrency(),
                $goal->revenue(),
                $goal->revenueCurrency(),
            ];

            $sth->execute($values);

            $goalId = $sth->fetchColumn();
            $goal->setId($goalId);
            $this->insertOfferGoalTranslates($goal);
        }
    }

    /**
     * @param Offer $goal
     */
    private function insertOfferGoalTranslates($goal) {

        $sth = $this->db->prepare("
            INSERT INTO {$this->table}_goals_translates
            (goal_id,lang,name,description) 
            VALUES (?,?,?,?)
         ");

        foreach ($goal->translates() as $lang) {

            $values = [
                $goal->id(),
                $lang->lang(),
                htmlspecialchars($lang->name(), ENT_QUOTES),
                htmlspecialchars($lang->description(), ENT_QUOTES),
            ];

            $sth->execute($values);
        }
    }

    /**
     * @param array $diff
     */
    private function updateOfferTracking($diff) {

        foreach ($diff as $trackingId => $tracking) {

            $variables = [];
            $values = [];

            foreach ($tracking as $field => $value) {

                $variables[] = "{$field}=?";
                $values[] = (is_array($value[1])) ? "{" . implode(",", $value[1]) . "}" : $value[1];
            }

            $values[] = $trackingId;
            $variables = implode(",", $variables);

            $sth = $this->db->prepare("UPDATE {$this->table}_tracking SET {$variables} WHERE id=?");
            $sth->execute($values);
        }
    }

    /**
     * @param array $diff
     */
    private function updateOfferGoals($diff) {

        foreach ($diff as $goalId => $goal) {

            $variables = [];
            $values = [];

            foreach ($goal as $field => $value) {
                if ($field == 'translates') {
                    $this->updateOfferGoalsTranslates($goalId, $value);
                } else {
                    $variables[] = "{$field}=?";
                    $values[] = (is_array($value[1])) ? "{" . implode(",", $value[1]) . "}" : $value[1];
                }
            }

            if (!empty($variables)) {

                $values[] = $goalId;
                $variables = implode(",", $variables);

                $sth = $this->db->prepare("UPDATE {$this->table}_goals SET {$variables} WHERE id=?");
                $sth->execute($values);
            }
        }
    }

    /**
     * @param array $diff
     */
    private function deleteOfferTracking($diff) {

        $sth = $this->db->prepare("DELETE FROM {$this->table}_tracking WHERE id IN (" . implode(",", $diff) . ")");
        $sth->execute([]);
    }

    /**
     * @param array $diff
     */
    private function deleteOfferGoals($diff) {

        $sth = $this->db->prepare("DELETE FROM {$this->table}_goals WHERE id IN (" . implode(",", $diff) . ")");
        $sth->execute([]);
    }

    /**
     * @param Offer $offer
     */
    private function insertOfferTranslates($offer) {

        $sth = $this->db->prepare("INSERT INTO {$this->table}_translates (offer_id,lang,name,description) VALUES (?,?,?,?)");

        foreach ($offer->translates() as $lang) {

            $values = [
                $offer->id(),
                $lang->lang(),
                htmlspecialchars($lang->name(), ENT_QUOTES),
                htmlspecialchars($lang->description(), ENT_QUOTES),
            ];

            $sth->execute($values);
        }
    }

    public function updateOfferGoalsTranslates($goalId, $diff) {

        foreach ($diff as $language => $lang) {

            $variables = [];
            $values = [];

            foreach ($lang as $field => $value) {
                $variables[] = "{$field}=?";
                $values[] = htmlspecialchars($value[1], ENT_QUOTES);
            }

            $values[] = $goalId;
            $values[] = $language;

            $variables = implode(",", $variables);

            $sth = $this->db->prepare("UPDATE {$this->table}_goals_translates SET {$variables} WHERE goal_id=? AND lang=?");
            $sth->execute($values);
        }
    }

    /**
     * @param Offer $offer
     * @param array $diff
     */
    private function updateOfferTranslates($offer, $diff) {

        foreach ($diff as $language => $lang) {

            $variables = [];
            $values = [];

            foreach ($lang as $field => $value) {
                $variables[] = "{$field}=?";
                $values[] = htmlspecialchars($value[1], ENT_QUOTES);
            }

            $values[] = $offer->id();
            $values[] = $language;

            $variables = implode(",", $variables);

            $sth = $this->db->prepare("UPDATE {$this->table}_translates SET {$variables} WHERE offer_id=? AND lang=?");
            $sth->execute($values);
        }
    }

    /**
     * @param array $filters
     *
     * @return string
     */
    protected function fieldsTableGoals($table, $filters) {

        $where = (!empty($filters)) ? " AND " . implode(" AND ", $filters) : "";

        $fields = " ( SELECT json_agg(json_build_object(
                'id', id,                
                'payout', payout,
                'payoutCurrency', payout_currency,
                'revenue', revenue,
                'revenueCurrency', revenue_currency,
                'translates',
                (
			SELECT json_agg(json_build_object(
				'lang', lang,
				'name', name,
				'description', description
			))
			FROM {$this->table}_goals_translates 
			WHERE goal_id = goals.id) 
		        
		))  

            FROM {$this->table}_goals as goals
            WHERE offer_id = offers.id
        ) AS goals";

        return $fields;
    }

    /**
     * @param array $filters
     *
     * @return string
     */
    protected function fieldsTableTracking($table, $filters) {

        $where = (!empty($filters)) ? " AND " . implode(" AND ", $filters) : "";

        $fields = "(
			SELECT json_agg(json_build_object(
				'id', id,
				'advertiserId', advertiser_id,
				'link', link,
				'payout', payout,
				'payoutCurrency', payout_currency,
				'revenue', revenue,
				'revenueCurrency', revenue_currency,
				'countries', countries,
				'devices', devices,
				'status', status
			))
			FROM {$this->table}_tracking 
			WHERE offer_id = offers.id {$where}
		) AS tracking";

        return $fields;
    }

    /**
     * @param array $filters
     *
     * @return string
     */
    protected function fieldsTableTranslates($table, $filters) {

        $where = (!empty($filters)) ? " AND " . implode(" AND ", $filters) : "";

        $fields = "(
            SELECT json_agg(json_build_object(
				'lang', lang,
				'name', name,
				'description', description
			))
			FROM {$this->table}_translates 
			WHERE offer_id = offers.id {$where}
		) AS translates";

        return $fields;
    }
}