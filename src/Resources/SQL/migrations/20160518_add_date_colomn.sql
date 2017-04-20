--
-- Add colomn 'date' to table news
--
ALTER TABLE news ADD COLUMN  date timestamp without time zone NOT NULL DEFAULT now();
ALTER TABLE news ALTER COLUMN date DROP DEFAULT;