<?php

namespace Infrastructure;

use App\Hasoffers;

class StatRepository extends AbstractRepository {

    public $countries = array(
        'AU' => 'Австралия',
        'AT' => 'Австрия',
        'AZ' => 'Азербайджан',
        'AX' => 'Аландские острова',
        'AL' => 'Албания',
        'DZ' => 'Алжир',
        'VI' => 'Виргинские острова, США',
        'AS' => 'Американское Самоа',
        'AI' => 'Ангилья',
        'AO' => 'Ангола',
        'AD' => 'Андорра',
        'AQ' => 'Антарктида',
        'AG' => 'Антигуа и Барбуда',
        'AR' => 'Аргентина',
        'AM' => 'Армения',
        'AW' => 'Аруба',
        'AF' => 'Афганистан',
        'BS' => 'Багамские острова',
        'BD' => 'Бангладеш',
        'BB' => 'Барбадос',
        'BH' => 'Бахрейн',
        'BZ' => 'Белиз',
        'BY' => 'Белоруссия',
        'BE' => 'Бельгия',
        'BJ' => 'Бенин',
        'BM' => 'Бермуды',
        'BG' => 'Болгария',
        'BO' => 'Боливия',
        'BQ' => 'Бонэйр, Синт-Эстатиус и Саба',
        'BA' => 'Босния и Герцеговина',
        'BW' => 'Ботсвана',
        'BR' => 'Бразилия',
        'IO' => 'Британская территория в Индийском океане',
        'VG' => 'Британские Виргинские острова',
        'BN' => 'Бруней',
        'BF' => 'Буркина-Фасо',
        'BI' => 'Бурунди',
        'BT' => 'Бутан',
        'VU' => 'Вануату',
        'VA' => 'Ватикан',
        'UK' => 'Великобритания',
        'HU' => 'Венгрия',
        'VE' => 'Венесуэла',
        'UM' => 'Внешние малые острова, США',
        'TL' => 'Восточный Тимор (Тимор-Лешти)',
        'VN' => 'Вьетнам',
        'GA' => 'Габон',
        'HT' => 'Гаити',
        'GY' => 'Гайана',
        'GM' => 'Гамбия',
        'GH' => 'Гана',
        'GP' => 'Гваделупа',
        'GT' => 'Гватемала',
        'GF' => 'Гвиана',
        'GN' => 'Гвинея',
        'GW' => 'Гвинея-Бисау',
        'DE' => 'Германия',
        'GG' => 'Гернси',
        'GI' => 'Гибралтар',
        'HN' => 'Гондурас',
        'HK' => 'Гонконг',
        'GD' => 'Гренада',
        'GL' => 'Гренландия',
        'GR' => 'Греция',
        'GE' => 'Грузия',
        'GU' => 'Гуам',
        'DK' => 'Дания',
        'JE' => 'Джерси',
        'DJ' => 'Джибути',
        'DM' => 'Доминика',
        'DO' => 'Доминиканская Республика',
        'CD' => 'ДР Конго',
        'EG' => 'Египет',
        'EU' => 'Европа (Неизвестные страны)',
        'ZM' => 'Замбия',
        'EH' => 'Западная Сахара (САДР)',
        'ZW' => 'Зимбабве',
        'IL' => 'Израиль',
        'IN' => 'Индия',
        'ID' => 'Индонезия',
        'JO' => 'Иордания',
        'IQ' => 'Ирак',
        'IR' => 'Иран',
        'IE' => 'андии Ирландия',
        'IS' => 'Исландия',
        'ES' => 'Испания',
        'IT' => 'Италия',
        'YE' => 'Йемен',
        'CV' => 'Кабо-Верде',
        'KZ' => 'Казахстан',
        'KY' => 'Острова Кайман',
        'KH' => 'Камбоджа',
        'CM' => 'Камерун',
        'CA' => 'Канада',
        'QA' => 'Катар',
        'KE' => 'Кения',
        'CY' => 'Кипр',
        'KG' => 'Киргизия',
        'KI' => 'Кирибати',
        'TW' => 'Тайвань, КНР',
        'KP' => 'КНДР (Северная Корея)',
        'CN' => 'Китай (КНР)',
        'CC' => 'Кокосовые острова',
        'CO' => 'Колумбия',
        'KM' => 'Коморы',
        'CR' => 'Коста-Рика',
        'CI' => 'Кот-дИвуар',
        'CU' => 'Куба',
        'KW' => 'Кувейт',
        'CW' => 'Кюрасао',
        'LA' => 'Лаос',
        'LV' => 'Латвия',
        'LS' => 'Лесото',
        'LR' => 'Либерия',
        'LB' => 'Ливан',
        'LY' => 'Ливия',
        'LT' => 'Литва',
        'LI' => 'Лихтенштейн',
        'LU' => 'Люксембург',
        'MU' => 'Маврикий',
        'MR' => 'Мавритания',
        'MG' => 'Мадагаскар',
        'YT' => 'Майотта',
        'MO' => 'Макао',
        'MK' => 'Македония',
        'MW' => 'Малави',
        'MY' => 'Малайзия',
        'ML' => 'Мали',
        'MV' => 'Мальдивы',
        'MT' => 'Мальта',
        'MA' => 'Марокко',
        'MQ' => 'Мартиника',
        'MH' => 'Маршалловы Острова',
        'MX' => 'Мексика',
        'FM' => 'Микронезия',
        'MZ' => 'Мозамбик',
        'MD' => 'Молдавия',
        'MC' => 'Монако',
        'MN' => 'Монголия',
        'MS' => 'Монтсеррат',
        'MM' => 'Мьянма',
        'NA' => 'Намибия',
        'NR' => 'Науру',
        'NP' => 'Непал',
        'NE' => 'Нигер',
        'NG' => 'Нигерия',
        'NL' => 'Нидерланды',
        'NI' => 'Никарагуа',
        'NU' => 'Ниуэ',
        'NZ' => 'Новая Зеландия',
        'NC' => 'Новая Каледония',
        'NO' => 'Норвегия',
        'AE' => 'ОАЭ',
        'OM' => 'Оман',
        'BV' => 'Остров Буве',
        'IM' => 'Остров Мэн',
        'CK' => 'Острова Кука',
        'NF' => 'Остров Норфолк',
        'CX' => 'Остров Рождества',
        'PN' => 'Острова Питкэрн',
        'SH' => 'Острова Святой Елены, Вознесения и Тристан-да-Кунья',
        'PK' => 'Пакистан',
        'PW' => 'Палау',
        'PS' => 'Государство Палестина',
        'PA' => 'Панама',
        'PG' => 'Папуа — Новая Гвинея',
        'PY' => 'Парагвай',
        'PE' => 'Перу',
        'PL' => 'Польша',
        'PT' => 'Португалия',
        'PR' => 'Пуэрто-Рико',
        'CG' => 'Республика Конго',
        'KR' => 'Республика Корея (Южная Корея)',
        'RE' => 'Реюньон',
        'RU' => 'Россия',
        'RW' => 'Руанда',
        'RO' => 'Румыния',
        'SV' => 'Сальвадор',
        'WS' => 'Самоа',
        'SM' => 'Сан-Марино',
        'ST' => 'Сан-Томе и Принсипи',
        'SA' => 'Саудовская Аравия',
        'SZ' => 'Свазиленд',
        'MP' => 'Северные Марианские острова',
        'SC' => 'Сейшельские Острова',
        'BL' => 'Сен-Бартелеми',
        'MF' => 'Сен-Мартен',
        'PM' => 'Сен-Пьер и Микелон',
        'SN' => 'Сенегал',
        'VC' => 'Сент-Винсент и Гренадины',
        'KN' => 'Сент-Китс и Невис',
        'LC' => 'Сент-Люсия',
        'RS' => 'Сербия',
        'SG' => 'Сингапур',
        'SY' => 'Сирийская Арабская Республика (Сирия)',
        'SK' => 'Словакия',
        'SI' => 'Словения',
        'SB' => 'Соломоновы Острова',
        'SO' => 'Сомали',
        'SD' => 'Судан',
        'SR' => 'Суринам',
        'US' => 'США',
        'SL' => 'Сьерра-Леоне',
        'TJ' => 'Таджикистан',
        'TH' => 'Таиланд',
        'TZ' => 'Танзания',
        'TC' => 'Тёркс и Кайкос',
        'TG' => 'Того',
        'TK' => 'Токелау',
        'TO' => 'Тонга',
        'TT' => 'Тринидад и Тобаго',
        'TV' => 'Тувалу',
        'TN' => 'Тунис',
        'TM' => 'Туркмения',
        'TR' => 'Турция',
        'UG' => 'Уганда',
        'UZ' => 'Узбекистан',
        'UA' => 'Украина',
        'WF' => 'Уоллис и Футуна',
        'UY' => 'Уругвай',
        'FO' => 'Фареры',
        'FJ' => 'Фиджи',
        'PH' => 'Филиппины',
        'FI' => 'Финляндия',
        'FK' => 'Фолклендские (Мальвинские) острова',
        'FR' => 'Франция',
        'PF' => 'Французская Полинезия',
        'TF' => 'Французские Южные и Антарктические Территории',
        'HM' => 'Остров Херд и острова Макдональд',
        'HR' => 'Хорватия',
        'CF' => 'ЦАР',
        'TD' => 'Чад',
        'ME' => 'Черногория',
        'CZ' => 'Чехия',
        'CL' => 'Чили',
        'CH' => 'Швейцария',
        'SE' => 'Швеция',
        'SJ' => 'Шпицберген и Ян-Майен',
        'LK' => 'Шри-Ланка',
        'EC' => 'Эквадор',
        'GQ' => 'Экваториальная Гвинея',
        'ER' => 'Эритрея',
        'EE' => 'Эстония',
        'ET' => 'Эфиопия',
        'ZA' => 'ЮАР',
        'GS' => 'Южная Георгия и Южные Сандвичевы острова',
        'JM' => 'Ямайка',
        'JP' => 'Япония',
    );

