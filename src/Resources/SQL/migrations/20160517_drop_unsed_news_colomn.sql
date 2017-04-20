--
--Drop unsed colomn from table news
--
ALTER TABLE news DROP COLUMN  IF EXISTS title;
ALTER TABLE news DROP COLUMN  IF EXISTS description;