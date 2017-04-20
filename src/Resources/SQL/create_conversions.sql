CREATE TABLE conversions (
    id integer NOT NULL,
    offer_id integer NOT NULL,
    goal_id integer NOT NULL,
    aff_id integer NOT NULL,
    transaction_id text,
    payout double precision,
    revenue double precision,
    currency text,
    ip text,
    country text,
    city text,
    device_id integer,
    aff_sub1 text,
    aff_sub2 text,
    aff_sub3 text,
    aff_sub4 text,
    aff_sub5 text,
    source text,
    refer text,
    status text,
    datetime timestamp without time zone NOT NULL
) WITH (
    OIDS=FALSE
);

ALTER TABLE ONLY conversions ADD CONSTRAINT conversions_id_pkey PRIMARY KEY (id);

CREATE INDEX conversions_datetime_index ON conversions USING btree (datetime);
CREATE INDEX conversions_offer_id_index ON conversions USING btree (offer_id);
CREATE INDEX conversions_aff_id_index ON conversions USING btree (aff_id);

CREATE TABLE conversions_2016_12 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-12-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_11 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-11-01' AND datetime < TIMESTAMP '2016-12-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_10 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-10-01' AND datetime < TIMESTAMP '2016-11-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_09 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-09-01' AND datetime < TIMESTAMP '2016-10-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_08 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-08-01' AND datetime < TIMESTAMP '2016-09-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_07 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-07-01' AND datetime < TIMESTAMP '2016-08-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_06 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-06-01' AND datetime < TIMESTAMP '2016-07-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_05 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-05-01' AND datetime < TIMESTAMP '2016-06-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_04 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-04-01' AND datetime < TIMESTAMP '2016-05-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_03 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-03-01' AND datetime < TIMESTAMP '2016-04-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_02 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-02-01' AND datetime < TIMESTAMP '2016-03-01')) INHERITS (conversions);
CREATE TABLE conversions_2016_01 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2016-01-01' AND datetime < TIMESTAMP '2016-02-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_12 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-12-01' AND datetime < TIMESTAMP '2016-01-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_11 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-11-01' AND datetime < TIMESTAMP '2015-12-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_10 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-10-01' AND datetime < TIMESTAMP '2015-11-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_09 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-09-01' AND datetime < TIMESTAMP '2015-10-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_08 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-08-01' AND datetime < TIMESTAMP '2015-09-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_07 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-07-01' AND datetime < TIMESTAMP '2015-08-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_06 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-06-01' AND datetime < TIMESTAMP '2015-07-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_05 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-05-01' AND datetime < TIMESTAMP '2015-06-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_04 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-04-01' AND datetime < TIMESTAMP '2015-05-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_03 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-03-01' AND datetime < TIMESTAMP '2015-04-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_02 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-02-01' AND datetime < TIMESTAMP '2015-03-01')) INHERITS (conversions);
CREATE TABLE conversions_2015_01 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2015-01-01' AND datetime < TIMESTAMP '2015-02-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_12 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-12-01' AND datetime < TIMESTAMP '2015-01-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_11 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-11-01' AND datetime < TIMESTAMP '2014-12-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_10 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-10-01' AND datetime < TIMESTAMP '2014-11-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_09 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-09-01' AND datetime < TIMESTAMP '2014-10-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_08 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-08-01' AND datetime < TIMESTAMP '2014-09-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_07 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-07-01' AND datetime < TIMESTAMP '2014-08-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_06 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-06-01' AND datetime < TIMESTAMP '2014-07-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_05 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-05-01' AND datetime < TIMESTAMP '2014-06-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_04 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-04-01' AND datetime < TIMESTAMP '2014-05-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_03 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-03-01' AND datetime < TIMESTAMP '2014-04-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_02 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-02-01' AND datetime < TIMESTAMP '2014-03-01')) INHERITS (conversions);
CREATE TABLE conversions_2014_01 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2014-01-01' AND datetime < TIMESTAMP '2014-02-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_12 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-12-01' AND datetime < TIMESTAMP '2014-01-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_11 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-11-01' AND datetime < TIMESTAMP '2013-12-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_10 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-10-01' AND datetime < TIMESTAMP '2013-11-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_09 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-09-01' AND datetime < TIMESTAMP '2013-10-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_08 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-08-01' AND datetime < TIMESTAMP '2013-09-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_07 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-07-01' AND datetime < TIMESTAMP '2013-08-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_06 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-06-01' AND datetime < TIMESTAMP '2013-07-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_05 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-05-01' AND datetime < TIMESTAMP '2013-06-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_04 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-04-01' AND datetime < TIMESTAMP '2013-05-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_03 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-03-01' AND datetime < TIMESTAMP '2013-04-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_02 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-02-01' AND datetime < TIMESTAMP '2013-03-01')) INHERITS (conversions);
CREATE TABLE conversions_2013_01 (id integer NOT NULL PRIMARY KEY, CHECK (datetime >= TIMESTAMP '2013-01-01' AND datetime < TIMESTAMP '2013-02-01')) INHERITS (conversions);