    protected $db_table_name = 'stat';
    protected $db_join_id    = '';

    public function loadBy($options) {

        $data = array();
        $where = array();
        $values = array();
        $joins = array();
        $group = array();

        if (in_array('hour', $options['agregate'])) {
            $table = 'stat_hour';
            $fields[] = "date";
            $fields[] = "hour";
            $group[] = "date";
            $group[] = "hour";
        } elseif (in_array('date', $options['agregate'])) {
            $table = 'stat_date';
            $fields[] = "date";
            $group[] = "date";
        } elseif (in_array('month', $options['agregate'])) {
            $table = 'stat_month';
            $fields[] = "date";
            $group[] = "date";
        } else {
            $table = 'stat_date';
        }

        if (!empty($options['filters'])) {

            if (!empty($options['filters']['offer_id'])) {

                $offers_ids = array();
                foreach ($options['filters']['offer_id'] as $offer_id) {

                    $id = intval($offer_id);
                    if (!empty($id)) {
                        $offers_ids[] = $id;
                    }
                }

                $where[] = "offer_id IN (" . implode(',', $offers_ids) . ")";
            }

            if (!empty($options['filters']['aff_id'])) {

                $aff_ids = array();
                foreach ($options['filters']['aff_id'] as $aff_id) {

                    $id = intval($aff_id);
                    if (!empty($id)) {
                        $aff_ids[] = $id;
                    }
                }

                $where[] = "aff_id IN (" . implode(',', $aff_ids) . ")";
            }

            if (!empty($options['filters']['country'])) {

                $countries_codes = array();
                foreach ($options['filters']['country'] as $country) {

                    $code = preg_replace("/[^A-Z]/", "", $country);
                    if (!empty($code)) {
                        $countries_codes[] = "'" . $code . "'";
                    }
                }

                $where[] = "country IN (" . implode(',', $countries_codes) . ")";
            }

            if (!empty($options['filters']['period'])) {

                $period = explode(' - ', $options['filters']['period']);

                $where[] = "stat.date >= ?";
                $values[] = (preg_match('/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/', $period[0])) ? $period[0] : date("Y-m-d", strtotime("-1week"));

                $where[] = "stat.date <= ?";
                $values[] = (preg_match('/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/', $period[1])) ? $period[1] : date("Y-m-d");
            }
        }

        if (empty($period)) {
            $where[] = "stat.date >= ?";
            $values[] = date("Y-m-d", strtotime("-1week"));
            $where[] = "stat.date <= ?";
            $values[] = date("Y-m-d");
        }

        $having = array();

        foreach ($options['fields'] as $field) {
            switch ($field) {

                case 'impressions':
                    $fields[] = "SUM(stat.impressions) AS impressions";
                    $having[] = 'SUM(stat.impressions) > 0';
                    break;
                case 'clicks':
                    $fields[] = "SUM(stat.clicks) AS clicks";
                    $having[] = 'SUM(stat.clicks) > 0';
                    break;
                case 'installs':
                    $fields[] = "SUM(stat.installs) AS installs";
                    $having[] = 'SUM(stat.installs) > 0';
                    break;
                case 'conversions':
                    $fields[] = "SUM(stat.conversions) AS conversions";
                    $having[] = 'SUM(stat.conversions) > 0';
                    break;
                case 'payout':
                    $fields[] = "SUM(stat.payout) AS payout";
                    break;
                case 'revenue':
                    $fields[] = "SUM(stat.revenue) AS revenue";
                    break;
                case 'offer':
                    $fields[] = "stat.offer_id, offers.name AS offer_name";
                    $group[] = "stat.offer_id";
                    $group[] = "offers.name";
                    $joins[] = "LEFT JOIN offers ON (offers.id = stat.offer_id)";
                    break;
                case 'partner':
                    $fields[] = "stat.aff_id, users.login AS user_login";
                    $group[] = "stat.aff_id";
                    $group[] = "users.login";
                    $joins[] = "LEFT JOIN users ON (users.id = stat.aff_id)";
                    break;
                case 'country':
                    $fields[] = "stat.country";
                    $group[] = "stat.country";
                    break;

                case 'cr':

                    if (!in_array('installs', $options['fields'])) {
                        $fields[] = "SUM(stat.installs) AS installs";
                    }
                    if (!in_array('conversions', $options['fields'])) {
                        $fields[] = "SUM(stat.conversions) AS conversions";
                    }

                    break;
                case 'rpc':

                    if (!in_array('clicks', $options['fields'])) {
                        $fields[] = "SUM(stat.clicks) AS clicks";
                    }
                    if (!in_array('payout', $options['fields'])) {
                        $fields[] = "SUM(stat.payout) AS payout";
                    }

                    break;
            }
        }

        // $fields_str = preg_replace("/[^a-z0-9\_\,]/", '', implode(',', $options['fields']));
        // $fields = explode(',', $fields_str);

        $fields = implode(", ", $fields);
        $where = (!empty($where)) ? "WHERE " . implode(" AND ", $where) : "";
        $joins = (!empty($joins)) ? implode(" ", $joins) : "";
        $group = (!empty($group)) ? "GROUP BY " . implode(", ", $group) : "";
        $having = (!empty($having)) ? "HAVING (" . implode(" OR ", $having) . ")" : "";
        $order = (!empty($options['agregate'])) ? "ORDER BY stat.date DESC" : "";

        $sth = $this->db->prepare("SELECT {$fields} FROM {$table} AS stat {$joins} {$where} {$group} {$having} {$order}");
        $stat = $sth->execute($values)->fetchAll();
        foreach ($stat as $row) {

            if (in_array('hour', $options['agregate'])) {
                $hour = ($row->hour >= 10) ? $row->hour : '0' . $row->hour;
                $row->date = $row->date . ' ' . $hour . ':00';
            }

            if (in_array('offer', $options['fields'])) {
                $row->offer = $row->offer_id . '. ' . $row->offer_name;
            }

            if (in_array('partner', $options['fields'])) {
                $row->partner = $row->aff_id . '. ' . $row->user_login;
            }

            if (!empty($row->country) && !empty($this->countries[$row->country])) {
                $row->country = $this->countries[$row->country];
            }

            if (in_array('cr', $options['fields'])) {
                $row->cr = (!empty($row->installs)) ? round($row->conversions * 100 / $row->installs, 2) . '%' : 0;
            }

            if (in_array('rpc', $options['fields'])) {
                $row->rpc = (!empty($row->clicks)) ? round($row->payout / $row->clicks, 2) . '%' : 0;
            }

            if (!in_array('clicks', $options['fields']) && isset($row->clicks)) {
                unset($row->clicks);
            }
            if (!in_array('payout', $options['fields']) && isset($row->payout)) {
                unset($row->payout);
            }
            if (!in_array('conversions', $options['fields']) && isset($row->conversions)) {
                unset($row->conversions);
            }
        }

        return $stat;
    }

