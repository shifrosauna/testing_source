CREATE TABLE stat_cohort (
    date date NOT NULL,
    offer_id int NOT NULL,
    aff_id int NOT NULL,
    country text,
    mediator text,
    activations int,
    impressions int,
    payout double precision,
    revenue double precision,
    currency text
);

ALTER TABLE ONLY stat_cohort ADD CONSTRAINT stat_cohort_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator);
CREATE INDEX stat_cohort_date_index ON stat_cohort USING btree (date);
CREATE INDEX stat_cohort_offer_id_index ON stat_cohort USING btree (offer_id);
CREATE INDEX stat_cohort_aff_id_index ON stat_cohort USING btree (aff_id);
CREATE INDEX stat_cohort_country_index ON stat_cohort USING btree (country);
CREATE INDEX stat_cohort_mediator_index ON stat_cohort USING btree (mediator);

CREATE TABLE stat_cohort_2016_12 (CONSTRAINT stat_cohort_2016_12_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_12_date_check CHECK (date >= TIMESTAMP '2016-12-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_11 (CONSTRAINT stat_cohort_2016_11_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_11_date_check CHECK (date >= TIMESTAMP '2016-11-01' AND date < TIMESTAMP '2016-12-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_10 (CONSTRAINT stat_cohort_2016_10_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_10_date_check CHECK (date >= TIMESTAMP '2016-10-01' AND date < TIMESTAMP '2016-11-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_09 (CONSTRAINT stat_cohort_2016_09_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_09_date_check CHECK (date >= TIMESTAMP '2016-09-01' AND date < TIMESTAMP '2016-10-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_08 (CONSTRAINT stat_cohort_2016_08_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_08_date_check CHECK (date >= TIMESTAMP '2016-08-01' AND date < TIMESTAMP '2016-09-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_07 (CONSTRAINT stat_cohort_2016_07_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_07_date_check CHECK (date >= TIMESTAMP '2016-07-01' AND date < TIMESTAMP '2016-08-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_06 (CONSTRAINT stat_cohort_2016_06_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_06_date_check CHECK (date >= TIMESTAMP '2016-06-01' AND date < TIMESTAMP '2016-07-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_05 (CONSTRAINT stat_cohort_2016_05_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_05_date_check CHECK (date >= TIMESTAMP '2016-05-01' AND date < TIMESTAMP '2016-06-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_04 (CONSTRAINT stat_cohort_2016_04_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_04_date_check CHECK (date >= TIMESTAMP '2016-04-01' AND date < TIMESTAMP '2016-05-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_03 (CONSTRAINT stat_cohort_2016_03_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_03_date_check CHECK (date >= TIMESTAMP '2016-03-01' AND date < TIMESTAMP '2016-04-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_02 (CONSTRAINT stat_cohort_2016_02_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_02_date_check CHECK (date >= TIMESTAMP '2016-02-01' AND date < TIMESTAMP '2016-03-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2016_01 (CONSTRAINT stat_cohort_2016_01_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2016_01_date_check CHECK (date >= TIMESTAMP '2016-01-01' AND date < TIMESTAMP '2016-02-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2015_12 (CONSTRAINT stat_cohort_2015_12_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2015_12_date_check CHECK (date >= TIMESTAMP '2015-12-01' AND date < TIMESTAMP '2016-01-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2015_11 (CONSTRAINT stat_cohort_2015_11_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2015_11_date_check CHECK (date >= TIMESTAMP '2015-11-01' AND date < TIMESTAMP '2015-12-01')) INHERITS (stat_cohort);
CREATE TABLE stat_cohort_2015_10 (CONSTRAINT stat_cohort_2015_10_pkey PRIMARY KEY (date,offer_id,aff_id,country,mediator), CONSTRAINT stat_cohort_2015_10_date_check CHECK (date >= TIMESTAMP '2015-10-01' AND date < TIMESTAMP '2015-11-01')) INHERITS (stat_cohort);

CREATE INDEX stat_cohort_2016_12_date_index ON stat_cohort_2016_12 USING btree (date);
CREATE INDEX stat_cohort_2016_11_date_index ON stat_cohort_2016_11 USING btree (date);
CREATE INDEX stat_cohort_2016_10_date_index ON stat_cohort_2016_10 USING btree (date);
CREATE INDEX stat_cohort_2016_09_date_index ON stat_cohort_2016_09 USING btree (date);
CREATE INDEX stat_cohort_2016_08_date_index ON stat_cohort_2016_08 USING btree (date);
CREATE INDEX stat_cohort_2016_07_date_index ON stat_cohort_2016_07 USING btree (date);
CREATE INDEX stat_cohort_2016_06_date_index ON stat_cohort_2016_06 USING btree (date);
CREATE INDEX stat_cohort_2016_05_date_index ON stat_cohort_2016_05 USING btree (date);
CREATE INDEX stat_cohort_2016_04_date_index ON stat_cohort_2016_04 USING btree (date);
CREATE INDEX stat_cohort_2016_03_date_index ON stat_cohort_2016_03 USING btree (date);
CREATE INDEX stat_cohort_2016_02_date_index ON stat_cohort_2016_02 USING btree (date);
CREATE INDEX stat_cohort_2016_01_date_index ON stat_cohort_2016_01 USING btree (date);
CREATE INDEX stat_cohort_2015_12_date_index ON stat_cohort_2015_12 USING btree (date);
CREATE INDEX stat_cohort_2015_11_date_index ON stat_cohort_2015_11 USING btree (date);
CREATE INDEX stat_cohort_2015_10_date_index ON stat_cohort_2015_10 USING btree (date);

CREATE INDEX stat_cohort_2016_12_offer_id_index ON stat_cohort_2016_12 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_11_offer_id_index ON stat_cohort_2016_11 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_10_offer_id_index ON stat_cohort_2016_10 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_09_offer_id_index ON stat_cohort_2016_09 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_08_offer_id_index ON stat_cohort_2016_08 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_07_offer_id_index ON stat_cohort_2016_07 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_06_offer_id_index ON stat_cohort_2016_06 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_05_offer_id_index ON stat_cohort_2016_05 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_04_offer_id_index ON stat_cohort_2016_04 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_03_offer_id_index ON stat_cohort_2016_03 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_02_offer_id_index ON stat_cohort_2016_02 USING btree (offer_id);
CREATE INDEX stat_cohort_2016_01_offer_id_index ON stat_cohort_2016_01 USING btree (offer_id);
CREATE INDEX stat_cohort_2015_12_offer_id_index ON stat_cohort_2015_12 USING btree (offer_id);
CREATE INDEX stat_cohort_2015_11_offer_id_index ON stat_cohort_2015_11 USING btree (offer_id);
CREATE INDEX stat_cohort_2015_10_offer_id_index ON stat_cohort_2015_10 USING btree (offer_id);

CREATE INDEX stat_cohort_2016_12_aff_id_index ON stat_cohort_2016_12 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_11_aff_id_index ON stat_cohort_2016_11 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_10_aff_id_index ON stat_cohort_2016_10 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_09_aff_id_index ON stat_cohort_2016_09 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_08_aff_id_index ON stat_cohort_2016_08 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_07_aff_id_index ON stat_cohort_2016_07 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_06_aff_id_index ON stat_cohort_2016_06 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_05_aff_id_index ON stat_cohort_2016_05 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_04_aff_id_index ON stat_cohort_2016_04 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_03_aff_id_index ON stat_cohort_2016_03 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_02_aff_id_index ON stat_cohort_2016_02 USING btree (aff_id);
CREATE INDEX stat_cohort_2016_01_aff_id_index ON stat_cohort_2016_01 USING btree (aff_id);
CREATE INDEX stat_cohort_2015_12_aff_id_index ON stat_cohort_2015_12 USING btree (aff_id);
CREATE INDEX stat_cohort_2015_11_aff_id_index ON stat_cohort_2015_11 USING btree (aff_id);
CREATE INDEX stat_cohort_2015_10_aff_id_index ON stat_cohort_2015_10 USING btree (aff_id);

CREATE INDEX stat_cohort_2016_12_country_index ON stat_cohort_2016_12 USING btree (country);
CREATE INDEX stat_cohort_2016_11_country_index ON stat_cohort_2016_11 USING btree (country);
CREATE INDEX stat_cohort_2016_10_country_index ON stat_cohort_2016_10 USING btree (country);
CREATE INDEX stat_cohort_2016_09_country_index ON stat_cohort_2016_09 USING btree (country);
CREATE INDEX stat_cohort_2016_08_country_index ON stat_cohort_2016_08 USING btree (country);
CREATE INDEX stat_cohort_2016_07_country_index ON stat_cohort_2016_07 USING btree (country);
CREATE INDEX stat_cohort_2016_06_country_index ON stat_cohort_2016_06 USING btree (country);
CREATE INDEX stat_cohort_2016_05_country_index ON stat_cohort_2016_05 USING btree (country);
CREATE INDEX stat_cohort_2016_04_country_index ON stat_cohort_2016_04 USING btree (country);
CREATE INDEX stat_cohort_2016_03_country_index ON stat_cohort_2016_03 USING btree (country);
CREATE INDEX stat_cohort_2016_02_country_index ON stat_cohort_2016_02 USING btree (country);
CREATE INDEX stat_cohort_2016_01_country_index ON stat_cohort_2016_01 USING btree (country);
CREATE INDEX stat_cohort_2015_12_country_index ON stat_cohort_2015_12 USING btree (country);
CREATE INDEX stat_cohort_2015_11_country_index ON stat_cohort_2015_11 USING btree (country);
CREATE INDEX stat_cohort_2015_10_country_index ON stat_cohort_2015_10 USING btree (country);

CREATE INDEX stat_cohort_2016_12_mediator_index ON stat_cohort_2016_12 USING btree (mediator);
CREATE INDEX stat_cohort_2016_11_mediator_index ON stat_cohort_2016_11 USING btree (mediator);
CREATE INDEX stat_cohort_2016_10_mediator_index ON stat_cohort_2016_10 USING btree (mediator);
CREATE INDEX stat_cohort_2016_09_mediator_index ON stat_cohort_2016_09 USING btree (mediator);
CREATE INDEX stat_cohort_2016_08_mediator_index ON stat_cohort_2016_08 USING btree (mediator);
CREATE INDEX stat_cohort_2016_07_mediator_index ON stat_cohort_2016_07 USING btree (mediator);
CREATE INDEX stat_cohort_2016_06_mediator_index ON stat_cohort_2016_06 USING btree (mediator);
CREATE INDEX stat_cohort_2016_05_mediator_index ON stat_cohort_2016_05 USING btree (mediator);
CREATE INDEX stat_cohort_2016_04_mediator_index ON stat_cohort_2016_04 USING btree (mediator);
CREATE INDEX stat_cohort_2016_03_mediator_index ON stat_cohort_2016_03 USING btree (mediator);
CREATE INDEX stat_cohort_2016_02_mediator_index ON stat_cohort_2016_02 USING btree (mediator);
CREATE INDEX stat_cohort_2016_01_mediator_index ON stat_cohort_2016_01 USING btree (mediator);
CREATE INDEX stat_cohort_2015_12_mediator_index ON stat_cohort_2015_12 USING btree (mediator);
CREATE INDEX stat_cohort_2015_11_mediator_index ON stat_cohort_2015_11 USING btree (mediator);
CREATE INDEX stat_cohort_2015_10_mediator_index ON stat_cohort_2015_10 USING btree (mediator);

CREATE OR REPLACE FUNCTION stat_cohort_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN

    -- Partitioning --
    IF (NEW.date >= TIMESTAMP '2016-11-01' AND NEW.date < TIMESTAMP '2016-12-01') THEN INSERT INTO stat_cohort_2016_11 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-10-01' AND NEW.date < TIMESTAMP '2016-11-01') THEN INSERT INTO stat_cohort_2016_10 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-09-01' AND NEW.date < TIMESTAMP '2016-10-01') THEN INSERT INTO stat_cohort_2016_09 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-08-01' AND NEW.date < TIMESTAMP '2016-09-01') THEN INSERT INTO stat_cohort_2016_08 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-07-01' AND NEW.date < TIMESTAMP '2016-08-01') THEN INSERT INTO stat_cohort_2016_07 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-06-01' AND NEW.date < TIMESTAMP '2016-07-01') THEN INSERT INTO stat_cohort_2016_06 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-05-01' AND NEW.date < TIMESTAMP '2016-06-01') THEN INSERT INTO stat_cohort_2016_05 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-04-01' AND NEW.date < TIMESTAMP '2016-05-01') THEN INSERT INTO stat_cohort_2016_04 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-03-01' AND NEW.date < TIMESTAMP '2016-04-01') THEN INSERT INTO stat_cohort_2016_03 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-02-01' AND NEW.date < TIMESTAMP '2016-03-01') THEN INSERT INTO stat_cohort_2016_02 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-01-01' AND NEW.date < TIMESTAMP '2016-02-01') THEN INSERT INTO stat_cohort_2016_01 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-12-01' AND NEW.date < TIMESTAMP '2016-01-01') THEN INSERT INTO stat_cohort_2015_12 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-11-01' AND NEW.date < TIMESTAMP '2015-12-01') THEN INSERT INTO stat_cohort_2015_11 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-10-01' AND NEW.date < TIMESTAMP '2015-11-01') THEN INSERT INTO stat_cohort_2015_10 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-12-01') THEN INSERT INTO stat_cohort_2016_12 VALUES (NEW.*);
    ELSE RAISE EXCEPTION 'Date % is out of range. Fix stat_cohort', NEW.date;
    END IF;

    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER stat_cohort_before_insert
   BEFORE INSERT ON stat_cohort
   FOR EACH ROW EXECUTE PROCEDURE stat_cohort_insert_trigger();