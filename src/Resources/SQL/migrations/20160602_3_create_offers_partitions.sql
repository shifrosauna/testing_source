--
-- offers
--
CREATE SEQUENCE _1_offers_id_seq;
CREATE TABLE _1_offers (LIKE offers INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers ADD CONSTRAINT _1_offers_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers ALTER COLUMN id SET DEFAULT nextval('_1_offers_id_seq' :: regclass);
ALTER TABLE _1_offers INHERIT offers;

--
-- Offers lang
--
CREATE TABLE _1_offers_lang (LIKE offers_lang INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_lang ADD CONSTRAINT _1_offers_lang_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_lang ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_lang INHERIT offers_lang;

--
-- Offers goals
--
CREATE SEQUENCE _1_offers_goals_id_seq;
CREATE TABLE _1_offers_goals (LIKE offers_goals INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_goals ADD CONSTRAINT _1_offers_goals_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_goals ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_goals ALTER COLUMN id SET DEFAULT nextval('_1_offers_goals_id_seq' :: regclass);
ALTER TABLE _1_offers_goals INHERIT offers_goals;

--
-- Offers goals land
--
CREATE TABLE _1_offers_goals_lang (LIKE offers_goals_lang INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_goals_lang ADD CONSTRAINT _1_offers_goals_lang_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_goals_lang ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_goals_lang INHERIT offers_goals_lang;

--
-- Offers targeting
--
CREATE TABLE _1_offers_targeting (LIKE offers_targeting INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_targeting ADD CONSTRAINT _1_offers_targeting_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_targeting ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_targeting INHERIT offers_targeting;

--
-- Offers options
--
CREATE TABLE _1_offers_options (LIKE offers_options INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_options ADD CONSTRAINT _1_offers_options_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_options ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_options INHERIT offers_options;