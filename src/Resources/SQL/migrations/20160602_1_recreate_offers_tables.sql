--
-- Drop offers
--
DROP TABLE IF EXISTS public.offers;

--
-- Create offers
--
CREATE TABLE offers (
    nid integer NOT NULL,
    id integer NOT NULL,
    advertiser_id integer NOT NULL,
    app_os text,
    app_id text,
    preview_url text NOT NULL,
    tracking_link text NOT NULL,
    categories integer[],
    groups integer[],
    availability integer DEFAULT 0,
    status text NOT NULL,
    date_a timestamp without time zone,
    date_e timestamp without time zone,
    date_c timestamp without time zone DEFAULT now(),
    date_u timestamp without time zone DEFAULT now(),
    CONSTRAINT offers_pk PRIMARY KEY (nid, id)
) WITH (
    OIDS=FALSE
);

COMMENT ON COLUMN offers.advertiser_id IS 'ID рекламодателя';
COMMENT ON COLUMN offers.app_os IS 'Платформа приложения';
COMMENT ON COLUMN offers.app_id IS 'ID приложения';
COMMENT ON COLUMN offers.preview_url IS 'Ссылка на приложение в маркете';
COMMENT ON COLUMN offers.tracking_link IS 'Трекинговая ссылка рекламодателя';
COMMENT ON COLUMN offers.categories IS 'Категории';
COMMENT ON COLUMN offers.groups IS 'группы';
COMMENT ON COLUMN offers.availability IS 'Доступность: 0 - открытый; 1 - по заявкам; 2 - приватный';
COMMENT ON COLUMN offers.status IS 'Статус: active|paused|pending|deleted|expired';
COMMENT ON COLUMN offers.date_a IS 'Дата активации';
COMMENT ON COLUMN offers.date_e IS 'Дата истечения';
COMMENT ON COLUMN offers.date_c IS 'Дата создания';
COMMENT ON COLUMN offers.date_u IS 'Дата изменения';



--
-- Drop deprecated table offers_translate
--
DROP TABLE IF EXISTS offers_translate;

--
-- Create new table offers_lang for offers translations
--
CREATE TABLE offers_lang (
    nid integer NOT NULL,
    offer_id integer NOT NULL,
    lang text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    recommendations text,
    recommendations_partners text,
    conditions text,
    restrictions text,
    CONSTRAINT offers_lang_pk PRIMARY KEY (nid,offer_id,lang)
) WITH (
OIDS=FALSE
);

COMMENT ON COLUMN offers_lang.name IS 'Название оффера';
COMMENT ON COLUMN offers_lang.description IS 'Описание оффера';
COMMENT ON COLUMN offers_lang.recommendations IS 'Рекомендации для менеджеров';
COMMENT ON COLUMN offers_lang.recommendations_partners IS 'Рекомендации для партнеров';
COMMENT ON COLUMN offers_lang.conditions IS 'Условия работы с оффером';
COMMENT ON COLUMN offers_lang.restrictions IS 'Ограничения и запреты';



--
-- Offers goals
--
DROP TABLE IF EXISTS offers_goals;

CREATE TABLE offers_goals (
    nid integer NOT NULL,
    id integer NOT NULL,
    offer_id integer NOT NULL,
    cpa double precision NOT NULL,
    cpa_currency text NOT NULL,
    rpa double precision NOT NULL,
    rpa_currency text NOT NULL,
    CONSTRAINT offers_goals_pk PRIMARY KEY (nid,id,offer_id)
) WITH (
OIDS=FALSE
);

COMMENT ON COLUMN offers_goals.cpa IS 'Выплата партнеру';
COMMENT ON COLUMN offers_goals.cpa_currency IS 'Валюта выплаты';
COMMENT ON COLUMN offers_goals.rpa IS 'Доход';
COMMENT ON COLUMN offers_goals.rpa_currency IS 'Валюта дохода';