    public function cohort($options) {

        $data = array();
        $where = array();
        $values = array();
        $fields = array();
        $joins = array();
        $group = array();

        $table = 'stat_cohort';

        if (in_array('date', $options['agregate'])) {
            $fields[] = "date";
            $group[] = "date";
        }

        if (!empty($options['filters'])) {

            if (!empty($options['filters']['offer_id'])) {

                $offers_ids = array();
                foreach ($options['filters']['offer_id'] as $offer_id) {

                    $id = intval($offer_id);
                    if (!empty($id)) {
                        $offers_ids[] = $id;
                    }
                }

                $where[] = "offer_id IN (" . implode(',', $offers_ids) . ")";
            }

            if (!empty($options['filters']['aff_id'])) {

                $aff_ids = array();
                foreach ($options['filters']['aff_id'] as $aff_id) {

                    $id = intval($aff_id);
                    if (!empty($id)) {
                        $aff_ids[] = $id;
                    }
                }

                $where[] = "aff_id IN (" . implode(',', $aff_ids) . ")";
            }

            if (!empty($options['filters']['country'])) {

                $countries_codes = array();
                foreach ($options['filters']['country'] as $country) {

                    $code = preg_replace("/[^A-Z]/", "", $country);
                    if (!empty($code)) {
                        $countries_codes[] = "'" . $code . "'";
                    }
                }

                $where[] = "country IN (" . implode(',', $countries_codes) . ")";
            }

            if (!empty($options['filters']['period'])) {

                $period = explode(' - ', $options['filters']['period']);

                $where[] = "stat.date >= ?";
                $values[] = (preg_match('/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/', $period[0])) ? $period[0] : date("Y-m-d", strtotime("-1week"));

                $where[] = "stat.date <= ?";
                $values[] = (preg_match('/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/', $period[1])) ? $period[1] : date("Y-m-d");
            }
        }

        if (empty($period)) {
            $where[] = "stat.date >= ?";
            $values[] = date("Y-m-d", strtotime("-1week"));
            $where[] = "stat.date <= ?";
            $values[] = date("Y-m-d");
        }

        $having = array();

        foreach ($options['fields'] as $field) {
            switch ($field) {

                case 'impressions':
                    if (!key_exists('impressions', $fields)) {
                        $fields['impressions'] = "SUM(stat.impressions) AS impressions";
                        $having[] = 'SUM(stat.impressions) > 0';
                    }
                    break;
                case 'activations':
                    if (!key_exists('activations', $fields)) {
                        $fields['activations'] = "SUM(stat.activations) AS activations";
                        $having[] = 'SUM(stat.activations) > 0';
                    }
                    break;
                case 'payout':
                    if (!key_exists('payout', $fields)) {
                        $fields['payout'] = "ROUND(SUM(stat.payout)::numeric, 2) AS payout";
                    }
                    break;
                case 'revenue':
                    if (!key_exists('revenue', $fields)) {
                        $fields['revenue'] = "ROUND(SUM(stat.revenue)::numeric, 2) AS revenue";
                    }
                    break;
                case 'offer':
                    $fields['offer'] = "stat.offer_id, offers.name AS offer_name";
                    $group[] = "stat.offer_id";
                    $group[] = "offers.name";
                    $joins[] = "LEFT JOIN offers ON (offers.id = stat.offer_id)";
                    break;
                case 'partner':
                    $fields['partner'] = "stat.aff_id, users.login AS user_login";
                    $group[] = "stat.aff_id";
                    $group[] = "users.login";
                    $joins[] = "LEFT JOIN users ON (users.id = stat.aff_id)";
                    break;
                case 'country':
                    $fields['country'] = "stat.country";
                    $group[] = "stat.country";
                    break;
                case 'mediator':
                    $fields['mediator'] = "stat.mediator";
                    $group[] = "stat.mediator";
                    break;

                case 'profit':
                    if (!key_exists('payout', $fields)) {
                        $fields['payout'] = "ROUND(SUM(stat.payout)::numeric, 2) AS payout";
                    }
                    if (!key_exists('revenue', $fields)) {
                        $fields['revenue'] = "ROUND(SUM(stat.revenue)::numeric, 2) AS revenue";
                    }
                    break;
                case 'ltv':
                    if (!key_exists('revenue', $fields)) {
                        $fields['revenue'] = "ROUND(SUM(stat.revenue)::numeric, 2) AS revenue";
                    }
                    if (!key_exists('activations', $fields)) {
                        $fields['activations'] = "SUM(stat.activations) AS activations";
                        $having[] = 'SUM(stat.activations) > 0';
                    }
                    break;
                case 'roi':
                    if (!key_exists('payout', $fields)) {
                        $fields['payout'] = "ROUND(SUM(stat.payout)::numeric, 2) AS payout";
                    }
                    if (!key_exists('revenue', $fields)) {
                        $fields['revenue'] = "ROUND(SUM(stat.revenue)::numeric, 2) AS revenue";
                    }
                    break;
            }
        }

        $fields = implode(", ", $fields);
        $where = (!empty($where)) ? "WHERE " . implode(" AND ", $where) : "";
        $joins = (!empty($joins)) ? implode(" ", $joins) : "";
        $group = (!empty($group)) ? "GROUP BY " . implode(", ", $group) : "";
        $having = (!empty($having)) ? "HAVING (" . implode(" OR ", $having) . ")" : "";
        $order = (!empty($options['agregate'])) ? "ORDER BY stat.date DESC" : "";

        $sth = $this->db->prepare("SELECT {$fields} FROM {$table} AS stat {$joins} {$where} {$group} {$having} {$order}");
        $stat = $sth->execute($values)->fetchAll();
        foreach ($stat as $row) {

            // detalized
            if (in_array('hour', $options['agregate'])) {
                $row->date = $row->date . ' ' . $row->hour . ':00';
            }
            if (in_array('offer', $options['fields'])) {
                $row->offer = $row->offer_id . '. ' . $row->offer_name;
            }
            if (in_array('partner', $options['fields'])) {
                $row->partner = $row->aff_id . '. ' . $row->user_login;
            }
            if (!empty($row->country) && !empty($this->countries[$row->country])) {
                $row->country = $this->countries[$row->country];
            }

            // statistic
            if (in_array('profit', $options['fields'])) {
                $row->profit = $row->revenue - $row->payout;
            }
            if (in_array('ltv', $options['fields'])) {
                $row->ltv = (!empty($row->activations) && $row->activations > 0) ? round($row->revenue / $row->activations, 4) : 0;
            }
            if (in_array('roi', $options['fields'])) {
                $row->roi = (!empty($row->payout) && $row->payout > 0) ? round($row->revenue / $row->payout * 100, 2) : 0;
            }

            // clear unused fields
            if (!in_array('revenue', $options['fields']) && isset($row->revenue)) {
                unset($row->revenue);
            }
            if (!in_array('payout', $options['fields']) && isset($row->payout)) {
                unset($row->payout);
            }
            if (!in_array('activations', $options['fields']) && isset($row->activations)) {
                unset($row->activations);
            }
            if (!in_array('impressions', $options['fields']) && isset($row->impressions)) {
                unset($row->impressions);
            }
        }

        return $stat;
    }

