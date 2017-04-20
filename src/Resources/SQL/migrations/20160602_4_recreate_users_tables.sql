--
-- Users
--
DROP TABLE IF EXISTS users;

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

--
-- Users access
--
DROP TABLE IF EXISTS users_access;

CREATE TABLE users_access (
    nid integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL,
    CONSTRAINT users_access_pk PRIMARY KEY (nid,group_id,permission_id)
) WITH (
    OIDS=FALSE
);

--
-- Users groups
--
DROP TABLE IF EXISTS users_groups;

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

--
-- Users info
--
DROP TABLE IF EXISTS users_info;

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

--
-- Users permissions
--
DROP TABLE IF EXISTS users_permissions;

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