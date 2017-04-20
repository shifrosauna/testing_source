
CREATE TABLE countries (
    code text NOT NULL,
    name text NOT NULL,
    cpa double precision,
    cpa_currency text NOT NULL,
    CONSTRAINT countries_code_pkey PRIMARY KEY (code)
) WITH (
    OIDS=FALSE
);



--
-- Menu
--
CREATE TABLE menu (
    id serial NOT NULL,
    url text,
    icon text,
    title text,
    parent_id integer DEFAULT 0,
    permission_id integer DEFAULT 0,
    weight integer DEFAULT 0,
    CONSTRAINT menu_id_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



--
-- News
--
CREATE TABLE news (
    id serial NOT NULL,
    date_c timestamp without time zone NOT NULL DEFAULT now(),
    date_u timestamp without time zone NOT NULL DEFAULT now(),
    date_s timestamp without time zone,
    date timestamp without time zone NOT NULL,
    CONSTRAINT news_id_pkey PRIMARY KEY (id)
) WITH (
    OIDS=FALSE
);



--
-- News Translations table
--
CREATE TABLE news_lang (
    new_id int NOT NULL,
    lang text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    CONSTRAINT news_lang_id_pkey PRIMARY KEY (new_id,lang)
);
comment on column news_lang.new_id is 'The news ID from table NEWS';
comment on column news_lang.lang is 'The language(ru,en,fr and etc)';
comment on column news_lang.title is 'The news Title in this language';
comment on column news_lang.description is 'The news Description in this language';



--
-- Offers
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
COMMENT ON COLUMN offers.nid IS 'ID сетки';
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
-- Offers translates
--
CREATE TABLE offers_translates (
    nid integer NOT NULL,
    offer_id integer NOT NULL,
    lang text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    recommendations text,
    recommendations_partners text,
    conditions text,
    restrictions text,
    CONSTRAINT offers_translates_pk PRIMARY KEY (nid,offer_id,lang)
) WITH (
    OIDS=FALSE
);
COMMENT ON COLUMN offers_translates.name IS 'Название оффера';
COMMENT ON COLUMN offers_translates.description IS 'Описание оффера';
COMMENT ON COLUMN offers_translates.recommendations IS 'Рекомендации для менеджеров';
COMMENT ON COLUMN offers_translates.recommendations_partners IS 'Рекомендации для партнеров';
COMMENT ON COLUMN offers_translates.conditions IS 'Условия работы';
COMMENT ON COLUMN offers_translates.restrictions IS 'Ограничения и запреты';

--
-- Offers goals
--
CREATE TABLE offers_goals (
    nid integer NOT NULL,
    id integer NOT NULL,
    offer_id integer NOT NULL,
    payout double precision NOT NULL,
    payout_currency text NOT NULL,
    revenue double precision NOT NULL,
    revenue_currency text NOT NULL,
    CONSTRAINT offers_goals_pk PRIMARY KEY (nid,id,offer_id)
) WITH (
    OIDS=FALSE
);
COMMENT ON COLUMN offers_goals.payout IS 'Выплата партнеру';
COMMENT ON COLUMN offers_goals.payout_currency IS 'Валюта выплаты';
COMMENT ON COLUMN offers_goals.revenue IS 'Доход';
COMMENT ON COLUMN offers_goals.revenue_currency IS 'Валюта дохода';

--
-- Offers goals translates
--
CREATE TABLE offers_goals_translates (
    nid integer NOT NULL,
    goal_id integer NOT NULL,
    lang text NOT NULL,
    name text NOT NULL,
    description text,
    CONSTRAINT offers_goals_translates_pk PRIMARY KEY (nid,goal_id,lang)
) WITH (
    OIDS=FALSE
);
COMMENT ON COLUMN offers_goals_translates.name IS 'Название цели';
COMMENT ON COLUMN offers_goals_translates.description IS 'Описание цели';

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
-- Offers options
--
CREATE TABLE offers_options (
    nid integer NOT NULL,
    offer_id integer NOT NULL,
    CONSTRAINT offers_options_pk PRIMARY KEY (nid,offer_id)
) WITH (
    OIDS=FALSE
);



--
-- Payments
--
CREATE TABLE payments (
    id serial NOT NULL,
    user_id integer NOT NULL,
    sum double precision,
    currency text,
    group_id integer DEFAULT 0,
    offer_id integer DEFAULT 0,
    sum_rub double precision DEFAULT 0,
    sum_usd double precision DEFAULT 0,
    sum_eur double precision DEFAULT 0,
    payment_type text,
    status smallint NOT NULL DEFAULT 0,
    date_c timestamp without time zone NOT NULL DEFAULT now(),
    date_u timestamp without time zone NOT NULL DEFAULT now(),
    date_p timestamp without time zone,
    CONSTRAINT payments_id_pkey PRIMARY KEY (id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE payments_status (
    payment_id integer NOT NULL,
    status smallint NOT NULL DEFAULT 0,
    comment text,
    check_status integer DEFAULT 0,
    success integer DEFAULT 1,
    traffic integer DEFAULT 0,
    adv_approve integer DEFAULT 0,
    adv_paid integer DEFAULT 0,
    CONSTRAINT payments_status_pkey PRIMARY KEY (payment_id)
) WITH (
    OIDS=FALSE
);



--
-- Tickets
--
CREATE TABLE tickets (
    id serial NOT NULL,
    theme text NOT NULL,
    description text NOT NULL,
    status integer NOT NULL DEFAULT 1,
    priority_id integer NOT NULL DEFAULT 2,
    category_id integer NOT NULL,
    owner_id integer NOT NULL,
    owner_name text,
    assigned_id integer,
    date_c timestamp without time zone NOT NULL DEFAULT now(),
    date_u timestamp without time zone NOT NULL DEFAULT now(),
    views_partner integer NOT NULL DEFAULT 0,
    views_admin integer NOT NULL DEFAULT 0,
    CONSTRAINT tickets_id_pkey PRIMARY KEY (id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE tickets_categories (
    id serial NOT NULL,
    name text NOT NULL,
    by_default boolean DEFAULT FALSE,
    CONSTRAINT tickets_categories_id_pkey PRIMARY KEY (id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE tickets_comments (
    id serial NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer,
    user_name text,
    message text NOT NULL,
    parent_id integer DEFAULT 0,
    status smallint NOT NULL DEFAULT 1,
    date_c timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT comments_id_pkey PRIMARY KEY (id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE tickets_priorities(
    id serial NOT NULL,
    name text NOT NULL,
    by_default boolean DEFAULT FALSE,
    CONSTRAINT tickets_priorities_id_pkey PRIMARY KEY (id)
) WITH (
    OIDS=FALSE
);



--
-- Users
--
CREATE TABLE users (
    nid integer NOT NULL,
    id integer NOT NULL,
    login text NOT NULL,
    email text NOT NULL,
    hash text NOT NULL,
    lang text NOT NULL DEFAULT 'ru'::text,
    status integer DEFAULT 1,
    ref_id integer DEFAULT 0,
    groups integer[],
    comment text,
    date_c timestamp without time zone NOT NULL DEFAULT now(),
    date_u timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT users_pk PRIMARY KEY (nid,id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE users_access (
    nid integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL,
    CONSTRAINT users_access_pk PRIMARY KEY (nid,group_id,permission_id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE users_groups (
    nid integer NOT NULL,
    id integer NOT NULL,
    name text NOT NULL,
    status integer DEFAULT 1,
    comment text,
    CONSTRAINT users_groups_pk PRIMARY KEY (nid,id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE users_info (
    nid integer NOT NULL,
    user_id integer NOT NULL,
    wmr text,
    wmz text,
    skype text,
    comment text,
    traffic_types text,
    traffic_subjects text,
    traffic_volumes text,
    CONSTRAINT users_info_pk PRIMARY KEY (nid,user_id)
) WITH (
    OIDS=FALSE
);

CREATE TABLE users_permissions (
    nid integer NOT NULL,
    id integer NOT NULL,
    module text NOT NULL,
    action text NOT NULL,
    status integer DEFAULT 1,
    comment text,
    CONSTRAINT users_permissions_pk PRIMARY KEY (nid,id)
) WITH (
    OIDS=FALSE
);