CREATE INDEX conversions_2016_12_datetime_index ON conversions_2016_12 USING btree (datetime);
CREATE INDEX conversions_2016_11_datetime_index ON conversions_2016_11 USING btree (datetime);
CREATE INDEX conversions_2016_10_datetime_index ON conversions_2016_10 USING btree (datetime);
CREATE INDEX conversions_2016_09_datetime_index ON conversions_2016_09 USING btree (datetime);
CREATE INDEX conversions_2016_08_datetime_index ON conversions_2016_08 USING btree (datetime);
CREATE INDEX conversions_2016_07_datetime_index ON conversions_2016_07 USING btree (datetime);
CREATE INDEX conversions_2016_06_datetime_index ON conversions_2016_06 USING btree (datetime);
CREATE INDEX conversions_2016_05_datetime_index ON conversions_2016_05 USING btree (datetime);
CREATE INDEX conversions_2016_04_datetime_index ON conversions_2016_04 USING btree (datetime);
CREATE INDEX conversions_2016_03_datetime_index ON conversions_2016_03 USING btree (datetime);
CREATE INDEX conversions_2016_02_datetime_index ON conversions_2016_02 USING btree (datetime);
CREATE INDEX conversions_2016_01_datetime_index ON conversions_2016_01 USING btree (datetime);
CREATE INDEX conversions_2015_12_datetime_index ON conversions_2015_12 USING btree (datetime);
CREATE INDEX conversions_2015_11_datetime_index ON conversions_2015_11 USING btree (datetime);
CREATE INDEX conversions_2015_10_datetime_index ON conversions_2015_10 USING btree (datetime);
CREATE INDEX conversions_2015_09_datetime_index ON conversions_2015_09 USING btree (datetime);
CREATE INDEX conversions_2015_08_datetime_index ON conversions_2015_08 USING btree (datetime);
CREATE INDEX conversions_2015_07_datetime_index ON conversions_2015_07 USING btree (datetime);
CREATE INDEX conversions_2015_06_datetime_index ON conversions_2015_06 USING btree (datetime);
CREATE INDEX conversions_2015_05_datetime_index ON conversions_2015_05 USING btree (datetime);
CREATE INDEX conversions_2015_04_datetime_index ON conversions_2015_04 USING btree (datetime);
CREATE INDEX conversions_2015_03_datetime_index ON conversions_2015_03 USING btree (datetime);
CREATE INDEX conversions_2015_02_datetime_index ON conversions_2015_02 USING btree (datetime);
CREATE INDEX conversions_2015_01_datetime_index ON conversions_2015_01 USING btree (datetime);
CREATE INDEX conversions_2014_12_datetime_index ON conversions_2014_12 USING btree (datetime);
CREATE INDEX conversions_2014_11_datetime_index ON conversions_2014_11 USING btree (datetime);
CREATE INDEX conversions_2014_10_datetime_index ON conversions_2014_10 USING btree (datetime);
CREATE INDEX conversions_2014_09_datetime_index ON conversions_2014_09 USING btree (datetime);
CREATE INDEX conversions_2014_08_datetime_index ON conversions_2014_08 USING btree (datetime);
CREATE INDEX conversions_2014_07_datetime_index ON conversions_2014_07 USING btree (datetime);
CREATE INDEX conversions_2014_06_datetime_index ON conversions_2014_06 USING btree (datetime);
CREATE INDEX conversions_2014_05_datetime_index ON conversions_2014_05 USING btree (datetime);
CREATE INDEX conversions_2014_04_datetime_index ON conversions_2014_04 USING btree (datetime);
CREATE INDEX conversions_2014_03_datetime_index ON conversions_2014_03 USING btree (datetime);
CREATE INDEX conversions_2014_02_datetime_index ON conversions_2014_02 USING btree (datetime);
CREATE INDEX conversions_2014_01_datetime_index ON conversions_2014_01 USING btree (datetime);
CREATE INDEX conversions_2013_12_datetime_index ON conversions_2013_12 USING btree (datetime);
CREATE INDEX conversions_2013_11_datetime_index ON conversions_2013_11 USING btree (datetime);
CREATE INDEX conversions_2013_10_datetime_index ON conversions_2013_10 USING btree (datetime);
CREATE INDEX conversions_2013_09_datetime_index ON conversions_2013_09 USING btree (datetime);
CREATE INDEX conversions_2013_08_datetime_index ON conversions_2013_08 USING btree (datetime);
CREATE INDEX conversions_2013_07_datetime_index ON conversions_2013_07 USING btree (datetime);
CREATE INDEX conversions_2013_06_datetime_index ON conversions_2013_06 USING btree (datetime);
CREATE INDEX conversions_2013_05_datetime_index ON conversions_2013_05 USING btree (datetime);
CREATE INDEX conversions_2013_04_datetime_index ON conversions_2013_04 USING btree (datetime);
CREATE INDEX conversions_2013_03_datetime_index ON conversions_2013_03 USING btree (datetime);
CREATE INDEX conversions_2013_02_datetime_index ON conversions_2013_02 USING btree (datetime);
CREATE INDEX conversions_2013_01_datetime_index ON conversions_2013_01 USING btree (datetime);