    public function uploadImpressions($date, $hour) {

        $hasoffers = new Hasoffers;
        $stat = array();

        $response = $hasoffers->getStatsReport(array(
            'fields'  => array(
                'Stat.offer_id',
                'Stat.affiliate_id',
                'Stat.country_code',
                'Stat.browser_id',
                'Stat.source',
                'Stat.affiliate_info1',
                'Stat.affiliate_info2',
                'Stat.affiliate_info3',
                'Stat.affiliate_info4',
                'Stat.affiliate_info5',
                'Stat.impressions',
            ),
            'groups'  => array(
                'Stat.offer_id',
                'Stat.affiliate_id',
                'Stat.country_code',
                'Stat.browser_id',
                'Stat.source',
                'Stat.affiliate_info1',
                'Stat.affiliate_info2',
                'Stat.affiliate_info3',
                'Stat.affiliate_info4',
                'Stat.affiliate_info5',
            ),
            'filters' => array(
                'Stat.date'        => array('conditional' => 'EQUAL_TO', 'values' => $date),
                'Stat.hour'        => array('conditional' => 'EQUAL_TO', 'values' => $hour),
                'Stat.impressions' => array('conditional' => 'GREATER_THAN', 'values' => 0),
            ),
            'limit'   => 100000,
        ));

        if (!empty($response->data)) {
            foreach ($response->data as $row) {
                $stat[] = $row->Stat;
            }
        }

        return $stat;
    }

