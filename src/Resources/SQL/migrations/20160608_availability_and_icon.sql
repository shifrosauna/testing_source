ALTER TABLE offers ALTER COLUMN availability TYPE text;
ALTER TABLE offers ALTER COLUMN availability DROP DEFAULT;

ALTER TABLE offers ADD COLUMN icon text;