CREATE INDEX conversions_2016_12_offer_id_index ON conversions_2016_12 USING btree (offer_id);
CREATE INDEX conversions_2016_11_offer_id_index ON conversions_2016_11 USING btree (offer_id);
CREATE INDEX conversions_2016_10_offer_id_index ON conversions_2016_10 USING btree (offer_id);
CREATE INDEX conversions_2016_09_offer_id_index ON conversions_2016_09 USING btree (offer_id);
CREATE INDEX conversions_2016_08_offer_id_index ON conversions_2016_08 USING btree (offer_id);
CREATE INDEX conversions_2016_07_offer_id_index ON conversions_2016_07 USING btree (offer_id);
CREATE INDEX conversions_2016_06_offer_id_index ON conversions_2016_06 USING btree (offer_id);
CREATE INDEX conversions_2016_05_offer_id_index ON conversions_2016_05 USING btree (offer_id);
CREATE INDEX conversions_2016_04_offer_id_index ON conversions_2016_04 USING btree (offer_id);
CREATE INDEX conversions_2016_03_offer_id_index ON conversions_2016_03 USING btree (offer_id);
CREATE INDEX conversions_2016_02_offer_id_index ON conversions_2016_02 USING btree (offer_id);
CREATE INDEX conversions_2016_01_offer_id_index ON conversions_2016_01 USING btree (offer_id);
CREATE INDEX conversions_2015_12_offer_id_index ON conversions_2015_12 USING btree (offer_id);
CREATE INDEX conversions_2015_11_offer_id_index ON conversions_2015_11 USING btree (offer_id);
CREATE INDEX conversions_2015_10_offer_id_index ON conversions_2015_10 USING btree (offer_id);
CREATE INDEX conversions_2015_09_offer_id_index ON conversions_2015_09 USING btree (offer_id);
CREATE INDEX conversions_2015_08_offer_id_index ON conversions_2015_08 USING btree (offer_id);
CREATE INDEX conversions_2015_07_offer_id_index ON conversions_2015_07 USING btree (offer_id);
CREATE INDEX conversions_2015_06_offer_id_index ON conversions_2015_06 USING btree (offer_id);
CREATE INDEX conversions_2015_05_offer_id_index ON conversions_2015_05 USING btree (offer_id);
CREATE INDEX conversions_2015_04_offer_id_index ON conversions_2015_04 USING btree (offer_id);
CREATE INDEX conversions_2015_03_offer_id_index ON conversions_2015_03 USING btree (offer_id);
CREATE INDEX conversions_2015_02_offer_id_index ON conversions_2015_02 USING btree (offer_id);
CREATE INDEX conversions_2015_01_offer_id_index ON conversions_2015_01 USING btree (offer_id);
CREATE INDEX conversions_2014_12_offer_id_index ON conversions_2014_12 USING btree (offer_id);
CREATE INDEX conversions_2014_11_offer_id_index ON conversions_2014_11 USING btree (offer_id);
CREATE INDEX conversions_2014_10_offer_id_index ON conversions_2014_10 USING btree (offer_id);
CREATE INDEX conversions_2014_09_offer_id_index ON conversions_2014_09 USING btree (offer_id);
CREATE INDEX conversions_2014_08_offer_id_index ON conversions_2014_08 USING btree (offer_id);
CREATE INDEX conversions_2014_07_offer_id_index ON conversions_2014_07 USING btree (offer_id);
CREATE INDEX conversions_2014_06_offer_id_index ON conversions_2014_06 USING btree (offer_id);
CREATE INDEX conversions_2014_05_offer_id_index ON conversions_2014_05 USING btree (offer_id);
CREATE INDEX conversions_2014_04_offer_id_index ON conversions_2014_04 USING btree (offer_id);
CREATE INDEX conversions_2014_03_offer_id_index ON conversions_2014_03 USING btree (offer_id);
CREATE INDEX conversions_2014_02_offer_id_index ON conversions_2014_02 USING btree (offer_id);
CREATE INDEX conversions_2014_01_offer_id_index ON conversions_2014_01 USING btree (offer_id);
CREATE INDEX conversions_2013_12_offer_id_index ON conversions_2013_12 USING btree (offer_id);
CREATE INDEX conversions_2013_11_offer_id_index ON conversions_2013_11 USING btree (offer_id);
CREATE INDEX conversions_2013_10_offer_id_index ON conversions_2013_10 USING btree (offer_id);
CREATE INDEX conversions_2013_09_offer_id_index ON conversions_2013_09 USING btree (offer_id);
CREATE INDEX conversions_2013_08_offer_id_index ON conversions_2013_08 USING btree (offer_id);
CREATE INDEX conversions_2013_07_offer_id_index ON conversions_2013_07 USING btree (offer_id);
CREATE INDEX conversions_2013_06_offer_id_index ON conversions_2013_06 USING btree (offer_id);
CREATE INDEX conversions_2013_05_offer_id_index ON conversions_2013_05 USING btree (offer_id);
CREATE INDEX conversions_2013_04_offer_id_index ON conversions_2013_04 USING btree (offer_id);
CREATE INDEX conversions_2013_03_offer_id_index ON conversions_2013_03 USING btree (offer_id);
CREATE INDEX conversions_2013_02_offer_id_index ON conversions_2013_02 USING btree (offer_id);
CREATE INDEX conversions_2013_01_offer_id_index ON conversions_2013_01 USING btree (offer_id);

