
-- Imported files in tsv format
-- Created table using pgadmin
-- Delete first row as they were column names
-- Query for deleting first row
DELETE FROM public.akas
WHERE "title" = 'title';
DELETE FROM public.basics
WHERE "tconst" = 'tconst';
DELETE FROM public.crew
WHERE "tconst" = 'tconst';
DELETE FROM public.episode
WHERE "tconst" = 'tconst';
DELETE FROM public.namebasics
WHERE "nconst" = 'nconst';
DELETE FROM public.principals
WHERE "tconst" = 'tconst';
DELETE FROM public.rating
WHERE "tconst" = 'tconst';

--- Changing datatypes of each column as initially we imported them in text

-- akas
ALTER TABLE akas ALTER COLUMN isorignaltitle TYPE boolean
USING isorignaltitle::boolean;
ALTER TABLE akas ALTER COLUMN ordering  TYPE integer 
USING (ordering::integer);
ALTER TABLE akas ALTER COLUMN types TYPE text[]
USING array[types]::text[]; 
ALTER TABLE akas ALTER COLUMN attributes TYPE text[]
USING array[attributes]::text[]; 

-- basics
ALTER TABLE basics ALTER COLUMN isadult TYPE boolean
USING isadult::boolean;
ALTER TABLE basics ALTER COLUMN startyear  TYPE integer 
USING (startyear::integer);
ALTER TABLE basics ALTER COLUMN endyear  TYPE integer
USING (endyear::integer);
ALTER TABLE basics ALTER COLUMN runtimeminutes  TYPE integer
USING (runtimeminutes::integer);
ALTER TABLE public.basics ALTER COLUMN genres  TYPE text[]
USING array[genres]::text[]; 

-- episode
ALTER TABLE episode ALTER COLUMN seasonnumber  TYPE integer 
USING (seasonnumber::integer);
ALTER TABLE episode ALTER COLUMN episodenumber  TYPE integer 
USING (episodenumber::integer);

-- namebasics
ALTER TABLE namebasics ALTER COLUMN birthyear  TYPE integer 
USING (birthyear::integer);
ALTER TABLE namebasics ALTER COLUMN deathyear  TYPE integer
USING (deathyear::integer);
ALTER TABLE namebasics ALTER COLUMN primaryprofession TYPE text[]
USING array[primaryprofession]::text[]; 
ALTER TABLE namebasics ALTER COLUMN knownfortitles TYPE character varying[]
USING array[knownfortitles]::character varying[]; 

-- principals
ALTER TABLE principals ALTER COLUMN ordering  TYPE integer 
USING (ordering::integer);

-- rating
ALTER TABLE rating ALTER COLUMN numvotes  TYPE integer
USING (numvotes::integer);
ALTER TABLE rating ALTER COLUMN averagerating SET DATA TYPE decimal
USING (averagerating::decimal)

--ER diagram
-- Splited basic into basic, basic and genres
-- delete remaining columns
CREATE TABLE genres AS TABLE basics;

--splited namebasics into namebasics and workedas
-- delete remaining columns
CREATE TABLE workedas AS TABLE namebasics;


-- Adding constraints

-- Adding primary key
-- basics is the master table
ALTER TABLE basics ADD CONSTRAINT basics_pri_key PRIMARY KEY (tconst);
-- namebasics
ALTER TABLE namebasics ADD CONSTRAINT namebasics_pri_key PRIMARY KEY (nconst);
-- akas
ALTER TABLE akas ADD PRIMARY KEY (titleid,ordering);
---crew
ALTER TABLE crew ADD CONSTRAINT crew_pri_key PRIMARY KEY (tconst);
-- episode
ALTER TABLE episode ADD PRIMARY KEY (tconst);
-- worked as
ALTER TABLE workedas ADD CONSTRAINT workedas_pri_key PRIMARY KEY (nconst,primaryprofession);
-- principals
ALTER TABLE principals ADD CONSTRAINT principals_pri_key PRIMARY KEY (tconst,ordering);
-- genres
ALTER TABLE genres ADD CONSTRAINT genres_pri_key PRIMARY KEY (tconst,genres)
-- rating
ALTER TABLE rating ADD CONSTRAINT rating_pri_key PRIMARY KEY (tconst);


-- foreign key
-- deleting columns to set foreign keys as rows were not matching.

-- principals
DELETE FROM principals principals
    WHERE NOT EXISTS (
    SELECT FROM basics basics
    WHERE basics.tconst = principals.tconst
    );

-- akas

DELETE FROM akas akas
    WHERE NOT EXISTS (
    SELECT FROM basics basics
    WHERE basics.tconst = akas.titleid
    );

-- episode


DELETE FROM episode episode
    WHERE NOT EXISTS (
    SELECT FROM basics basics
    WHERE basics.tconst = episode.tconst
    );

DELETE FROM episode episode
    WHERE NOT EXISTS (
    SELECT FROM basics basics
    WHERE basics.tconst = episode.parenttconst
    );


-- rating

DELETE FROM rating rating
    WHERE NOT EXISTS (
    SELECT FROM basics basics
    WHERE basics.tconst = rating.tconst
    );

-- crew
DELETE FROM crew crew
    WHERE NOT EXISTS (
    SELECT FROM basics basics
    WHERE basics.tconst = crew.tconst
    );

--Adding foreign key

ALTER TABLE crew ADD CONSTRAINT crew_tconst_fkey FOREIGN KEY (tconst) REFERENCES basics(tconst);

ALTER TABLE principals ADD CONSTRAINT principals_tconst_fkey FOREIGN KEY (tconst) REFERENCES basics(tconst);
	
ALTER TABLE akas ADD CONSTRAINT akas_nconst_fkey FOREIGN KEY (titleid) REFERENCES basics(tconst);
	
ALTER TABLE episode ADD CONSTRAINT episode_tconst_fkey FOREIGN KEY (tconst) REFERENCES basics(tconst);

ALTER TABLE episode ADD CONSTRAINT episode_parenttconst_fkey FOREIGN KEY (parenttconst) REFERENCES basics(tconst);

ALTER TABLE rating ADD CONSTRAINT rating_tconst_fkey FOREIGN KEY (tconst) REFERENCES basics(tconst);

ALTER TABLE genres ADD CONSTRAINT genres_tconst_fkey FOREIGN KEY (tconst) REFERENCES basics(tconst);

ALTER TABLE workedas ADD CONSTRAINT workedas_tconst_fkey FOREIGN KEY (nconst) REFERENCES namebasics(nconst);

-- Indexing

-- Akas
CREATE INDEX akas_attributes_index ON akas(title_id);
-- Episode
CREATE INDEX ep_title_id_index ON episode(tconst);
CREATE INDEX parent_title_id_index ON episode(parenttconst);
-- workedas
CREATE INDEX workedas_attributes_index ON workedas(primaryprofession);
-- namebasics
CREATE INDEX namebasics_attributes_index ON namebasics(nconst);
-- principals
CREATE INDEX principals_index ON principals(tconst);
-- genres
CREATE INDEX genres_title_id_index ON genres(tconst);
CREATE INDEX genres_genre_index ON genres(genres);
-- rating
CREATE INDEX rating_index ON rating(tconst);
-- basics
CREATE INDEX basics_attributes_index ON basics(tconst);
-- crew
CREATE INDEX crew_attributes_index ON crew(tconst);


--- INDEX ANALYSIS on quries
--1
EXPLAIN SELECT * FROM topmovies;
--2
EXPLAIN SELECT * FROM cat;
--3
EXPLAIN (COSTS FALSE) SELECT * FROM Q3 WHERE episodenumber = 5;
