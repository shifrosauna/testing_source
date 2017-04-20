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