    public function uploadClicks($date, $hour) {

        $hasoffers = new Hasoffers;
        $stat = array();

        $response = $hasoffers->getStatsReport(array(
            'fields'  => array(
                'Stat.offer_id',
                'Stat.affiliate_id',
                'Stat.country_code',
                'Stat.browser_id',
                'Stat.source',
                'Stat.affiliate_info1',
                'Stat.affiliate_info2',
                'Stat.affiliate_info3',
                'Stat.affiliate_info4',
                'Stat.affiliate_info5',
                'Stat.clicks',
            ),
            'groups'  => array(
                'Stat.offer_id',
                'Stat.affiliate_id',
                'Stat.country_code',
                'Stat.browser_id',
                'Stat.source',
                'Stat.affiliate_info1',
                'Stat.affiliate_info2',
                'Stat.affiliate_info3',
                'Stat.affiliate_info4',
                'Stat.affiliate_info5',
            ),
            'filters' => array(
                'Stat.date'   => array('conditional' => 'EQUAL_TO', 'values' => $date),
                'Stat.hour'   => array('conditional' => 'EQUAL_TO', 'values' => $hour),
                'Stat.clicks' => array('conditional' => 'GREATER_THAN', 'values' => 0),
            ),
            'limit'   => 100000,
        ));

        if (!empty($response->data)) {
            foreach ($response->data as $row) {
                $stat[] = $row->Stat;
            }
        }

        return $stat;
    }

    public function uploadInstalls($date, $offer) {

        $appmetrika = new \App\Appmetrika\Appmetrika();

        try {

            $stat = $appmetrika->exportCSV(array(
                'app_id'      => $offer->appmetrika_app_id,
                'report_type' => 'new-users',
                'from'        => $date,
                'to'          => $date,
                'output'      => 'full',
            ));

            if (!empty($stat)) {

                $lines = explode("\n", $stat);

                if (!empty($lines) && !empty($lines[2])) {

                    $res = explode(',', str_replace('"', '', $lines[2]));

                    return (!empty($res[1])) ? intval($res[1]) : 0;
                }
            }

        } catch (\Exception $e) {
            $this->log('stat/appmetrika', '|                   ' . $date . ' |  Error with app#' . $offer->appmetrika_app_id . '. ' . $e->getMessage());
        }

        return 0;
    }

    public function uploadConversions($lastId) {

        $hasoffers = new Hasoffers;
        $stat = array();

        $response = $hasoffers->getConversionsReport(array(
            'fields'  => array(
                'Stat.id',
                'Stat.goal_id',
                'Stat.affiliate_id',
                'Stat.offer_id',
                'Stat.transaction_id',
                'Stat.revenue',
                'Stat.payout',
                'Stat.currency',
                'Stat.session_ip',
                'Stat.country_code',
                'Stat.affiliate_info1',
                'Stat.affiliate_info2',
                'Stat.affiliate_info3',
                'Stat.affiliate_info4',
                'Stat.affiliate_info5',
                'Stat.source',
                'Stat.refer',
                'Browser.id',
                'Stat.status',
                'Stat.datetime',
            ),
            'filters' => array(
                'Stat.id' => array(
                    'conditional' => 'GREATER_THAN',
                    'values'      => $lastId,
                ),
            ),
            'limit'   => 100000,
        ));

        if (!empty($response->data)) {
            foreach ($response->data as $row) {

                if (empty($conversions_exists)) {
                    $row->Stat->device_id = $row->Browser->id;
                    $stat[] = $row->Stat;
                }
            }
        }

        return $stat;
    }

