CREATE TABLE stat_hour (
    date date NOT NULL,
    hour smallint NOT NULL,
    offer_id int NOT NULL,
    aff_id int NOT NULL,
    country text,
    impressions int,
    clicks int,
    installs int,
    conversions int,
    payout double precision,
    revenue double precision,
    currency text
);

ALTER TABLE ONLY stat_hour ADD CONSTRAINT stat_hour_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency);
CREATE INDEX stat_hour_date_index ON stat_hour USING btree (date);
CREATE INDEX stat_hour_offer_id_index ON stat_hour USING btree (offer_id);
CREATE INDEX stat_hour_aff_id_index ON stat_hour USING btree (aff_id);
CREATE INDEX stat_hour_country_index ON stat_hour USING btree (country);

CREATE TABLE stat_hour_2016_12 (CONSTRAINT stat_hour_2016_12_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_12_date_check CHECK (date >= TIMESTAMP '2016-12-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_11 (CONSTRAINT stat_hour_2016_11_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_11_date_check CHECK (date >= TIMESTAMP '2016-11-01' AND date < TIMESTAMP '2016-12-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_10 (CONSTRAINT stat_hour_2016_10_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_10_date_check CHECK (date >= TIMESTAMP '2016-10-01' AND date < TIMESTAMP '2016-11-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_09 (CONSTRAINT stat_hour_2016_09_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_09_date_check CHECK (date >= TIMESTAMP '2016-09-01' AND date < TIMESTAMP '2016-10-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_08 (CONSTRAINT stat_hour_2016_08_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_08_date_check CHECK (date >= TIMESTAMP '2016-08-01' AND date < TIMESTAMP '2016-09-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_07 (CONSTRAINT stat_hour_2016_07_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_07_date_check CHECK (date >= TIMESTAMP '2016-07-01' AND date < TIMESTAMP '2016-08-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_06 (CONSTRAINT stat_hour_2016_06_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_06_date_check CHECK (date >= TIMESTAMP '2016-06-01' AND date < TIMESTAMP '2016-07-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_05 (CONSTRAINT stat_hour_2016_05_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_05_date_check CHECK (date >= TIMESTAMP '2016-05-01' AND date < TIMESTAMP '2016-06-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_04 (CONSTRAINT stat_hour_2016_04_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_04_date_check CHECK (date >= TIMESTAMP '2016-04-01' AND date < TIMESTAMP '2016-05-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_03 (CONSTRAINT stat_hour_2016_03_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_03_date_check CHECK (date >= TIMESTAMP '2016-03-01' AND date < TIMESTAMP '2016-04-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_02 (CONSTRAINT stat_hour_2016_02_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_02_date_check CHECK (date >= TIMESTAMP '2016-02-01' AND date < TIMESTAMP '2016-03-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2016_01 (CONSTRAINT stat_hour_2016_01_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2016_01_date_check CHECK (date >= TIMESTAMP '2016-01-01' AND date < TIMESTAMP '2016-02-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_12 (CONSTRAINT stat_hour_2015_12_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_12_date_check CHECK (date >= TIMESTAMP '2015-12-01' AND date < TIMESTAMP '2016-01-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_11 (CONSTRAINT stat_hour_2015_11_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_11_date_check CHECK (date >= TIMESTAMP '2015-11-01' AND date < TIMESTAMP '2015-12-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_10 (CONSTRAINT stat_hour_2015_10_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_10_date_check CHECK (date >= TIMESTAMP '2015-10-01' AND date < TIMESTAMP '2015-11-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_09 (CONSTRAINT stat_hour_2015_09_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_09_date_check CHECK (date >= TIMESTAMP '2015-09-01' AND date < TIMESTAMP '2015-10-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_08 (CONSTRAINT stat_hour_2015_08_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_08_date_check CHECK (date >= TIMESTAMP '2015-08-01' AND date < TIMESTAMP '2015-09-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_07 (CONSTRAINT stat_hour_2015_07_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_07_date_check CHECK (date >= TIMESTAMP '2015-07-01' AND date < TIMESTAMP '2015-08-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_06 (CONSTRAINT stat_hour_2015_06_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_06_date_check CHECK (date >= TIMESTAMP '2015-06-01' AND date < TIMESTAMP '2015-07-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_05 (CONSTRAINT stat_hour_2015_05_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_05_date_check CHECK (date >= TIMESTAMP '2015-05-01' AND date < TIMESTAMP '2015-06-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_04 (CONSTRAINT stat_hour_2015_04_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_04_date_check CHECK (date >= TIMESTAMP '2015-04-01' AND date < TIMESTAMP '2015-05-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_03 (CONSTRAINT stat_hour_2015_03_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_03_date_check CHECK (date >= TIMESTAMP '2015-03-01' AND date < TIMESTAMP '2015-04-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_02 (CONSTRAINT stat_hour_2015_02_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_02_date_check CHECK (date >= TIMESTAMP '2015-02-01' AND date < TIMESTAMP '2015-03-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2015_01 (CONSTRAINT stat_hour_2015_01_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2015_01_date_check CHECK (date >= TIMESTAMP '2015-01-01' AND date < TIMESTAMP '2015-02-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_12 (CONSTRAINT stat_hour_2014_12_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_12_date_check CHECK (date >= TIMESTAMP '2014-12-01' AND date < TIMESTAMP '2015-01-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_11 (CONSTRAINT stat_hour_2014_11_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_11_date_check CHECK (date >= TIMESTAMP '2014-11-01' AND date < TIMESTAMP '2014-12-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_10 (CONSTRAINT stat_hour_2014_10_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_10_date_check CHECK (date >= TIMESTAMP '2014-10-01' AND date < TIMESTAMP '2014-11-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_09 (CONSTRAINT stat_hour_2014_09_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_09_date_check CHECK (date >= TIMESTAMP '2014-09-01' AND date < TIMESTAMP '2014-10-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_08 (CONSTRAINT stat_hour_2014_08_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_08_date_check CHECK (date >= TIMESTAMP '2014-08-01' AND date < TIMESTAMP '2014-09-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_07 (CONSTRAINT stat_hour_2014_07_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_07_date_check CHECK (date >= TIMESTAMP '2014-07-01' AND date < TIMESTAMP '2014-08-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_06 (CONSTRAINT stat_hour_2014_06_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_06_date_check CHECK (date >= TIMESTAMP '2014-06-01' AND date < TIMESTAMP '2014-07-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_05 (CONSTRAINT stat_hour_2014_05_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_05_date_check CHECK (date >= TIMESTAMP '2014-05-01' AND date < TIMESTAMP '2014-06-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_04 (CONSTRAINT stat_hour_2014_04_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_04_date_check CHECK (date >= TIMESTAMP '2014-04-01' AND date < TIMESTAMP '2014-05-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_03 (CONSTRAINT stat_hour_2014_03_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_03_date_check CHECK (date >= TIMESTAMP '2014-03-01' AND date < TIMESTAMP '2014-04-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_02 (CONSTRAINT stat_hour_2014_02_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_02_date_check CHECK (date >= TIMESTAMP '2014-02-01' AND date < TIMESTAMP '2014-03-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2014_01 (CONSTRAINT stat_hour_2014_01_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2014_01_date_check CHECK (date >= TIMESTAMP '2014-01-01' AND date < TIMESTAMP '2014-02-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_12 (CONSTRAINT stat_hour_2013_12_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_12_date_check CHECK (date >= TIMESTAMP '2013-12-01' AND date < TIMESTAMP '2014-01-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_11 (CONSTRAINT stat_hour_2013_11_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_11_date_check CHECK (date >= TIMESTAMP '2013-11-01' AND date < TIMESTAMP '2013-12-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_10 (CONSTRAINT stat_hour_2013_10_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_10_date_check CHECK (date >= TIMESTAMP '2013-10-01' AND date < TIMESTAMP '2013-11-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_09 (CONSTRAINT stat_hour_2013_09_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_09_date_check CHECK (date >= TIMESTAMP '2013-09-01' AND date < TIMESTAMP '2013-10-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_08 (CONSTRAINT stat_hour_2013_08_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_08_date_check CHECK (date >= TIMESTAMP '2013-08-01' AND date < TIMESTAMP '2013-09-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_07 (CONSTRAINT stat_hour_2013_07_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_07_date_check CHECK (date >= TIMESTAMP '2013-07-01' AND date < TIMESTAMP '2013-08-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_06 (CONSTRAINT stat_hour_2013_06_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_06_date_check CHECK (date >= TIMESTAMP '2013-06-01' AND date < TIMESTAMP '2013-07-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_05 (CONSTRAINT stat_hour_2013_05_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_05_date_check CHECK (date >= TIMESTAMP '2013-05-01' AND date < TIMESTAMP '2013-06-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_04 (CONSTRAINT stat_hour_2013_04_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_04_date_check CHECK (date >= TIMESTAMP '2013-04-01' AND date < TIMESTAMP '2013-05-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_03 (CONSTRAINT stat_hour_2013_03_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_03_date_check CHECK (date >= TIMESTAMP '2013-03-01' AND date < TIMESTAMP '2013-04-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_02 (CONSTRAINT stat_hour_2013_02_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_02_date_check CHECK (date >= TIMESTAMP '2013-02-01' AND date < TIMESTAMP '2013-03-01')) INHERITS (stat_hour);
CREATE TABLE stat_hour_2013_01 (CONSTRAINT stat_hour_2013_01_pkey PRIMARY KEY (date,hour,offer_id,aff_id,country,currency), CONSTRAINT stat_hour_2013_01_date_check CHECK (date >= TIMESTAMP '2013-01-01' AND date < TIMESTAMP '2013-02-01')) INHERITS (stat_hour);

CREATE INDEX stat_hour_2016_12_date_index ON stat_hour_2016_12 USING btree (date);
CREATE INDEX stat_hour_2016_11_date_index ON stat_hour_2016_11 USING btree (date);
CREATE INDEX stat_hour_2016_10_date_index ON stat_hour_2016_10 USING btree (date);
CREATE INDEX stat_hour_2016_09_date_index ON stat_hour_2016_09 USING btree (date);
CREATE INDEX stat_hour_2016_08_date_index ON stat_hour_2016_08 USING btree (date);
CREATE INDEX stat_hour_2016_07_date_index ON stat_hour_2016_07 USING btree (date);
CREATE INDEX stat_hour_2016_06_date_index ON stat_hour_2016_06 USING btree (date);
CREATE INDEX stat_hour_2016_05_date_index ON stat_hour_2016_05 USING btree (date);
CREATE INDEX stat_hour_2016_04_date_index ON stat_hour_2016_04 USING btree (date);
CREATE INDEX stat_hour_2016_03_date_index ON stat_hour_2016_03 USING btree (date);
CREATE INDEX stat_hour_2016_02_date_index ON stat_hour_2016_02 USING btree (date);
CREATE INDEX stat_hour_2016_01_date_index ON stat_hour_2016_01 USING btree (date);
CREATE INDEX stat_hour_2015_12_date_index ON stat_hour_2015_12 USING btree (date);
CREATE INDEX stat_hour_2015_11_date_index ON stat_hour_2015_11 USING btree (date);
CREATE INDEX stat_hour_2015_10_date_index ON stat_hour_2015_10 USING btree (date);
CREATE INDEX stat_hour_2015_09_date_index ON stat_hour_2015_09 USING btree (date);
CREATE INDEX stat_hour_2015_08_date_index ON stat_hour_2015_08 USING btree (date);
CREATE INDEX stat_hour_2015_07_date_index ON stat_hour_2015_07 USING btree (date);
CREATE INDEX stat_hour_2015_06_date_index ON stat_hour_2015_06 USING btree (date);
CREATE INDEX stat_hour_2015_05_date_index ON stat_hour_2015_05 USING btree (date);
CREATE INDEX stat_hour_2015_04_date_index ON stat_hour_2015_04 USING btree (date);
CREATE INDEX stat_hour_2015_03_date_index ON stat_hour_2015_03 USING btree (date);
CREATE INDEX stat_hour_2015_02_date_index ON stat_hour_2015_02 USING btree (date);
CREATE INDEX stat_hour_2015_01_date_index ON stat_hour_2015_01 USING btree (date);
CREATE INDEX stat_hour_2014_12_date_index ON stat_hour_2014_12 USING btree (date);
CREATE INDEX stat_hour_2014_11_date_index ON stat_hour_2014_11 USING btree (date);
CREATE INDEX stat_hour_2014_10_date_index ON stat_hour_2014_10 USING btree (date);
CREATE INDEX stat_hour_2014_09_date_index ON stat_hour_2014_09 USING btree (date);
CREATE INDEX stat_hour_2014_08_date_index ON stat_hour_2014_08 USING btree (date);
CREATE INDEX stat_hour_2014_07_date_index ON stat_hour_2014_07 USING btree (date);
CREATE INDEX stat_hour_2014_06_date_index ON stat_hour_2014_06 USING btree (date);
CREATE INDEX stat_hour_2014_05_date_index ON stat_hour_2014_05 USING btree (date);
CREATE INDEX stat_hour_2014_04_date_index ON stat_hour_2014_04 USING btree (date);
CREATE INDEX stat_hour_2014_03_date_index ON stat_hour_2014_03 USING btree (date);
CREATE INDEX stat_hour_2014_02_date_index ON stat_hour_2014_02 USING btree (date);
CREATE INDEX stat_hour_2014_01_date_index ON stat_hour_2014_01 USING btree (date);
CREATE INDEX stat_hour_2013_12_date_index ON stat_hour_2013_12 USING btree (date);
CREATE INDEX stat_hour_2013_11_date_index ON stat_hour_2013_11 USING btree (date);
CREATE INDEX stat_hour_2013_10_date_index ON stat_hour_2013_10 USING btree (date);
CREATE INDEX stat_hour_2013_09_date_index ON stat_hour_2013_09 USING btree (date);
CREATE INDEX stat_hour_2013_08_date_index ON stat_hour_2013_08 USING btree (date);
CREATE INDEX stat_hour_2013_07_date_index ON stat_hour_2013_07 USING btree (date);
CREATE INDEX stat_hour_2013_06_date_index ON stat_hour_2013_06 USING btree (date);
CREATE INDEX stat_hour_2013_05_date_index ON stat_hour_2013_05 USING btree (date);
CREATE INDEX stat_hour_2013_04_date_index ON stat_hour_2013_04 USING btree (date);
CREATE INDEX stat_hour_2013_03_date_index ON stat_hour_2013_03 USING btree (date);
CREATE INDEX stat_hour_2013_02_date_index ON stat_hour_2013_02 USING btree (date);
CREATE INDEX stat_hour_2013_01_date_index ON stat_hour_2013_01 USING btree (date);

CREATE INDEX stat_hour_2016_12_offer_id_index ON stat_hour_2016_12 USING btree (offer_id);
CREATE INDEX stat_hour_2016_11_offer_id_index ON stat_hour_2016_11 USING btree (offer_id);
CREATE INDEX stat_hour_2016_10_offer_id_index ON stat_hour_2016_10 USING btree (offer_id);
CREATE INDEX stat_hour_2016_09_offer_id_index ON stat_hour_2016_09 USING btree (offer_id);
CREATE INDEX stat_hour_2016_08_offer_id_index ON stat_hour_2016_08 USING btree (offer_id);
CREATE INDEX stat_hour_2016_07_offer_id_index ON stat_hour_2016_07 USING btree (offer_id);
CREATE INDEX stat_hour_2016_06_offer_id_index ON stat_hour_2016_06 USING btree (offer_id);
CREATE INDEX stat_hour_2016_05_offer_id_index ON stat_hour_2016_05 USING btree (offer_id);
CREATE INDEX stat_hour_2016_04_offer_id_index ON stat_hour_2016_04 USING btree (offer_id);
CREATE INDEX stat_hour_2016_03_offer_id_index ON stat_hour_2016_03 USING btree (offer_id);
CREATE INDEX stat_hour_2016_02_offer_id_index ON stat_hour_2016_02 USING btree (offer_id);
CREATE INDEX stat_hour_2016_01_offer_id_index ON stat_hour_2016_01 USING btree (offer_id);
CREATE INDEX stat_hour_2015_12_offer_id_index ON stat_hour_2015_12 USING btree (offer_id);
CREATE INDEX stat_hour_2015_11_offer_id_index ON stat_hour_2015_11 USING btree (offer_id);
CREATE INDEX stat_hour_2015_10_offer_id_index ON stat_hour_2015_10 USING btree (offer_id);
CREATE INDEX stat_hour_2015_09_offer_id_index ON stat_hour_2015_09 USING btree (offer_id);
CREATE INDEX stat_hour_2015_08_offer_id_index ON stat_hour_2015_08 USING btree (offer_id);
CREATE INDEX stat_hour_2015_07_offer_id_index ON stat_hour_2015_07 USING btree (offer_id);
CREATE INDEX stat_hour_2015_06_offer_id_index ON stat_hour_2015_06 USING btree (offer_id);
CREATE INDEX stat_hour_2015_05_offer_id_index ON stat_hour_2015_05 USING btree (offer_id);
CREATE INDEX stat_hour_2015_04_offer_id_index ON stat_hour_2015_04 USING btree (offer_id);
CREATE INDEX stat_hour_2015_03_offer_id_index ON stat_hour_2015_03 USING btree (offer_id);
CREATE INDEX stat_hour_2015_02_offer_id_index ON stat_hour_2015_02 USING btree (offer_id);
CREATE INDEX stat_hour_2015_01_offer_id_index ON stat_hour_2015_01 USING btree (offer_id);
CREATE INDEX stat_hour_2014_12_offer_id_index ON stat_hour_2014_12 USING btree (offer_id);
CREATE INDEX stat_hour_2014_11_offer_id_index ON stat_hour_2014_11 USING btree (offer_id);
CREATE INDEX stat_hour_2014_10_offer_id_index ON stat_hour_2014_10 USING btree (offer_id);
CREATE INDEX stat_hour_2014_09_offer_id_index ON stat_hour_2014_09 USING btree (offer_id);
CREATE INDEX stat_hour_2014_08_offer_id_index ON stat_hour_2014_08 USING btree (offer_id);
CREATE INDEX stat_hour_2014_07_offer_id_index ON stat_hour_2014_07 USING btree (offer_id);
CREATE INDEX stat_hour_2014_06_offer_id_index ON stat_hour_2014_06 USING btree (offer_id);
CREATE INDEX stat_hour_2014_05_offer_id_index ON stat_hour_2014_05 USING btree (offer_id);
CREATE INDEX stat_hour_2014_04_offer_id_index ON stat_hour_2014_04 USING btree (offer_id);
CREATE INDEX stat_hour_2014_03_offer_id_index ON stat_hour_2014_03 USING btree (offer_id);
CREATE INDEX stat_hour_2014_02_offer_id_index ON stat_hour_2014_02 USING btree (offer_id);
CREATE INDEX stat_hour_2014_01_offer_id_index ON stat_hour_2014_01 USING btree (offer_id);
CREATE INDEX stat_hour_2013_12_offer_id_index ON stat_hour_2013_12 USING btree (offer_id);
CREATE INDEX stat_hour_2013_11_offer_id_index ON stat_hour_2013_11 USING btree (offer_id);
CREATE INDEX stat_hour_2013_10_offer_id_index ON stat_hour_2013_10 USING btree (offer_id);
CREATE INDEX stat_hour_2013_09_offer_id_index ON stat_hour_2013_09 USING btree (offer_id);
CREATE INDEX stat_hour_2013_08_offer_id_index ON stat_hour_2013_08 USING btree (offer_id);
CREATE INDEX stat_hour_2013_07_offer_id_index ON stat_hour_2013_07 USING btree (offer_id);
CREATE INDEX stat_hour_2013_06_offer_id_index ON stat_hour_2013_06 USING btree (offer_id);
CREATE INDEX stat_hour_2013_05_offer_id_index ON stat_hour_2013_05 USING btree (offer_id);
CREATE INDEX stat_hour_2013_04_offer_id_index ON stat_hour_2013_04 USING btree (offer_id);
CREATE INDEX stat_hour_2013_03_offer_id_index ON stat_hour_2013_03 USING btree (offer_id);
CREATE INDEX stat_hour_2013_02_offer_id_index ON stat_hour_2013_02 USING btree (offer_id);
CREATE INDEX stat_hour_2013_01_offer_id_index ON stat_hour_2013_01 USING btree (offer_id);

CREATE INDEX stat_hour_2016_12_aff_id_index ON stat_hour_2016_12 USING btree (aff_id);
CREATE INDEX stat_hour_2016_11_aff_id_index ON stat_hour_2016_11 USING btree (aff_id);
CREATE INDEX stat_hour_2016_10_aff_id_index ON stat_hour_2016_10 USING btree (aff_id);
CREATE INDEX stat_hour_2016_09_aff_id_index ON stat_hour_2016_09 USING btree (aff_id);
CREATE INDEX stat_hour_2016_08_aff_id_index ON stat_hour_2016_08 USING btree (aff_id);
CREATE INDEX stat_hour_2016_07_aff_id_index ON stat_hour_2016_07 USING btree (aff_id);
CREATE INDEX stat_hour_2016_06_aff_id_index ON stat_hour_2016_06 USING btree (aff_id);
CREATE INDEX stat_hour_2016_05_aff_id_index ON stat_hour_2016_05 USING btree (aff_id);
CREATE INDEX stat_hour_2016_04_aff_id_index ON stat_hour_2016_04 USING btree (aff_id);
CREATE INDEX stat_hour_2016_03_aff_id_index ON stat_hour_2016_03 USING btree (aff_id);
CREATE INDEX stat_hour_2016_02_aff_id_index ON stat_hour_2016_02 USING btree (aff_id);
CREATE INDEX stat_hour_2016_01_aff_id_index ON stat_hour_2016_01 USING btree (aff_id);
CREATE INDEX stat_hour_2015_12_aff_id_index ON stat_hour_2015_12 USING btree (aff_id);
CREATE INDEX stat_hour_2015_11_aff_id_index ON stat_hour_2015_11 USING btree (aff_id);
CREATE INDEX stat_hour_2015_10_aff_id_index ON stat_hour_2015_10 USING btree (aff_id);
CREATE INDEX stat_hour_2015_09_aff_id_index ON stat_hour_2015_09 USING btree (aff_id);
CREATE INDEX stat_hour_2015_08_aff_id_index ON stat_hour_2015_08 USING btree (aff_id);
CREATE INDEX stat_hour_2015_07_aff_id_index ON stat_hour_2015_07 USING btree (aff_id);
CREATE INDEX stat_hour_2015_06_aff_id_index ON stat_hour_2015_06 USING btree (aff_id);
CREATE INDEX stat_hour_2015_05_aff_id_index ON stat_hour_2015_05 USING btree (aff_id);
CREATE INDEX stat_hour_2015_04_aff_id_index ON stat_hour_2015_04 USING btree (aff_id);
CREATE INDEX stat_hour_2015_03_aff_id_index ON stat_hour_2015_03 USING btree (aff_id);
CREATE INDEX stat_hour_2015_02_aff_id_index ON stat_hour_2015_02 USING btree (aff_id);
CREATE INDEX stat_hour_2015_01_aff_id_index ON stat_hour_2015_01 USING btree (aff_id);
CREATE INDEX stat_hour_2014_12_aff_id_index ON stat_hour_2014_12 USING btree (aff_id);
CREATE INDEX stat_hour_2014_11_aff_id_index ON stat_hour_2014_11 USING btree (aff_id);
CREATE INDEX stat_hour_2014_10_aff_id_index ON stat_hour_2014_10 USING btree (aff_id);
CREATE INDEX stat_hour_2014_09_aff_id_index ON stat_hour_2014_09 USING btree (aff_id);
CREATE INDEX stat_hour_2014_08_aff_id_index ON stat_hour_2014_08 USING btree (aff_id);
CREATE INDEX stat_hour_2014_07_aff_id_index ON stat_hour_2014_07 USING btree (aff_id);
CREATE INDEX stat_hour_2014_06_aff_id_index ON stat_hour_2014_06 USING btree (aff_id);
CREATE INDEX stat_hour_2014_05_aff_id_index ON stat_hour_2014_05 USING btree (aff_id);
CREATE INDEX stat_hour_2014_04_aff_id_index ON stat_hour_2014_04 USING btree (aff_id);
CREATE INDEX stat_hour_2014_03_aff_id_index ON stat_hour_2014_03 USING btree (aff_id);
CREATE INDEX stat_hour_2014_02_aff_id_index ON stat_hour_2014_02 USING btree (aff_id);
CREATE INDEX stat_hour_2014_01_aff_id_index ON stat_hour_2014_01 USING btree (aff_id);
CREATE INDEX stat_hour_2013_12_aff_id_index ON stat_hour_2013_12 USING btree (aff_id);
CREATE INDEX stat_hour_2013_11_aff_id_index ON stat_hour_2013_11 USING btree (aff_id);
CREATE INDEX stat_hour_2013_10_aff_id_index ON stat_hour_2013_10 USING btree (aff_id);
CREATE INDEX stat_hour_2013_09_aff_id_index ON stat_hour_2013_09 USING btree (aff_id);
CREATE INDEX stat_hour_2013_08_aff_id_index ON stat_hour_2013_08 USING btree (aff_id);
CREATE INDEX stat_hour_2013_07_aff_id_index ON stat_hour_2013_07 USING btree (aff_id);
CREATE INDEX stat_hour_2013_06_aff_id_index ON stat_hour_2013_06 USING btree (aff_id);
CREATE INDEX stat_hour_2013_05_aff_id_index ON stat_hour_2013_05 USING btree (aff_id);
CREATE INDEX stat_hour_2013_04_aff_id_index ON stat_hour_2013_04 USING btree (aff_id);
CREATE INDEX stat_hour_2013_03_aff_id_index ON stat_hour_2013_03 USING btree (aff_id);
CREATE INDEX stat_hour_2013_02_aff_id_index ON stat_hour_2013_02 USING btree (aff_id);
CREATE INDEX stat_hour_2013_01_aff_id_index ON stat_hour_2013_01 USING btree (aff_id);

CREATE INDEX stat_hour_2016_12_country_index ON stat_hour_2016_12 USING btree (country);
CREATE INDEX stat_hour_2016_11_country_index ON stat_hour_2016_11 USING btree (country);
CREATE INDEX stat_hour_2016_10_country_index ON stat_hour_2016_10 USING btree (country);
CREATE INDEX stat_hour_2016_09_country_index ON stat_hour_2016_09 USING btree (country);
CREATE INDEX stat_hour_2016_08_country_index ON stat_hour_2016_08 USING btree (country);
CREATE INDEX stat_hour_2016_07_country_index ON stat_hour_2016_07 USING btree (country);
CREATE INDEX stat_hour_2016_06_country_index ON stat_hour_2016_06 USING btree (country);
CREATE INDEX stat_hour_2016_05_country_index ON stat_hour_2016_05 USING btree (country);
CREATE INDEX stat_hour_2016_04_country_index ON stat_hour_2016_04 USING btree (country);
CREATE INDEX stat_hour_2016_03_country_index ON stat_hour_2016_03 USING btree (country);
CREATE INDEX stat_hour_2016_02_country_index ON stat_hour_2016_02 USING btree (country);
CREATE INDEX stat_hour_2016_01_country_index ON stat_hour_2016_01 USING btree (country);
CREATE INDEX stat_hour_2015_12_country_index ON stat_hour_2015_12 USING btree (country);
CREATE INDEX stat_hour_2015_11_country_index ON stat_hour_2015_11 USING btree (country);
CREATE INDEX stat_hour_2015_10_country_index ON stat_hour_2015_10 USING btree (country);
CREATE INDEX stat_hour_2015_09_country_index ON stat_hour_2015_09 USING btree (country);
CREATE INDEX stat_hour_2015_08_country_index ON stat_hour_2015_08 USING btree (country);
CREATE INDEX stat_hour_2015_07_country_index ON stat_hour_2015_07 USING btree (country);
CREATE INDEX stat_hour_2015_06_country_index ON stat_hour_2015_06 USING btree (country);
CREATE INDEX stat_hour_2015_05_country_index ON stat_hour_2015_05 USING btree (country);
CREATE INDEX stat_hour_2015_04_country_index ON stat_hour_2015_04 USING btree (country);
CREATE INDEX stat_hour_2015_03_country_index ON stat_hour_2015_03 USING btree (country);
CREATE INDEX stat_hour_2015_02_country_index ON stat_hour_2015_02 USING btree (country);
CREATE INDEX stat_hour_2015_01_country_index ON stat_hour_2015_01 USING btree (country);
CREATE INDEX stat_hour_2014_12_country_index ON stat_hour_2014_12 USING btree (country);
CREATE INDEX stat_hour_2014_11_country_index ON stat_hour_2014_11 USING btree (country);
CREATE INDEX stat_hour_2014_10_country_index ON stat_hour_2014_10 USING btree (country);
CREATE INDEX stat_hour_2014_09_country_index ON stat_hour_2014_09 USING btree (country);
CREATE INDEX stat_hour_2014_08_country_index ON stat_hour_2014_08 USING btree (country);
CREATE INDEX stat_hour_2014_07_country_index ON stat_hour_2014_07 USING btree (country);
CREATE INDEX stat_hour_2014_06_country_index ON stat_hour_2014_06 USING btree (country);
CREATE INDEX stat_hour_2014_05_country_index ON stat_hour_2014_05 USING btree (country);
CREATE INDEX stat_hour_2014_04_country_index ON stat_hour_2014_04 USING btree (country);
CREATE INDEX stat_hour_2014_03_country_index ON stat_hour_2014_03 USING btree (country);
CREATE INDEX stat_hour_2014_02_country_index ON stat_hour_2014_02 USING btree (country);
CREATE INDEX stat_hour_2014_01_country_index ON stat_hour_2014_01 USING btree (country);
CREATE INDEX stat_hour_2013_12_country_index ON stat_hour_2013_12 USING btree (country);
CREATE INDEX stat_hour_2013_11_country_index ON stat_hour_2013_11 USING btree (country);
CREATE INDEX stat_hour_2013_10_country_index ON stat_hour_2013_10 USING btree (country);
CREATE INDEX stat_hour_2013_09_country_index ON stat_hour_2013_09 USING btree (country);
CREATE INDEX stat_hour_2013_08_country_index ON stat_hour_2013_08 USING btree (country);
CREATE INDEX stat_hour_2013_07_country_index ON stat_hour_2013_07 USING btree (country);
CREATE INDEX stat_hour_2013_06_country_index ON stat_hour_2013_06 USING btree (country);
CREATE INDEX stat_hour_2013_05_country_index ON stat_hour_2013_05 USING btree (country);
CREATE INDEX stat_hour_2013_04_country_index ON stat_hour_2013_04 USING btree (country);
CREATE INDEX stat_hour_2013_03_country_index ON stat_hour_2013_03 USING btree (country);
CREATE INDEX stat_hour_2013_02_country_index ON stat_hour_2013_02 USING btree (country);
CREATE INDEX stat_hour_2013_01_country_index ON stat_hour_2013_01 USING btree (country);

CREATE OR REPLACE FUNCTION stat_hour_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN

    -- Partitioning --
    IF (NEW.date >= TIMESTAMP '2016-11-01' AND NEW.date < TIMESTAMP '2016-12-01') THEN INSERT INTO stat_hour_2016_11 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-10-01' AND NEW.date < TIMESTAMP '2016-11-01') THEN INSERT INTO stat_hour_2016_10 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-09-01' AND NEW.date < TIMESTAMP '2016-10-01') THEN INSERT INTO stat_hour_2016_09 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-08-01' AND NEW.date < TIMESTAMP '2016-09-01') THEN INSERT INTO stat_hour_2016_08 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-07-01' AND NEW.date < TIMESTAMP '2016-08-01') THEN INSERT INTO stat_hour_2016_07 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-06-01' AND NEW.date < TIMESTAMP '2016-07-01') THEN INSERT INTO stat_hour_2016_06 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-05-01' AND NEW.date < TIMESTAMP '2016-06-01') THEN INSERT INTO stat_hour_2016_05 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-04-01' AND NEW.date < TIMESTAMP '2016-05-01') THEN INSERT INTO stat_hour_2016_04 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-03-01' AND NEW.date < TIMESTAMP '2016-04-01') THEN INSERT INTO stat_hour_2016_03 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-02-01' AND NEW.date < TIMESTAMP '2016-03-01') THEN INSERT INTO stat_hour_2016_02 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2016-01-01' AND NEW.date < TIMESTAMP '2016-02-01') THEN INSERT INTO stat_hour_2016_01 VALUES (NEW.*);
    
    ELSIF (NEW.date >= TIMESTAMP '2015-12-01' AND NEW.date < TIMESTAMP '2016-01-01') THEN INSERT INTO stat_hour_2015_12 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-11-01' AND NEW.date < TIMESTAMP '2015-12-01') THEN INSERT INTO stat_hour_2015_11 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-10-01' AND NEW.date < TIMESTAMP '2015-11-01') THEN INSERT INTO stat_hour_2015_10 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-09-01' AND NEW.date < TIMESTAMP '2015-10-01') THEN INSERT INTO stat_hour_2015_09 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-08-01' AND NEW.date < TIMESTAMP '2015-09-01') THEN INSERT INTO stat_hour_2015_08 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-07-01' AND NEW.date < TIMESTAMP '2015-08-01') THEN INSERT INTO stat_hour_2015_07 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-06-01' AND NEW.date < TIMESTAMP '2015-07-01') THEN INSERT INTO stat_hour_2015_06 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-05-01' AND NEW.date < TIMESTAMP '2015-06-01') THEN INSERT INTO stat_hour_2015_05 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-04-01' AND NEW.date < TIMESTAMP '2015-05-01') THEN INSERT INTO stat_hour_2015_04 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-03-01' AND NEW.date < TIMESTAMP '2015-04-01') THEN INSERT INTO stat_hour_2015_03 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-02-01' AND NEW.date < TIMESTAMP '2015-03-01') THEN INSERT INTO stat_hour_2015_02 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2015-01-01' AND NEW.date < TIMESTAMP '2015-02-01') THEN INSERT INTO stat_hour_2015_01 VALUES (NEW.*);
    
    ELSIF (NEW.date >= TIMESTAMP '2014-12-01' AND NEW.date < TIMESTAMP '2015-01-01') THEN INSERT INTO stat_hour_2014_12 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-11-01' AND NEW.date < TIMESTAMP '2014-12-01') THEN INSERT INTO stat_hour_2014_11 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-10-01' AND NEW.date < TIMESTAMP '2014-11-01') THEN INSERT INTO stat_hour_2014_10 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-09-01' AND NEW.date < TIMESTAMP '2014-10-01') THEN INSERT INTO stat_hour_2014_09 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-08-01' AND NEW.date < TIMESTAMP '2014-09-01') THEN INSERT INTO stat_hour_2014_08 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-07-01' AND NEW.date < TIMESTAMP '2014-08-01') THEN INSERT INTO stat_hour_2014_07 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-06-01' AND NEW.date < TIMESTAMP '2014-07-01') THEN INSERT INTO stat_hour_2014_06 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-05-01' AND NEW.date < TIMESTAMP '2014-06-01') THEN INSERT INTO stat_hour_2014_05 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-04-01' AND NEW.date < TIMESTAMP '2014-05-01') THEN INSERT INTO stat_hour_2014_04 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-03-01' AND NEW.date < TIMESTAMP '2014-04-01') THEN INSERT INTO stat_hour_2014_03 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-02-01' AND NEW.date < TIMESTAMP '2014-03-01') THEN INSERT INTO stat_hour_2014_02 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2014-01-01' AND NEW.date < TIMESTAMP '2014-02-01') THEN INSERT INTO stat_hour_2014_01 VALUES (NEW.*);
    
    ELSIF (NEW.date >= TIMESTAMP '2013-12-01' AND NEW.date < TIMESTAMP '2014-01-01') THEN INSERT INTO stat_hour_2013_12 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-11-01' AND NEW.date < TIMESTAMP '2013-12-01') THEN INSERT INTO stat_hour_2013_11 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-10-01' AND NEW.date < TIMESTAMP '2013-11-01') THEN INSERT INTO stat_hour_2013_10 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-09-01' AND NEW.date < TIMESTAMP '2013-10-01') THEN INSERT INTO stat_hour_2013_09 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-08-01' AND NEW.date < TIMESTAMP '2013-09-01') THEN INSERT INTO stat_hour_2013_08 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-07-01' AND NEW.date < TIMESTAMP '2013-08-01') THEN INSERT INTO stat_hour_2013_07 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-06-01' AND NEW.date < TIMESTAMP '2013-07-01') THEN INSERT INTO stat_hour_2013_06 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-05-01' AND NEW.date < TIMESTAMP '2013-06-01') THEN INSERT INTO stat_hour_2013_05 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-04-01' AND NEW.date < TIMESTAMP '2013-05-01') THEN INSERT INTO stat_hour_2013_04 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-03-01' AND NEW.date < TIMESTAMP '2013-04-01') THEN INSERT INTO stat_hour_2013_03 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-02-01' AND NEW.date < TIMESTAMP '2013-03-01') THEN INSERT INTO stat_hour_2013_02 VALUES (NEW.*);
    ELSIF (NEW.date >= TIMESTAMP '2013-01-01' AND NEW.date < TIMESTAMP '2013-02-01') THEN INSERT INTO stat_hour_2013_01 VALUES (NEW.*);
    
    ELSIF (NEW.date >= TIMESTAMP '2016-12-01') THEN INSERT INTO stat_hour_2016_12 VALUES (NEW.*);
    ELSE RAISE EXCEPTION 'Date % is out of range. Fix stat_hour', NEW.date;
    END IF;

    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER stat_hour_before_insert
   BEFORE INSERT ON stat_hour
   FOR EACH ROW EXECUTE PROCEDURE stat_hour_insert_trigger();