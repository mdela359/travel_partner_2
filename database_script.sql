-- SCHEMA: public

-- DROP SCHEMA IF EXISTS public ;

CREATE SCHEMA IF NOT EXISTS public
    AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT USAGE ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO pg_database_owner;

  

-- Table: public.continent

-- DROP TABLE IF EXISTS public.continent;

CREATE TABLE IF NOT EXISTS public.continent
(
    continent_id integer NOT NULL,
    continent_name character varying(20) COLLATE pg_catalog."default",
    code character varying(2) COLLATE pg_catalog."default",
    population integer,
    area double precision,
    CONSTRAINT continent_pkey PRIMARY KEY (continent_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.continent
    OWNER to postgres;


-- Table: public.country

-- DROP TABLE IF EXISTS public.country;

CREATE TABLE IF NOT EXISTS public.country
(
    country_id integer NOT NULL,
    country_name character varying(40) COLLATE pg_catalog."default",
    ride_share boolean NOT NULL,
    continent_id integer,
    CONSTRAINT country_pkey PRIMARY KEY (country_id),
    CONSTRAINT continent_fk FOREIGN KEY (continent_id)
        REFERENCES public.continent (continent_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.country
    OWNER to postgres;

-- Table: public.city

-- DROP TABLE IF EXISTS public.city;  
CREATE TABLE IF NOT EXISTS public.city
(
    city_id integer NOT NULL,
    city_name character varying(20) COLLATE pg_catalog."default",
    population integer,
    weather character varying(20) COLLATE pg_catalog."default",
    area double precision,
    country_id integer,
    CONSTRAINT city_pkey PRIMARY KEY (city_id),
    CONSTRAINT country_fk FOREIGN KEY (country_id)
        REFERENCES public.country (country_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.city
    OWNER to postgres;

-- Table: public.currency

-- DROP TABLE IF EXISTS public.currency;

CREATE TABLE IF NOT EXISTS public.currency
(
    currency_id integer NOT NULL,
    currency_name character varying(20) COLLATE pg_catalog."default",
    amount integer,
    us_dollar double precision,
    ios_code character varying(20) COLLATE pg_catalog."default",
    bank_notes character varying(20) COLLATE pg_catalog."default",
    sub_unit character varying(20) COLLATE pg_catalog."default",
    coins character varying(20) COLLATE pg_catalog."default",
    country_id integer,
    CONSTRAINT currency_pkey PRIMARY KEY (currency_id),
    CONSTRAINT country_cu_fk FOREIGN KEY (country_id)
        REFERENCES public.country (country_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.currency
    OWNER to postgres;

-- Table: public.holiday

-- DROP TABLE IF EXISTS public.holiday;

CREATE TABLE IF NOT EXISTS public.holiday
(
    holiday_id integer NOT NULL,
    holiday_name character varying(20) COLLATE pg_catalog."default",
    holiday_date date,
    description text COLLATE pg_catalog."default",
    country_id integer,
    CONSTRAINT holiday_pkey PRIMARY KEY (holiday_id),
    CONSTRAINT country_ho_fk FOREIGN KEY (country_id)
        REFERENCES public.country (country_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.holiday
    OWNER to postgres;


-- Table: public.langua

-- DROP TABLE IF EXISTS public.langua;

CREATE TABLE IF NOT EXISTS public.langua
(
    language_id integer NOT NULL,
    language_name character varying(20) COLLATE pg_catalog."default",
    country_id integer,
    CONSTRAINT langua_pkey PRIMARY KEY (language_id),
    CONSTRAINT langua_country_id_fkey FOREIGN KEY (country_id)
        REFERENCES public.country (country_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.langua
    OWNER to postgres;

-- Table: public.hourly_temperatures

-- DROP TABLE IF EXISTS public.hourly_temperatures;

CREATE TABLE IF NOT EXISTS public.hourly_temperatures
(
    id integer NOT NULL DEFAULT nextval('hourly_temperatures_id_seq'::regclass),
    hour character varying(5) COLLATE pg_catalog."default",
    temperature character varying(8) COLLATE pg_catalog."default",
    CONSTRAINT hourly_temperatures_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hourly_temperatures
    OWNER to postgres;