    public function saveImpressions($stat, $date, $hour) {

        $this->db->beginTransaction();

        try {

            $sth = $this->db->prepare("DELETE FROM impressions_hour WHERE date=? AND hour=?");
            $sth->execute([$date, $hour]);

            $sth = $this->db->prepare("
                INSERT INTO impressions_hour (
                    date, hour, offer_id, aff_id, country, device_id, source,
                    aff_sub1, aff_sub2, aff_sub3, aff_sub4, aff_sub5, count
                ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)
            ");
            foreach ($stat as $row) {
                $sth->execute([
                    $date,
                    $hour,
                    $row->offer_id,
                    $row->affiliate_id,
                    $row->country_code,
                    $row->browser_id,
                    $row->source,
                    $row->affiliate_info1,
                    $row->affiliate_info2,
                    $row->affiliate_info3,
                    urldecode($row->affiliate_info4),
                    urldecode($row->affiliate_info5),
                    $row->impressions,
                ]);
            }

        } catch (\PDOException $e) {

            $this->db->rollback();
            throw $e;
        }

        $this->db->commit();
    }

    public function saveClicks($stat, $date, $hour) {

        $this->db->beginTransaction();

        try {

            $sth = $this->db->prepare("DELETE FROM clicks_hour WHERE date=? AND hour=?");
            $sth->execute([$date, $hour]);

            $sth = $this->db->prepare("
                INSERT INTO clicks_hour (
                    date, hour, offer_id, aff_id, country, device_id, source,
                    aff_sub1, aff_sub2, aff_sub3, aff_sub4, aff_sub5, count
                ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)
            ");
            foreach ($stat as $row) {
                $sth->execute([
                    $date,
                    $hour,
                    $row->offer_id,
                    $row->affiliate_id,
                    $row->country_code,
                    $row->browser_id,
                    $row->source,
                    $row->affiliate_info1,
                    $row->affiliate_info2,
                    $row->affiliate_info3,
                    $row->affiliate_info4,
                    $row->affiliate_info5,
                    $row->clicks,
                ]);
            }

        } catch (\PDOException $e) {

            $this->db->rollback();
            throw $e;
        }

        $this->db->commit();
    }

    public function saveConversions($stat) {

        $this->db->beginTransaction();

        try {

            $sth = $this->db->prepare("
                INSERT INTO conversions (
                    id, offer_id, goal_id, aff_id, transaction_id,
                    payout, revenue, currency,
                    ip, country, city, device_id,
                    aff_sub1, aff_sub2, aff_sub3, aff_sub4, aff_sub5,
                    source, refer, status, datetime
                ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
            ");
            foreach ($stat as $row) {
                $sth->execute([
                    $row->id,
                    $row->offer_id,
                    $row->goal_id,
                    $row->affiliate_id,
                    $row->transaction_id,
                    $row->payout,
                    $row->revenue,
                    $row->currency,
                    $row->session_ip,
                    $row->country_code,
                    '',
                    $row->device_id,
                    $row->affiliate_info1,
                    $row->affiliate_info2,
                    $row->affiliate_info3,
                    urldecode($row->affiliate_info4),
                    urldecode($row->affiliate_info5),
                    $row->source,
                    $row->refer,
                    $row->status,
                    $row->datetime,
                ]);
            }

        } catch (\PDOException $e) {

            $this->db->rollback();

            return $e;
        }

        $this->db->commit();
    }

    public function saveInstalls($date, $offer_id, $aff_id, $installs) {

        $recorded = 0;

        $sth = $this->db->prepare("SELECT SUM(count) AS installs FROM installs_hour WHERE date=? AND offer_id=? AND aff_id=?");
        $stat = $sth->execute([$date, $offer_id, $aff_id])->fetch();
        if (!empty($stat) && !empty($stat->installs)) {
            $recorded += $stat->installs;
        }

        if ($installs > $recorded) {

            $hour = ($date == date("Y-m-d")) ? date("H") : 23;
            $recorded = 0;

            $sth = $this->db->prepare("SELECT SUM(count) AS installs FROM installs_hour WHERE date=? AND hour < ? AND offer_id=? AND aff_id=?");
            $stat = $sth->execute([$date, $hour, $offer_id, $aff_id])->fetch();
            if (!empty($stat) && !empty($stat->installs)) {
                $recorded += $stat->installs;
            }

            $count = $installs - $recorded;

            $sth = $this->db->prepare("UPDATE installs_hour SET count=? WHERE date=? AND hour=? AND offer_id=? AND aff_id=?");
            $sth->execute([$count, $date, $hour, $offer_id, $aff_id]);

            if ($sth->rowCount() == 0) {
                $sth = $this->db->prepare("INSERT INTO installs_hour (date,hour,offer_id,aff_id,count) VALUES (?,?,?,?,?)");
                $sth->execute([$date, $hour, $offer_id, $aff_id, $count]);
            }
        }
    }

    public function saveEcpm($date, $stat) {

        $this->db->beginTransaction();

        try {

            foreach ($stat as $row) {

                $values = array($row->ecpm, $date, $row->mediator, $row->country);

                $sth = $this->db->prepare("UPDATE stat_ecpm SET ecpm=? WHERE date=? AND mediator=? AND country=?");
                $sth->execute($values);

                if ($sth->rowCount() == 0) {

                    $sth = $this->db->prepare("INSERT INTO stat_ecpm (ecpm, date, mediator, country) VALUES (?,?,?,?)");
                    $sth->execute($values);
                }
            }
        } catch (\PDOException $e) {

            $this->db->rollback();

            return $e;
        }

        $this->db->commit();
    }

    public function agregateHour($date, $hour) {

        $datetime = $date . " " . $hour . ":00:00";
        $datetime_next = date("Y-m-d H", strtotime($datetime . "+1hour")) . ":00:00";

        $sth = $this->db->prepare("
            SELECT offer_id, aff_id, country, SUM(impressions) as impressions, SUM(clicks) as clicks, SUM(installs) as installs, SUM(conversions) as conversions, SUM(payout) AS payout, SUM(revenue) AS revenue, currency
            FROM (
                (
                    SELECT offer_id, aff_id, country, SUM(count) AS impressions, 0 AS clicks, 0 AS installs, 0 AS conversions, 0 AS payout, 0 AS revenue, 'USD' AS currency
                    FROM impressions_hour
                    WHERE date = '{$date}' AND hour = {$hour}
                    GROUP BY offer_id, aff_id, country
                )
              UNION
                (
                    SELECT offer_id, aff_id, country, 0 AS impressions, SUM(count) AS clicks, 0 AS installs, 0 AS conversions, 0 AS payout, 0 AS revenue, 'USD' AS currency
                    FROM clicks_hour
                    WHERE date = '{$date}' AND hour = {$hour}
                    GROUP BY offer_id, aff_id, country
                )
			  UNION
                (
                    SELECT offer_id, aff_id, 'INT' AS country, 0 AS impressions, 0 AS clicks, SUM(count) AS installs, 0 AS conversions, 0 AS payout, 0 AS revenue, 'USD' AS currency
                    FROM installs_hour
                    WHERE date = '{$date}' AND hour = {$hour}
                    GROUP BY offer_id, aff_id
                )
              UNION
                (
                    SELECT offer_id, aff_id, country, 0 AS impressions, 0 AS clicks, COUNT(id) AS installs, 0 AS conversions, SUM(payout) AS payout, SUM(revenue) AS revenue, currency
                    FROM conversions
                    WHERE datetime >= '{$datetime}' AND datetime < '{$datetime_next}' AND status = 'approved' AND goal_id = 0
                    GROUP BY offer_id, aff_id, country, currency
                )
              UNION
                (
                    SELECT offer_id, aff_id, country, 0 AS impressions, 0 AS clicks, 0 AS installs, COUNT(id) AS conversions, SUM(payout) AS payout, SUM(revenue) AS revenue, currency
                    FROM conversions
                    WHERE
						CASE WHEN (aff_sub4 ~ '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}') THEN to_timestamp(aff_sub4,'YYYY-MM-DD HH24:MI:SS')::timestamp without time zone >= '{$datetime}'
							ELSE datetime >= '{$datetime}'
						END
						AND CASE WHEN (aff_sub4 ~ '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}') THEN to_timestamp(aff_sub4,'YYYY-MM-DD HH24:MI:SS')::timestamp without time zone < '{$datetime_next}' 
							ELSE datetime < '{$datetime_next}'
						END
						AND status = 'approved' AND goal_id > 0 AND payout > 0
                    GROUP BY offer_id, aff_id, country, currency
                )
            ) AS stat
            GROUP BY offer_id, aff_id, country, currency
        ");

        $stat = $sth->execute()->fetchAll();
        if (empty($stat)) {
            return;
        }

        $this->db->beginTransaction();

        try {

            $sth = $this->db->prepare("DELETE FROM stat_hour WHERE date=? AND hour=?");
            $sth->execute([$date, $hour]);

            $sth = $this->db->prepare("
                INSERT INTO stat_hour (
                    date, hour, offer_id, aff_id, country,
                    impressions, clicks, installs, conversions, payout, revenue, currency
				) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
            ");
            foreach ($stat as $row) {
                $sth->execute([
                    $date,
                    $hour,
                    $row->offer_id,
                    $row->aff_id,
                    $row->country,
                    $row->impressions,
                    $row->clicks,
                    $row->installs,
                    $row->conversions,
                    $row->payout,
                    $row->revenue,
                    $row->currency,
                ]);
            }

        } catch (\PDOException $e) {

            $this->db->rollback();
            throw $e;
        }

        $this->db->commit();
    }

    public function agregateDate($date) {

        $sth = $this->db->prepare("
            SELECT offer_id, aff_id, country, SUM(impressions) as impressions, SUM(clicks) as clicks, SUM(installs) as installs, SUM(conversions) as conversions, SUM(payout) AS payout, SUM(revenue) AS revenue, currency
			FROM stat_hour AS stat
			WHERE date = ? 
			GROUP BY offer_id, aff_id, country, currency
        ");
        $stat = $sth->execute([$date])->fetchAll();

        $this->db->beginTransaction();

        try {

            $sth = $this->db->prepare("DELETE FROM stat_date WHERE date=?");
            $sth->execute([$date]);

            $sth = $this->db->prepare("
                INSERT INTO stat_date (
                    date, offer_id, aff_id, country,
                    impressions, clicks, installs, conversions, payout, revenue, currency
				) VALUES (?,?,?,?,?,?,?,?,?,?,?)
            ");
            foreach ($stat as $row) {
                $sth->execute([
                    $date,
                    $row->offer_id,
                    $row->aff_id,
                    $row->country,
                    $row->impressions,
                    $row->clicks,
                    $row->installs,
                    $row->conversions,
                    $row->payout,
                    $row->revenue,
                    $row->currency,
                ]);
            }

        } catch (\PDOException $e) {

            $this->db->rollback();
            throw $e;
        }

        $this->db->commit();
    }

    public function agregateMonth($date) {

        $datetime = date("Y-m", strtotime($date)) . "-01";
        $datetime_next = date("Y-m", strtotime($date . "+1month")) . "-01";

        $sth = $this->db->prepare("
            SELECT offer_id, aff_id, country, SUM(impressions) as impressions, SUM(clicks) as clicks, SUM(installs) as installs, SUM(conversions) as conversions, SUM(payout) AS payout, SUM(revenue) AS revenue, currency
			FROM stat_date AS stat
			WHERE date >= ? AND date < ? 
			GROUP BY offer_id, aff_id, country, currency
        ");
        $stat = $sth->execute([$datetime, $datetime_next])->fetchAll();

        $this->db->beginTransaction();

        try {

            $sth = $this->db->prepare("DELETE FROM stat_month WHERE date=?");
            $sth->execute([$datetime]);

            $sth = $this->db->prepare("
                INSERT INTO stat_month (
                    date, offer_id, aff_id, country,
                    impressions, clicks, installs, conversions, payout, revenue, currency
				) VALUES (?,?,?,?,?,?,?,?,?,?,?)
            ");
            foreach ($stat as $row) {
                $sth->execute([
                    $datetime,
                    $row->offer_id,
                    $row->aff_id,
                    $row->country,
                    $row->impressions,
                    $row->clicks,
                    $row->installs,
                    $row->conversions,
                    $row->payout,
                    $row->revenue,
                    $row->currency,
                ]);
            }

        } catch (\PDOException $e) {

            $this->db->rollback();
            throw $e;
        }

        $this->db->commit();
    }

    public function agregateImpressionsLive($date) {

        $date_to = date("Y-m-d", strtotime($date . "+1day"));

        $sth = $this->db->prepare("
			SELECT conv.aff_sub1 AS visitor_guid, conv.offer_id, conv.aff_id, COALESCE(imp.country, 'INT') AS country, COALESCE(imp.aff_sub2, '-') AS mediator,
				   SUM(imp.count) AS count, MIN(imp.date) AS date_begin, MAX(imp.date) AS date_end,
				   COALESCE(SUM(imp.count * ecpm.ecpm), SUM(imp.count * ecpm_all.ecpm), 0) AS revenue
			FROM conversions AS conv
			LEFT JOIN impressions_hour AS imp ON (conv.aff_sub1 = imp.aff_sub1 AND conv.offer_id = imp.offer_id AND conv.aff_id = imp.aff_id AND imp.date >= ?)
			LEFT JOIN stat_ecpm AS ecpm ON (ecpm.date = imp.date AND ecpm.country = imp.country AND ecpm.mediator = imp.aff_sub2)
			LEFT JOIN stat_ecpm AS ecpm_all ON (ecpm_all.date = imp.date AND ecpm_all.country = 'All' AND ecpm_all.mediator = imp.aff_sub2)
			WHERE conv.aff_sub4 >= ? AND conv.aff_sub4 < ? AND conv.goal_id > 0 AND conv.payout > 0
			GROUP BY conv.aff_sub1, conv.offer_id, conv.aff_id, imp.country, imp.aff_sub2
			HAVING SUM(imp.count) > 0
		");
        $stat = $sth->execute([$date, $date . ' 00:00:00', $date_to . '00:00:00'])->fetchAll();

        $this->db->beginTransaction();

        try {

            foreach ($stat as $row) {

                $values = array(
                    $row->count,
                    $row->date_begin,
                    $row->date_end,
                    $row->revenue,
                    'USD',
                    $date,
                    $row->visitor_guid,
                    $row->offer_id,
                    $row->aff_id,
                    $row->country,
                    $row->mediator,
                );

                $sth = $this->db->prepare("
					UPDATE impressions_live SET count=?, date_begin=?, date_end=?, revenue=?, currency=?
					WHERE date_install=? AND visitor_guid=? AND offer_id=? AND aff_id=? AND country=? AND mediator=?");
                $sth->execute($values);

                if ($sth->rowCount() == 0) {

                    $sth = $this->db->prepare("
						INSERT INTO impressions_live (count, date_begin, date_end, revenue, currency, date_install, visitor_guid, offer_id, aff_id, country, mediator)
						VALUES (?,?,?,?,?,?,?,?,?,?,?)");
                    $sth->execute($values);
                }
            }
        } catch (\PDOException $e) {

            $this->db->rollback();
            throw $e;
        }

        $this->db->commit();
    }

    public function agregateCohort($date) {

        $sth = $this->db->prepare("
			SELECT date, aff_id, offer_id, country, mediator, SUM(activations) AS activations, SUM(payout) AS payout, SUM(impressions) AS impressions, SUM(revenue) AS revenue 
			FROM ((
				SELECT date_install AS date, aff_id, offer_id, country, mediator, 0 AS activations, 0 AS payout, SUM(count) AS impressions, ROUND(SUM(revenue)::numeric, 2) AS revenue
				FROM impressions_live
				WHERE date_install = ?
				GROUP BY date_install, aff_id, offer_id, country, mediator
				ORDER BY date_install
			) UNION (
				SELECT date_install AS date, aff_id, offer_id, country, mediator, COUNT(*) AS activations, ROUND(SUM(payout)::numeric, 2) AS payout, 0 AS impressions, 0 AS revenue
				FROM activations
				WHERE date_install = ?
				GROUP BY date_install, aff_id, offer_id, country, mediator
				ORDER BY date_install
			)) AS cohort
			GROUP BY date, aff_id, offer_id, country, mediator
			ORDER BY date DESC;
		");
        $stat = $sth->execute([$date, $date])->fetchAll();

        $this->db->beginTransaction();

        try {

            $sth = $this->db->prepare("DELETE FROM stat_cohort WHERE date=?");
            $sth->execute([$date]);

            $sth = $this->db->prepare("
                INSERT INTO stat_cohort (
                    date, offer_id, aff_id, country, mediator,
                    activations, impressions, payout, revenue, currency
				) VALUES (?,?,?,?,?,?,?,?,?,?)
            ");
            foreach ($stat as $row) {

                if (empty($row->country)) {
                    $row->country = 'INT';
                }

                if (empty($row->mediator)) {
                    $row->mediator = '-';
                }

                $sth->execute([
                    $date,
                    $row->offer_id,
                    $row->aff_id,
                    $row->country,
                    $row->mediator,
                    $row->activations,
                    $row->impressions,
                    $row->payout,
                    $row->revenue,
                    'USD',
                ]);
            }

        } catch (\PDOException $e) {

            $this->db->rollback();
            throw $e;
        }

        $this->db->commit();
    }

    public function getState($action) {

        $filename = $_SERVER['DOCUMENT_ROOT'] . '/../../src/Resources/States/stat_' . $action . '.state';

        $state = new \stdClass;
        $state->busy = false;

        if (file_exists($filename)) {

            $handle = fopen($filename, "r");
            if ($handle) {

                if (($buffer = fgets($handle, 4096)) !== false) {
                    $state->busy = ($buffer == 'busy');
                }

                if (($buffer = fgets($handle, 4096)) !== false) {
                    $state->last_timestamp = preg_replace('/[^R\d]+/i', '', trim($buffer));
                }

                fclose($handle);
            }
        }

        if (!$state->busy && empty($state->last_timestamp)) {
            $state->last_timestamp = strtotime("-2week");
        }

        return $state;
    }

    public function setState($action, $state) {

        $filename = $_SERVER['DOCUMENT_ROOT'] . '/../../src/Resources/States/stat_' . $action . '.state';

        $handle = fopen($filename, "w");

        if ($state->busy) {
            fwrite($handle, 'busy');
        } else {
            fwrite($handle, 'free');
        }

        if (!empty($state->last_timestamp)) {
            fwrite($handle, "\r\n" . $state->last_timestamp);
        }

        fclose($handle);
    }

    /**
     * Get last conversion_id
     *
     * @return int
     */
    public function getLastConversionId() {

        $result = $this->db->query("SELECT MAX(id) AS id FROM conversions")->fetch();

        return (!empty($result) && !empty($result->id)) ? $result->id : 0;
    }

    public function checkUniqueConversion($offer_id, $goal_id, $aff_id, $aff_sub1) {

        $sth = $this->db->prepare("SELECT id FROM conversions WHERE offer_id=? AND goal_id=? AND aff_id=? AND aff_sub1=?");
        $conversions_exists = $sth->execute([$offer_id, $goal_id, $aff_id, $aff_sub1])->fetchAll();

        return (empty($conversions_exists));
    }

    public function createConversion($data) {

        $hasoffers = new Hasoffers;

        $params = array(
            'ad_id'         => '',
            'offer_id'      => $data['offer_id'],
            'affiliate_id'  => $data['aff_id'],
            'advertiser_id' => 1,
            'payout'        => 0,
            'revenue'       => 0,
            'status'        => 'approved',
            'datetime'      => ($data['date'] != date("Y-m-d")) ? $data['date'] : date("Y-m-d H:i:s"),
        );

        $res = $hasoffers->createConversion($params);

        if (empty($res->Conversion) || empty($res->Conversion->id)) {
            return false;
        }

        return $res->Conversion->id;
    }

    public function updateConversion($conversion_id, $field, $value) {

        $hasoffers = new Hasoffers;
        $hasoffers->updateFieldConversion($conversion_id, $field, $value);
    }

    public function loadCountriesPayouts() {

        $countries = array();

        $rows = $this->db->query("SELECT * FROM countries ORDER BY code")->fetchAll();
        foreach ($rows as $row) {
            $countries[$row->code] = $row;
        }

        return $countries;
    }

    public function getLastCohortDate() {

        $res = $this->db->query("SELECT MAX(date) AS date FROM stat_cohort")->fetch();
        if (!empty($res) && !empty($res->date)) {
            return $res->date;
        }

        $res = $this->db->query("SELECT MIN(date) AS date FROM stat_date")->fetch();
        if (!empty($res) && !empty($res->date)) {
            return $res->date;
        }

        return date("Y-m-d");
    }

    public function getLastEcpmDate() {

        $res = $this->db->query("SELECT MAX(date) AS date FROM stat_ecpm")->fetch();
        if (!empty($res) && !empty($res->date)) {
            return $res->date;
        }

        $res = $this->db->query("SELECT MIN(date) AS date FROM stat_date")->fetch();
        if (!empty($res) && !empty($res->date)) {
            return $res->date;
        }

        return date("Y-m-d", strtotime("-1week"));
    }

    public function getLastImpressionsLiveDate() {

        $res = $this->db->query("SELECT MAX(date_end) AS date FROM impressions_live")->fetch();
        if (!empty($res) && !empty($res->date)) {
            return $res->date;
        }

        $res = $this->db->query("SELECT MIN(date) AS date FROM impressions_hour")->fetch();
        if (!empty($res) && !empty($res->date)) {
            return $res->date;
        }

        return date("Y-m-d");
    }

    public function getWeekPayouts($date_from, $date_to) {

        $sth = $this->db->prepare("
            SELECT users.login, info.wmz, trunc(SUM(payout)::numeric, 2) AS sum
			FROM conversions
			LEFT JOIN users ON (users.id = conversions.aff_id)
			LEFT JOIN users_info AS info ON (info.user_id = conversions.aff_id)
			WHERE datetime >= ? AND datetime < ? AND aff_id NOT IN (1, 101) AND goal_id > 0 AND payout > 0 AND conversions.status = 'approved'
			GROUP BY users.login, info.wmz
			ORDER BY SUM(payout) DESC
        ");

        return $sth->execute([$date_from, date("Y-m-d", strtotime($date_to . "+1day"))])->fetchAll();
    }

    public function sumWeekPayouts($date_from, $date_to) {

        $sth = $this->db->prepare("
            SELECT trunc(SUM(payout)::numeric, 2) AS sum
			FROM conversions
			WHERE datetime >= ? AND datetime < ? AND aff_id NOT IN (1, 101) AND goal_id > 0 AND payout > 0 AND conversions.status = 'approved'
        ");

        return $sth->execute([$date_from, date("Y-m-d", strtotime($date_to . "+1day"))])->fetch()->sum;
    }

    /**
     * Insert item into the main table
     *
     * @param Item $item
     */
    public function insert($item) { }

    /**
     * Update item from the main table
     *
     * @param Item $item
     */
    public function update($item) { }
}