CREATE INDEX conversions_2016_12_aff_id_index ON conversions_2016_12 USING btree (aff_id);
CREATE INDEX conversions_2016_11_aff_id_index ON conversions_2016_11 USING btree (aff_id);
CREATE INDEX conversions_2016_10_aff_id_index ON conversions_2016_10 USING btree (aff_id);
CREATE INDEX conversions_2016_09_aff_id_index ON conversions_2016_09 USING btree (aff_id);
CREATE INDEX conversions_2016_08_aff_id_index ON conversions_2016_08 USING btree (aff_id);
CREATE INDEX conversions_2016_07_aff_id_index ON conversions_2016_07 USING btree (aff_id);
CREATE INDEX conversions_2016_06_aff_id_index ON conversions_2016_06 USING btree (aff_id);
CREATE INDEX conversions_2016_05_aff_id_index ON conversions_2016_05 USING btree (aff_id);
CREATE INDEX conversions_2016_04_aff_id_index ON conversions_2016_04 USING btree (aff_id);
CREATE INDEX conversions_2016_03_aff_id_index ON conversions_2016_03 USING btree (aff_id);
CREATE INDEX conversions_2016_02_aff_id_index ON conversions_2016_02 USING btree (aff_id);
CREATE INDEX conversions_2016_01_aff_id_index ON conversions_2016_01 USING btree (aff_id);
CREATE INDEX conversions_2015_12_aff_id_index ON conversions_2015_12 USING btree (aff_id);
CREATE INDEX conversions_2015_11_aff_id_index ON conversions_2015_11 USING btree (aff_id);
CREATE INDEX conversions_2015_10_aff_id_index ON conversions_2015_10 USING btree (aff_id);
CREATE INDEX conversions_2015_09_aff_id_index ON conversions_2015_09 USING btree (aff_id);
CREATE INDEX conversions_2015_08_aff_id_index ON conversions_2015_08 USING btree (aff_id);
CREATE INDEX conversions_2015_07_aff_id_index ON conversions_2015_07 USING btree (aff_id);
CREATE INDEX conversions_2015_06_aff_id_index ON conversions_2015_06 USING btree (aff_id);
CREATE INDEX conversions_2015_05_aff_id_index ON conversions_2015_05 USING btree (aff_id);
CREATE INDEX conversions_2015_04_aff_id_index ON conversions_2015_04 USING btree (aff_id);
CREATE INDEX conversions_2015_03_aff_id_index ON conversions_2015_03 USING btree (aff_id);
CREATE INDEX conversions_2015_02_aff_id_index ON conversions_2015_02 USING btree (aff_id);
CREATE INDEX conversions_2015_01_aff_id_index ON conversions_2015_01 USING btree (aff_id);
CREATE INDEX conversions_2014_12_aff_id_index ON conversions_2014_12 USING btree (aff_id);
CREATE INDEX conversions_2014_11_aff_id_index ON conversions_2014_11 USING btree (aff_id);
CREATE INDEX conversions_2014_10_aff_id_index ON conversions_2014_10 USING btree (aff_id);
CREATE INDEX conversions_2014_09_aff_id_index ON conversions_2014_09 USING btree (aff_id);
CREATE INDEX conversions_2014_08_aff_id_index ON conversions_2014_08 USING btree (aff_id);
CREATE INDEX conversions_2014_07_aff_id_index ON conversions_2014_07 USING btree (aff_id);
CREATE INDEX conversions_2014_06_aff_id_index ON conversions_2014_06 USING btree (aff_id);
CREATE INDEX conversions_2014_05_aff_id_index ON conversions_2014_05 USING btree (aff_id);
CREATE INDEX conversions_2014_04_aff_id_index ON conversions_2014_04 USING btree (aff_id);
CREATE INDEX conversions_2014_03_aff_id_index ON conversions_2014_03 USING btree (aff_id);
CREATE INDEX conversions_2014_02_aff_id_index ON conversions_2014_02 USING btree (aff_id);
CREATE INDEX conversions_2014_01_aff_id_index ON conversions_2014_01 USING btree (aff_id);
CREATE INDEX conversions_2013_12_aff_id_index ON conversions_2013_12 USING btree (aff_id);
CREATE INDEX conversions_2013_11_aff_id_index ON conversions_2013_11 USING btree (aff_id);
CREATE INDEX conversions_2013_10_aff_id_index ON conversions_2013_10 USING btree (aff_id);
CREATE INDEX conversions_2013_09_aff_id_index ON conversions_2013_09 USING btree (aff_id);
CREATE INDEX conversions_2013_08_aff_id_index ON conversions_2013_08 USING btree (aff_id);
CREATE INDEX conversions_2013_07_aff_id_index ON conversions_2013_07 USING btree (aff_id);
CREATE INDEX conversions_2013_06_aff_id_index ON conversions_2013_06 USING btree (aff_id);
CREATE INDEX conversions_2013_05_aff_id_index ON conversions_2013_05 USING btree (aff_id);
CREATE INDEX conversions_2013_04_aff_id_index ON conversions_2013_04 USING btree (aff_id);
CREATE INDEX conversions_2013_03_aff_id_index ON conversions_2013_03 USING btree (aff_id);
CREATE INDEX conversions_2013_02_aff_id_index ON conversions_2013_02 USING btree (aff_id);
CREATE INDEX conversions_2013_01_aff_id_index ON conversions_2013_01 USING btree (aff_id);

