--
-- drop tracking columns from offers
--
ALTER TABLE offers DROP COLUMN IF EXISTS advertiser_id CASCADE;
ALTER TABLE offers DROP COLUMN IF EXISTS tracking_link CASCADE;
ALTER TABLE _1_offers DROP COLUMN IF EXISTS advertiser_id;
ALTER TABLE _1_offers DROP COLUMN IF EXISTS tracking_link;

DROP TABLE IF EXISTS offers_targeting CASCADE;

--
-- Offers tracking
--
CREATE TABLE offers_tracking (
    nid integer NOT NULL,
    id integer NOT NULL,
    offer_id integer NOT NULL,
    advertiser_id integer NOT NULL,
    link text NOT NULL,
    payout double precision NOT NULL,
    payout_currency text NOT NULL,
    revenue double precision NOT NULL,
    revenue_currency text NOT NULL,
    countries text[],
    devices text[],
    status integer NOT NULL DEFAULT 1,
    date_c timestamp without time zone DEFAULT now(),
    date_u timestamp without time zone DEFAULT now(),
    CONSTRAINT offers_tracking_pk PRIMARY KEY (nid, id)
) WITH (
    OIDS=FALSE
);

COMMENT ON COLUMN offers_tracking.advertiser_id IS 'ID рекламодателя';
COMMENT ON COLUMN offers_tracking.link IS 'Трекинговая ссылка рекламодателя';
COMMENT ON COLUMN offers_tracking.payout IS 'Выплата партнеру';
COMMENT ON COLUMN offers_tracking.payout_currency IS 'Валюта выплаты';
COMMENT ON COLUMN offers_tracking.revenue IS 'Доход';
COMMENT ON COLUMN offers_tracking.revenue_currency IS 'Валюта дохода';
COMMENT ON COLUMN offers_tracking.countries IS 'Таргетирнг по странам';
COMMENT ON COLUMN offers_tracking.devices IS 'Таргетинг по устройствам';
COMMENT ON COLUMN offers_tracking.status IS 'Статус: 0|1';
COMMENT ON COLUMN offers_tracking.date_c IS 'Дата создания';
COMMENT ON COLUMN offers_tracking.date_u IS 'Дата изменения';

CREATE INDEX offers_tracking_offer_id_index ON offers_tracking USING btree (offer_id);

--
-- Offers tracking partition
--
CREATE SEQUENCE _1_offers_tracking_id_seq;
CREATE TABLE _1_offers_tracking (LIKE offers_tracking INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_tracking ADD CONSTRAINT _1_offers_tracking_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_tracking ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_tracking ALTER COLUMN id SET DEFAULT nextval('_1_offers_tracking_id_seq' :: regclass);
ALTER TABLE _1_offers_tracking INHERIT offers_tracking;