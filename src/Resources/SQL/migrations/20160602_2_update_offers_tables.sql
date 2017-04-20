--
-- Offers goals lang
--
CREATE TABLE offers_goals_lang (
    nid integer NOT NULL,
    goal_id integer NOT NULL,
    lang text NOT NULL,
    name text NOT NULL,
    description text,
    CONSTRAINT offers_goals_lang_pk PRIMARY KEY (nid,goal_id,lang)
) WITH (
    OIDS=FALSE
);
COMMENT ON COLUMN offers_goals_lang.lang IS 'Язык';
COMMENT ON COLUMN offers_goals_lang.name IS 'Название цели';
COMMENT ON COLUMN offers_goals_lang.description IS 'Описание цели';



--
-- Offers targeting
--
ALTER TABLE offers_targeting ADD COLUMN nid integer;
ALTER TABLE offers_targeting ADD COLUMN device text[];
COMMENT ON COLUMN offers_targeting.device IS 'Устройство';
COMMENT ON COLUMN offers_targeting.country IS 'Страна';

--
-- update primary key
--
ALTER TABLE offers_targeting DROP CONSTRAINT offers_targeting_pkey;
ALTER TABLE offers_targeting ADD CONSTRAINT offers_targeting_pk PRIMARY KEY (nid,offer_id);



--
-- Offers options
--
ALTER TABLE offers_options ADD COLUMN nid integer;

--
-- drop unused columns
--
ALTER TABLE offers_options DROP COLUMN IF EXISTS a2a_app_id;
ALTER TABLE offers_options DROP COLUMN IF EXISTS wrapper_is_protected;
ALTER TABLE offers_options DROP COLUMN IF EXISTS appmetrika_app_id;
ALTER TABLE offers_options DROP COLUMN IF EXISTS appmetrika_api_key;
ALTER TABLE offers_options DROP COLUMN IF EXISTS apk_filename;
ALTER TABLE offers_options DROP COLUMN IF EXISTS return_type;
ALTER TABLE offers_options DROP COLUMN IF EXISTS landing_name;
ALTER TABLE offers_options DROP COLUMN IF EXISTS landing_desc1;
ALTER TABLE offers_options DROP COLUMN IF EXISTS landing_desc2;