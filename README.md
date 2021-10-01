# Database-Management-Project
# IMDB-PostgreSQL

IMDb is the world's most popular and authoritative source for movie, TV and celebrity content.

# Data
For this project (mtp),we worked on the subsets of IMDb data available at datasets-imdbws. This data are publicly available and refreshed daily.

IMDb provides a detailed description of the files. In particular, you can access the following files:

- title.akas.tsv.gz\
- title.basics.tsv.gz\
- title.crew.tsv.gz\
- title.episode.tsv.gz\
- title.principals.tsv.gz\
- title.ratings.tsv.gz\
- name.basics.tsv.gz\
All these files are gzipped and in tsv (tab-separated-values) format.

# Tasks

1) Import the above tables into your localhost1 via SQL (psql, PgAdmin4) and/or python
2) Set appropriate data types and constraints2 per each column (n.b.: you may also modify columns with postgre built-in functions) -- use SQL only;
3) Propose at least 3 meaningful views (CREATE VIEW) leveraging on JOINs and/or Aggregations -- use SQL only;
4) Apply indexes to enhance the performance of your queries (use EXPLAIN ANALYZE to show performance improvements) -- use SQL only.

# Solution
Design a relational database and store the IMDb data in it.\
Model the database using an Entity-Relationship (ER) diagram.\
Performed normalisation and restructure the IMDb data using python.\
Created PostgreSQL database.\
Loaded data into the database.\
Added primary and foreign key constraints.\
Created database indexes.\
Asked questions of the IMDb data, so as to practice simple and more advanced SQL queries.
