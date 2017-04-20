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
CREATE TABLE _1_offers_translates (LIKE offers_translates INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_translates ADD CONSTRAINT _1_offers_translates_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_translates ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_translates INHERIT offers_translates;

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
CREATE TABLE _1_offers_goals_translates (LIKE offers_goals_translates INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_goals_translates ADD CONSTRAINT _1_offers_goals_translates_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_goals_translates ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_goals_translates INHERIT offers_goals_translates;

--
-- Offers tracking
--
CREATE SEQUENCE _1_offers_tracking_id_seq;
CREATE TABLE _1_offers_tracking (LIKE offers_tracking INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_tracking ADD CONSTRAINT _1_offers_tracking_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_tracking ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_tracking ALTER COLUMN id SET DEFAULT nextval('_1_offers_tracking_id_seq' :: regclass);
ALTER TABLE _1_offers_tracking INHERIT offers_tracking;

--
-- Offers options
--
CREATE TABLE _1_offers_options (LIKE offers_options INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_offers_options ADD CONSTRAINT _1_offers_options_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_offers_options ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_offers_options INHERIT offers_options;

--
-- Users
--
CREATE SEQUENCE _1_users_id_seq;
CREATE TABLE _1_users (LIKE users INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_users ADD CONSTRAINT _1_users_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_users ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_users ALTER COLUMN id SET DEFAULT nextval('_1_users_id_seq' :: regclass);
ALTER TABLE _1_users INHERIT users;

--
-- Users access
--
CREATE TABLE _1_users_access (LIKE users_access INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_users_access ADD CONSTRAINT _1_users_access_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_users_access ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_users_access INHERIT users_access;

--
-- Users groups
--
CREATE SEQUENCE _1_users_groups_id_seq;
CREATE TABLE _1_users_groups (LIKE users_groups INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_users_groups ADD CONSTRAINT _1_users_groups_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_users_groups ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_users_groups ALTER COLUMN id SET DEFAULT nextval('_1_users_groups_id_seq' :: regclass);
ALTER TABLE _1_users_groups INHERIT users_groups;

--
-- Users info
--
CREATE TABLE _1_users_info (LIKE users_info INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_users_info ADD CONSTRAINT _1_users_info_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_users_info ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_users_info INHERIT users_info;

--
-- Users permissions
--
CREATE SEQUENCE _1_users_permissions_id_seq;
CREATE TABLE _1_users_permissions (LIKE users_permissions INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES);
ALTER TABLE _1_users_permissions ADD CONSTRAINT _1_users_permissions_nid_check CHECK ( nid = 1 );
ALTER TABLE _1_users_permissions ALTER COLUMN nid SET DEFAULT 1;
ALTER TABLE _1_users_permissions ALTER COLUMN id SET DEFAULT nextval('_1_users_permissions_id_seq' :: regclass);
ALTER TABLE _1_users_permissions INHERIT users_permissions;