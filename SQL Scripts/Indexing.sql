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


-- Index Analysis on quries 
--1
EXPLAIN SELECT * FROM topmovies;
--2
EXPLAIN SELECT * FROM cat;
--3
EXPLAIN (COSTS FALSE) SELECT * FROM Q3 WHERE episodenumber = 5;
