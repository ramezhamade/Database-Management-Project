-- Table: public.akas

-- DROP TABLE public.akas;

CREATE TABLE public.akas
(
    titleid character varying(15) COLLATE pg_catalog."default" NOT NULL,
    ordering integer NOT NULL,
    title text COLLATE pg_catalog."default",
    region character varying(15) COLLATE pg_catalog."default",
    language character varying(15) COLLATE pg_catalog."default",
    types text[] COLLATE pg_catalog."default",
    attributes text[] COLLATE pg_catalog."default",
    isorignaltitle boolean,
    CONSTRAINT akas_pkey PRIMARY KEY (titleid, ordering),
    CONSTRAINT akas_nconst_fkey FOREIGN KEY (titleid)
        REFERENCES public.basics (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.akas
    OWNER to postgres;
-- Index: akas_attributes_index

-- DROP INDEX public.akas_attributes_index;

CREATE INDEX akas_attributes_index
    ON public.akas USING btree
    (titleid COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
------------------------------------------------------------------
-- Table: public.basics

-- DROP TABLE public.basics;

CREATE TABLE public.basics
(
    tconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    titletype character varying(15) COLLATE pg_catalog."default",
    primarytitle text COLLATE pg_catalog."default",
    orignaltitle text COLLATE pg_catalog."default",
    isadult boolean,
    startyear integer,
    endyear integer,
    runtimeminutes integer,
    CONSTRAINT basics_pri_key PRIMARY KEY (tconst)
)

TABLESPACE pg_default;

ALTER TABLE public.basics
    OWNER to postgres;
-- Index: basics_attributes_index

-- DROP INDEX public.basics_attributes_index;

CREATE INDEX basics_attributes_index
    ON public.basics USING btree
    (tconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
---------------------------------------------------------------------
-- Table: public.crew

-- DROP TABLE public.crew;

CREATE TABLE public.crew
(
    tconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    directors character varying COLLATE pg_catalog."default",
    writers character varying COLLATE pg_catalog."default",
    CONSTRAINT crew_pri_key PRIMARY KEY (tconst),
    CONSTRAINT crew_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.crew
    OWNER to postgres;
-- Index: crew_attributes_index

-- DROP INDEX public.crew_attributes_index;

CREATE INDEX crew_attributes_index
    ON public.crew USING btree
    (tconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
--------------------------------------------------------------------
-- Table: public.episode

-- DROP TABLE public.episode;

CREATE TABLE public.episode
(
    tconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    parenttconst character varying(15) COLLATE pg_catalog."default",
    seasonnumber integer,
    episodenumber integer,
    CONSTRAINT episode_pkey PRIMARY KEY (tconst),
    CONSTRAINT episode_parenttconst_fkey FOREIGN KEY (parenttconst)
        REFERENCES public.basics (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT episode_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.episode
    OWNER to postgres;
-- Index: ep_title_id_index

-- DROP INDEX public.ep_title_id_index;

CREATE INDEX ep_title_id_index
    ON public.episode USING btree
    (tconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: parent_title_id_index

-- DROP INDEX public.parent_title_id_index;

CREATE INDEX parent_title_id_index
    ON public.episode USING btree
    (parenttconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-------------------------------------------------------------------------------------
-- Table: public.genres

-- DROP TABLE public.genres;

CREATE TABLE public.genres
(
    tconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    genres text[] COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genres_pri_key PRIMARY KEY (tconst, genres),
    CONSTRAINT genres_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.genres
    OWNER to postgres;
-- Index: genres_genre_index

-- DROP INDEX public.genres_genre_index;

CREATE INDEX genres_genre_index
    ON public.genres USING btree
    (genres COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: genres_title_id_index

-- DROP INDEX public.genres_title_id_index;

CREATE INDEX genres_title_id_index
    ON public.genres USING btree
    (tconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
--------------------------------------------------------------------------------
-- Table: public.namebasics

-- DROP TABLE public.namebasics;

CREATE TABLE public.namebasics
(
    nconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    primaryname text COLLATE pg_catalog."default",
    birthyear integer,
    deathyear integer,
    CONSTRAINT namebasics_pri_key PRIMARY KEY (nconst)
)

TABLESPACE pg_default;

ALTER TABLE public.namebasics
    OWNER to postgres;
-- Index: namebasics_attributes_index

-- DROP INDEX public.namebasics_attributes_index;

CREATE INDEX namebasics_attributes_index
    ON public.namebasics USING btree
    (nconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-----------------------------------------------------------------------------
-- Table: public.principals

-- DROP TABLE public.principals;

CREATE TABLE public.principals
(
    tconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    ordering integer NOT NULL,
    nconst character varying COLLATE pg_catalog."default",
    category text COLLATE pg_catalog."default",
    job text COLLATE pg_catalog."default",
    characters text COLLATE pg_catalog."default",
    CONSTRAINT principals_pri_key PRIMARY KEY (tconst, ordering),
    CONSTRAINT principals_nconst_fkey FOREIGN KEY (nconst)
        REFERENCES public.namebasics (nconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT principals_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.principals
    OWNER to postgres;
-- Index: principals_index

-- DROP INDEX public.principals_index;

CREATE INDEX principals_index
    ON public.principals USING btree
    (tconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
---------------------------------------------------------------------------------------
-- Table: public.rating

-- DROP TABLE public.rating;

CREATE TABLE public.rating
(
    tconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    averagerating numeric,
    numvotes integer,
    CONSTRAINT rating_pri_key PRIMARY KEY (tconst),
    CONSTRAINT rating_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.rating
    OWNER to postgres;
-- Index: rating_index

-- DROP INDEX public.rating_index;

CREATE INDEX rating_index
    ON public.rating USING btree
    (tconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
--------------------------------------------------------------------------------
-- Table: public.workedas

-- DROP TABLE public.workedas;

CREATE TABLE public.workedas
(
    nconst character varying(15) COLLATE pg_catalog."default" NOT NULL,
    primaryprofession text[] COLLATE pg_catalog."default" NOT NULL,
    knownfortitles character varying[] COLLATE pg_catalog."default",
    CONSTRAINT workedas_pri_key PRIMARY KEY (nconst, primaryprofession),
    CONSTRAINT workedas_tconst_fkey FOREIGN KEY (nconst)
        REFERENCES public.namebasics (nconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.workedas
    OWNER to postgres;
-- Index: workedas_attributes_index

-- DROP INDEX public.workedas_attributes_index;

CREATE INDEX workedas_attributes_index
    ON public.workedas USING btree
    (nconst COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;