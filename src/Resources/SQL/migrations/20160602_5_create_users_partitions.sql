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