CREATE OR REPLACE FUNCTION conversions_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN

    -- Partitioning --
    IF    (NEW.datetime >= TIMESTAMP '2016-11-01' AND NEW.datetime < TIMESTAMP '2016-12-01') THEN INSERT INTO conversions_2016_11 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-10-01' AND NEW.datetime < TIMESTAMP '2016-11-01') THEN INSERT INTO conversions_2016_10 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-09-01' AND NEW.datetime < TIMESTAMP '2016-10-01') THEN INSERT INTO conversions_2016_09 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-08-01' AND NEW.datetime < TIMESTAMP '2016-09-01') THEN INSERT INTO conversions_2016_08 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-07-01' AND NEW.datetime < TIMESTAMP '2016-08-01') THEN INSERT INTO conversions_2016_07 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-06-01' AND NEW.datetime < TIMESTAMP '2016-07-01') THEN INSERT INTO conversions_2016_06 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-05-01' AND NEW.datetime < TIMESTAMP '2016-06-01') THEN INSERT INTO conversions_2016_05 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-04-01' AND NEW.datetime < TIMESTAMP '2016-05-01') THEN INSERT INTO conversions_2016_04 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-03-01' AND NEW.datetime < TIMESTAMP '2016-04-01') THEN INSERT INTO conversions_2016_03 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-02-01' AND NEW.datetime < TIMESTAMP '2016-03-01') THEN INSERT INTO conversions_2016_02 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-01-01' AND NEW.datetime < TIMESTAMP '2016-02-01') THEN INSERT INTO conversions_2016_01 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-12-01' AND NEW.datetime < TIMESTAMP '2016-01-01') THEN INSERT INTO conversions_2015_12 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-11-01' AND NEW.datetime < TIMESTAMP '2015-12-01') THEN INSERT INTO conversions_2015_11 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-10-01' AND NEW.datetime < TIMESTAMP '2015-11-01') THEN INSERT INTO conversions_2015_10 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-09-01' AND NEW.datetime < TIMESTAMP '2015-10-01') THEN INSERT INTO conversions_2015_09 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-08-01' AND NEW.datetime < TIMESTAMP '2015-09-01') THEN INSERT INTO conversions_2015_08 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-07-01' AND NEW.datetime < TIMESTAMP '2015-08-01') THEN INSERT INTO conversions_2015_07 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-06-01' AND NEW.datetime < TIMESTAMP '2015-07-01') THEN INSERT INTO conversions_2015_06 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-05-01' AND NEW.datetime < TIMESTAMP '2015-06-01') THEN INSERT INTO conversions_2015_05 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-04-01' AND NEW.datetime < TIMESTAMP '2015-05-01') THEN INSERT INTO conversions_2015_04 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-03-01' AND NEW.datetime < TIMESTAMP '2015-04-01') THEN INSERT INTO conversions_2015_03 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-02-01' AND NEW.datetime < TIMESTAMP '2015-03-01') THEN INSERT INTO conversions_2015_02 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2015-01-01' AND NEW.datetime < TIMESTAMP '2015-02-01') THEN INSERT INTO conversions_2015_01 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-12-01' AND NEW.datetime < TIMESTAMP '2015-01-01') THEN INSERT INTO conversions_2014_12 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-11-01' AND NEW.datetime < TIMESTAMP '2014-12-01') THEN INSERT INTO conversions_2014_11 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-10-01' AND NEW.datetime < TIMESTAMP '2014-11-01') THEN INSERT INTO conversions_2014_10 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-09-01' AND NEW.datetime < TIMESTAMP '2014-10-01') THEN INSERT INTO conversions_2014_09 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-08-01' AND NEW.datetime < TIMESTAMP '2014-09-01') THEN INSERT INTO conversions_2014_08 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-07-01' AND NEW.datetime < TIMESTAMP '2014-08-01') THEN INSERT INTO conversions_2014_07 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-06-01' AND NEW.datetime < TIMESTAMP '2014-07-01') THEN INSERT INTO conversions_2014_06 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-05-01' AND NEW.datetime < TIMESTAMP '2014-06-01') THEN INSERT INTO conversions_2014_05 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-04-01' AND NEW.datetime < TIMESTAMP '2014-05-01') THEN INSERT INTO conversions_2014_04 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-03-01' AND NEW.datetime < TIMESTAMP '2014-04-01') THEN INSERT INTO conversions_2014_03 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-02-01' AND NEW.datetime < TIMESTAMP '2014-03-01') THEN INSERT INTO conversions_2014_02 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2014-01-01' AND NEW.datetime < TIMESTAMP '2014-02-01') THEN INSERT INTO conversions_2014_01 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-12-01' AND NEW.datetime < TIMESTAMP '2014-01-01') THEN INSERT INTO conversions_2013_12 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-11-01' AND NEW.datetime < TIMESTAMP '2013-12-01') THEN INSERT INTO conversions_2013_11 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-10-01' AND NEW.datetime < TIMESTAMP '2013-11-01') THEN INSERT INTO conversions_2013_10 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-09-01' AND NEW.datetime < TIMESTAMP '2013-10-01') THEN INSERT INTO conversions_2013_09 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-08-01' AND NEW.datetime < TIMESTAMP '2013-09-01') THEN INSERT INTO conversions_2013_08 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-07-01' AND NEW.datetime < TIMESTAMP '2013-08-01') THEN INSERT INTO conversions_2013_07 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-06-01' AND NEW.datetime < TIMESTAMP '2013-07-01') THEN INSERT INTO conversions_2013_06 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-05-01' AND NEW.datetime < TIMESTAMP '2013-06-01') THEN INSERT INTO conversions_2013_05 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-04-01' AND NEW.datetime < TIMESTAMP '2013-05-01') THEN INSERT INTO conversions_2013_04 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-03-01' AND NEW.datetime < TIMESTAMP '2013-04-01') THEN INSERT INTO conversions_2013_03 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-02-01' AND NEW.datetime < TIMESTAMP '2013-03-01') THEN INSERT INTO conversions_2013_02 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2013-01-01' AND NEW.datetime < TIMESTAMP '2013-02-01') THEN INSERT INTO conversions_2013_01 VALUES (NEW.*);
    ELSIF (NEW.datetime >= TIMESTAMP '2016-12-01') THEN INSERT INTO conversions_2016_12 VALUES (NEW.*);
    ELSE RAISE EXCEPTION 'datetime % is out of range. Fix conversions', NEW.datetime;
    END IF;

    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER conversions_before_insert
   BEFORE INSERT ON conversions
   FOR EACH ROW EXECUTE PROCEDURE conversions_insert_trigger();