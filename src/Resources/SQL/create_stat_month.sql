CREATE TABLE stat_month (
    date date NOT NULL,
    offer_id int NOT NULL,
    aff_id int NOT NULL,
    country text,
    impressions int,
    clicks int,
    installs int,
    conversions int,
    payout double precision,
    revenue double precision,
    currency text,
    CONSTRAINT stat_month_pkey PRIMARY KEY (date,offer_id,aff_id,country,currency)
);

CREATE INDEX stat_month_date_index ON stat_month USING btree (date);
CREATE INDEX stat_month_offer_id_index ON stat_month USING btree (offer_id);
CREATE INDEX stat_month_aff_id_index ON stat_month USING btree (aff_id);
CREATE INDEX stat_month_country_index ON stat_month USING btree (country);

CREATE TABLE stat_month_2016 (CONSTRAINT stat_month_2016_pkey PRIMARY KEY (date,offer_id,aff_id,country,currency), CONSTRAINT stat_month_2016_date_check CHECK (date >= TIMESTAMP '2016-01-01')) INHERITS (stat_month);
CREATE TABLE stat_month_2015 (CONSTRAINT stat_month_2015_pkey PRIMARY KEY (date,offer_id,aff_id,country,currency), CONSTRAINT stat_month_2015_date_check CHECK (date >= TIMESTAMP '2015-01-01' AND date < TIMESTAMP '2016-01-01')) INHERITS (stat_month);
CREATE TABLE stat_month_2014 (CONSTRAINT stat_month_2014_pkey PRIMARY KEY (date,offer_id,aff_id,country,currency), CONSTRAINT stat_month_2014_date_check CHECK (date >= TIMESTAMP '2014-01-01' AND date < TIMESTAMP '2015-01-01')) INHERITS (stat_month);
CREATE TABLE stat_month_2013 (CONSTRAINT stat_month_2013_pkey PRIMARY KEY (date,offer_id,aff_id,country,currency), CONSTRAINT stat_month_2013_date_check CHECK (date >= TIMESTAMP '2013-01-01' AND date < TIMESTAMP '2014-01-01')) INHERITS (stat_month);

CREATE INDEX stat_month_2016_date_index ON stat_month_2016 USING btree (date);
CREATE INDEX stat_month_2015_date_index ON stat_month_2015 USING btree (date);
CREATE INDEX stat_month_2014_date_index ON stat_month_2014 USING btree (date);
CREATE INDEX stat_month_2013_date_index ON stat_month_2013 USING btree (date);

CREATE INDEX stat_month_2016_offer_id_index ON stat_month_2016 USING btree (offer_id);
CREATE INDEX stat_month_2015_offer_id_index ON stat_month_2015 USING btree (offer_id);
CREATE INDEX stat_month_2014_offer_id_index ON stat_month_2014 USING btree (offer_id);
CREATE INDEX stat_month_2013_offer_id_index ON stat_month_2013 USING btree (offer_id);

CREATE INDEX stat_month_2016_aff_id_index ON stat_month_2016 USING btree (aff_id);
CREATE INDEX stat_month_2015_aff_id_index ON stat_month_2015 USING btree (aff_id);
CREATE INDEX stat_month_2014_aff_id_index ON stat_month_2014 USING btree (aff_id);
CREATE INDEX stat_month_2013_aff_id_index ON stat_month_2013 USING btree (aff_id);

CREATE INDEX stat_month_2016_country_index ON stat_month_2016 USING btree (country);
CREATE INDEX stat_month_2015_country_index ON stat_month_2015 USING btree (country);
CREATE INDEX stat_month_2014_country_index ON stat_month_2014 USING btree (country);
CREATE INDEX stat_month_2013_country_index ON stat_month_2013 USING btree (country);


CREATE OR REPLACE FUNCTION stat_month_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN

    -- Partitioning --
    IF (NEW.date >= TIMESTAMP '2015-01-01' AND NEW.date < TIMESTAMP '2016-01-01') THEN INSERT INTO stat_month_2015 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-01-01' AND NEW.date < TIMESTAMP '2015-01-01') THEN INSERT INTO stat_month_2014 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-01-01' AND NEW.date < TIMESTAMP '2014-01-01') THEN INSERT INTO stat_month_2013 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-01-01') THEN INSERT INTO stat_month_2016 VALUES (NEW.*);
    ELSE RAISE EXCEPTION 'Date % is out of range. Fix stat_month', NEW.date;
    END IF;

    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER stat_month_before_insert
   BEFORE INSERT ON stat_month
   FOR EACH ROW EXECUTE PROCEDURE stat_month_insert_trigger();