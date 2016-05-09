CREATE EXTENSION dblink;

DO
$body$
BEGIN
   IF NOT EXISTS (
      SELECT *
      FROM   pg_catalog.pg_database
      WHERE  datname = 'sample') THEN
        PERFORM dblink_exec('dbname=' || current_database()   -- current db
                       , 'CREATE DATABASE ' || quote_ident('sample')); 
   ELSE
     RAISE NOTICE 'Database already exists';
   END IF;
END
$body$;

DO
$body$
BEGIN
  IF NOT EXISTS (
     SELECT *
     FROM   pg_catalog.pg_user
     WHERE  usename = 'test') THEN
       CREATE USER test PASSWORD 'test123';
     ELSE
       RAISE NOTICE 'User already exists';
  END IF;
END
$body$;

\connect sample


CREATE SCHEMA IF NOT EXISTS sample;
SET search_path TO sample,public;

CREATE EXTENSION multicorn;
CREATE TABLE IF NOT EXISTS sample.dummy(myid integer );




CREATE SERVER rss_srv foreign data wrapper multicorn options (
    wrapper 'multicorn.rssfdw.RssFdw'
);

CREATE FOREIGN TABLE sample.reutersrss (
    "pubDate" timestamp,
    description character varying,
    title character varying,
    link character varying
) server rss_srv options (
    url     'http://feeds.reuters.com/Reuters/UKTopNews?format=xml'
);



GRANT ALL PRIVILEGES ON DATABASE sample TO test;
GRANT ALL PRIVILEGES ON SCHEMA sample TO GROUP test;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA sample TO GROUP test;
