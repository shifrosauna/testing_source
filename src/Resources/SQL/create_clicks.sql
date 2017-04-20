CREATE TABLE clicks (
    id serial NOT NULL,
    offer_id integer NOT NULL,
    aff_id integer NOT NULL,
    transaction_id text,
    conversion_id integer,
    ip text,
    country text,
    city text,
    user_agent text,
    device_id integer,
    params text,
    aff_sub1 text,
    aff_sub2 text,
    aff_sub3 text,
    aff_sub4 text,
    aff_sub5 text,
    source text,
    refer text,
    objective integer DEFAULT 0,
    datetime timestamp without time zone NOT NULL DEFAULT now()
) WITH (
    OIDS=FALSE
);

ALTER TABLE ONLY clicks ADD CONSTRAINT clicks_id_pk PRIMARY KEY (id);
CREATE INDEX clicks_datetime_index ON clicks USING btree (datetime);
CREATE INDEX clicks_offer_id_index ON clicks USING btree (offer_id);
CREATE INDEX clicks_aff_id_index ON clicks USING btree (aff_id);
CREATE INDEX clicks_transaction_id_index ON clicks USING btree (transaction_id);
CREATE INDEX clicks_conversion_id_index ON clicks USING btree (conversion_id);

CREATE TABLE clicks_2016_12 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-12-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_11 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-11-01 00:00:00' AND datetime < TIMESTAMP '2016-12-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_10 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-10-01 00:00:00' AND datetime < TIMESTAMP '2016-11-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_09 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-09-01 00:00:00' AND datetime < TIMESTAMP '2016-10-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_08 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-08-01 00:00:00' AND datetime < TIMESTAMP '2016-09-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_07 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-07-01 00:00:00' AND datetime < TIMESTAMP '2016-08-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_06 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-06-01 00:00:00' AND datetime < TIMESTAMP '2016-07-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_05 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-05-01 00:00:00' AND datetime < TIMESTAMP '2016-06-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_04 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-04-01 00:00:00' AND datetime < TIMESTAMP '2016-05-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_03 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-03-01 00:00:00' AND datetime < TIMESTAMP '2016-04-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_02 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-02-01 00:00:00' AND datetime < TIMESTAMP '2016-03-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2016_01 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-01-01 00:00:00' AND datetime < TIMESTAMP '2016-02-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2015_12 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-12-01 00:00:00' AND datetime < TIMESTAMP '2016-01-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2015_11 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-11-01 00:00:00' AND datetime < TIMESTAMP '2015-12-01 00:00:00')) INHERITS (clicks);
CREATE TABLE clicks_2015_10 (id integer DEFAULT nextval('clicks_id_seq'::regclass) PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-10-01 00:00:00' AND datetime < TIMESTAMP '2015-11-01 00:00:00')) INHERITS (clicks);

CREATE INDEX clicks_2016_12_datetime_index ON clicks_2016_12 USING btree (datetime);
CREATE INDEX clicks_2016_11_datetime_index ON clicks_2016_11 USING btree (datetime);
CREATE INDEX clicks_2016_10_datetime_index ON clicks_2016_10 USING btree (datetime);
CREATE INDEX clicks_2016_09_datetime_index ON clicks_2016_09 USING btree (datetime);
CREATE INDEX clicks_2016_08_datetime_index ON clicks_2016_08 USING btree (datetime);
CREATE INDEX clicks_2016_07_datetime_index ON clicks_2016_07 USING btree (datetime);
CREATE INDEX clicks_2016_06_datetime_index ON clicks_2016_06 USING btree (datetime);
CREATE INDEX clicks_2016_05_datetime_index ON clicks_2016_05 USING btree (datetime);
CREATE INDEX clicks_2016_04_datetime_index ON clicks_2016_04 USING btree (datetime);
CREATE INDEX clicks_2016_03_datetime_index ON clicks_2016_03 USING btree (datetime);
CREATE INDEX clicks_2016_02_datetime_index ON clicks_2016_02 USING btree (datetime);
CREATE INDEX clicks_2016_01_datetime_index ON clicks_2016_01 USING btree (datetime);
CREATE INDEX clicks_2015_12_datetime_index ON clicks_2015_12 USING btree (datetime);
CREATE INDEX clicks_2015_11_datetime_index ON clicks_2015_11 USING btree (datetime);
CREATE INDEX clicks_2015_10_datetime_index ON clicks_2015_10 USING btree (datetime);

CREATE INDEX clicks_2016_12_aff_id_index ON clicks_2016_12 USING btree (aff_id);
CREATE INDEX clicks_2016_11_aff_id_index ON clicks_2016_11 USING btree (aff_id);
CREATE INDEX clicks_2016_10_aff_id_index ON clicks_2016_10 USING btree (aff_id);
CREATE INDEX clicks_2016_09_aff_id_index ON clicks_2016_09 USING btree (aff_id);
CREATE INDEX clicks_2016_08_aff_id_index ON clicks_2016_08 USING btree (aff_id);
CREATE INDEX clicks_2016_07_aff_id_index ON clicks_2016_07 USING btree (aff_id);
CREATE INDEX clicks_2016_06_aff_id_index ON clicks_2016_06 USING btree (aff_id);
CREATE INDEX clicks_2016_05_aff_id_index ON clicks_2016_05 USING btree (aff_id);
CREATE INDEX clicks_2016_04_aff_id_index ON clicks_2016_04 USING btree (aff_id);
CREATE INDEX clicks_2016_03_aff_id_index ON clicks_2016_03 USING btree (aff_id);
CREATE INDEX clicks_2016_02_aff_id_index ON clicks_2016_02 USING btree (aff_id);
CREATE INDEX clicks_2016_01_aff_id_index ON clicks_2016_01 USING btree (aff_id);
CREATE INDEX clicks_2015_12_aff_id_index ON clicks_2015_12 USING btree (aff_id);
CREATE INDEX clicks_2015_11_aff_id_index ON clicks_2015_11 USING btree (aff_id);
CREATE INDEX clicks_2015_10_aff_id_index ON clicks_2015_10 USING btree (aff_id);

CREATE INDEX clicks_2016_12_offer_id_index ON clicks_2016_12 USING btree (offer_id);
CREATE INDEX clicks_2016_11_offer_id_index ON clicks_2016_11 USING btree (offer_id);
CREATE INDEX clicks_2016_10_offer_id_index ON clicks_2016_10 USING btree (offer_id);
CREATE INDEX clicks_2016_09_offer_id_index ON clicks_2016_09 USING btree (offer_id);
CREATE INDEX clicks_2016_08_offer_id_index ON clicks_2016_08 USING btree (offer_id);
CREATE INDEX clicks_2016_07_offer_id_index ON clicks_2016_07 USING btree (offer_id);
CREATE INDEX clicks_2016_06_offer_id_index ON clicks_2016_06 USING btree (offer_id);
CREATE INDEX clicks_2016_05_offer_id_index ON clicks_2016_05 USING btree (offer_id);
CREATE INDEX clicks_2016_04_offer_id_index ON clicks_2016_04 USING btree (offer_id);
CREATE INDEX clicks_2016_03_offer_id_index ON clicks_2016_03 USING btree (offer_id);
CREATE INDEX clicks_2016_02_offer_id_index ON clicks_2016_02 USING btree (offer_id);
CREATE INDEX clicks_2016_01_offer_id_index ON clicks_2016_01 USING btree (offer_id);
CREATE INDEX clicks_2015_12_offer_id_index ON clicks_2015_12 USING btree (offer_id);
CREATE INDEX clicks_2015_11_offer_id_index ON clicks_2015_11 USING btree (offer_id);
CREATE INDEX clicks_2015_10_offer_id_index ON clicks_2015_10 USING btree (offer_id);

CREATE INDEX clicks_2016_12_transaction_id_index ON clicks_2016_12 USING btree (transaction_id);
CREATE INDEX clicks_2016_11_transaction_id_index ON clicks_2016_11 USING btree (transaction_id);
CREATE INDEX clicks_2016_10_transaction_id_index ON clicks_2016_10 USING btree (transaction_id);
CREATE INDEX clicks_2016_09_transaction_id_index ON clicks_2016_09 USING btree (transaction_id);
CREATE INDEX clicks_2016_08_transaction_id_index ON clicks_2016_08 USING btree (transaction_id);
CREATE INDEX clicks_2016_07_transaction_id_index ON clicks_2016_07 USING btree (transaction_id);
CREATE INDEX clicks_2016_06_transaction_id_index ON clicks_2016_06 USING btree (transaction_id);
CREATE INDEX clicks_2016_05_transaction_id_index ON clicks_2016_05 USING btree (transaction_id);
CREATE INDEX clicks_2016_04_transaction_id_index ON clicks_2016_04 USING btree (transaction_id);
CREATE INDEX clicks_2016_03_transaction_id_index ON clicks_2016_03 USING btree (transaction_id);
CREATE INDEX clicks_2016_02_transaction_id_index ON clicks_2016_02 USING btree (transaction_id);
CREATE INDEX clicks_2016_01_transaction_id_index ON clicks_2016_01 USING btree (transaction_id);
CREATE INDEX clicks_2015_12_transaction_id_index ON clicks_2015_12 USING btree (transaction_id);
CREATE INDEX clicks_2015_11_transaction_id_index ON clicks_2015_11 USING btree (transaction_id);
CREATE INDEX clicks_2015_10_transaction_id_index ON clicks_2015_10 USING btree (transaction_id);

CREATE INDEX clicks_2016_12_conversion_id_index ON clicks_2016_12 USING btree (conversion_id);
CREATE INDEX clicks_2016_11_conversion_id_index ON clicks_2016_11 USING btree (conversion_id);
CREATE INDEX clicks_2016_10_conversion_id_index ON clicks_2016_10 USING btree (conversion_id);
CREATE INDEX clicks_2016_09_conversion_id_index ON clicks_2016_09 USING btree (conversion_id);
CREATE INDEX clicks_2016_08_conversion_id_index ON clicks_2016_08 USING btree (conversion_id);
CREATE INDEX clicks_2016_07_conversion_id_index ON clicks_2016_07 USING btree (conversion_id);
CREATE INDEX clicks_2016_06_conversion_id_index ON clicks_2016_06 USING btree (conversion_id);
CREATE INDEX clicks_2016_05_conversion_id_index ON clicks_2016_05 USING btree (conversion_id);
CREATE INDEX clicks_2016_04_conversion_id_index ON clicks_2016_04 USING btree (conversion_id);
CREATE INDEX clicks_2016_03_conversion_id_index ON clicks_2016_03 USING btree (conversion_id);
CREATE INDEX clicks_2016_02_conversion_id_index ON clicks_2016_02 USING btree (conversion_id);
CREATE INDEX clicks_2016_01_conversion_id_index ON clicks_2016_01 USING btree (conversion_id);
CREATE INDEX clicks_2015_12_conversion_id_index ON clicks_2015_12 USING btree (conversion_id);
CREATE INDEX clicks_2015_11_conversion_id_index ON clicks_2015_11 USING btree (conversion_id);
CREATE INDEX clicks_2015_10_conversion_id_index ON clicks_2015_10 USING btree (conversion_id);

CREATE OR REPLACE FUNCTION clicks_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN

    -- Partitioning --
    IF    (NEW.datetime >= TIMESTAMP '2016-11-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-12-01 00:00:00') THEN INSERT INTO clicks_2016_11 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-10-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-11-01 00:00:00') THEN INSERT INTO clicks_2016_10 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-09-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-10-01 00:00:00') THEN INSERT INTO clicks_2016_09 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-08-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-09-01 00:00:00') THEN INSERT INTO clicks_2016_08 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-07-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-08-01 00:00:00') THEN INSERT INTO clicks_2016_07 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-06-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-07-01 00:00:00') THEN INSERT INTO clicks_2016_06 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-05-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-06-01 00:00:00') THEN INSERT INTO clicks_2016_05 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-04-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-05-01 00:00:00') THEN INSERT INTO clicks_2016_04 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-03-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-04-01 00:00:00') THEN INSERT INTO clicks_2016_03 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-02-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-03-01 00:00:00') THEN INSERT INTO clicks_2016_02 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-01-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-02-01 00:00:00') THEN INSERT INTO clicks_2016_01 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-12-01 00:00:00' AND NEW.datetime < TIMESTAMP '2016-01-01 00:00:00') THEN INSERT INTO clicks_2015_12 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-11-01 00:00:00' AND NEW.datetime < TIMESTAMP '2015-12-01 00:00:00') THEN INSERT INTO clicks_2015_11 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-10-01 00:00:00' AND NEW.datetime < TIMESTAMP '2015-11-01 00:00:00') THEN INSERT INTO clicks_2015_10 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-12-01 00:00:00') THEN INSERT INTO clicks_2016_12 VALUES (NEW.*);
    ELSE RAISE EXCEPTION 'Date % is out of range. Fix clicks', NEW.date;
    END IF;

    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER clicks_before_insert
   BEFORE INSERT ON clicks
   FOR EACH ROW EXECUTE PROCEDURE clicks_insert_trigger();