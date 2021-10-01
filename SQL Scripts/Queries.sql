--- Queries
-- Q1
-- Average Rating ane number of votes per year 
SELECT DISTINCT n1.startyear, ROUND(AVG(n1.averagerating),2) as averagescore, sum(n1.numvotes) as numberofvotes
FROM (SELECT t1.startyear, t1.isadult, t2.averagerating, t2.numvotes from basics as t1
      LEFT OUTER JOIN rating as t2
        ON t1.tconst = t2.tconst) n1
WHERE n1.startyear<=2021 and isadult='False'
GROUP BY n1.startyear;

--Q2
-- What are the top 100 movies as determined by the average rating, released year with
--the over 200,000 votes?
CREATE OR REPLACE VIEW topmovies(tconst,primarytitle,startyear,averagerating)
AS SELECT B.tconst, B.primarytitle, B.startyear, R.averagerating
FROM basics AS B, rating AS R
WHERE B.tconst = R.tconst
AND B.titletype = 'movie'
AND R.numvotes > 200000
ORDER BY R.averagerating DESC
LIMIT 100;

SELECT * FROM topmovies LIMIT 10;

--Q3
-- What were the seasons, episodes number, episodes name of Friends with their average rating?
CREATE OR REPLACE VIEW Q3(seasonnumber,episodenumber,primarytitle,averagerating)
AS SELECT E.seasonnumber, E.episodenumber, T2.primarytitle, R.averagerating
FROM basics AS T1, basics AS T2, episode AS E, rating AS R
WHERE T1.primarytitle = 'Friends'
AND T1.titletype = 'tvSeries'
AND T1.tconst = E.parenttconst
AND T2.titletype = 'tvEpisode'
AND T2.tconst = E.tconst
AND T2.tconst = R.tconst
ORDER BY E.seasonnumber, E.episodenumber;

SELECT * FROM Q3;

-- Q4
-- What was the most popular episode of Friends?
CREATE OR REPLACE VIEW Q4(seasonnumber,episodenumber,primarytitle,averagerating)
AS SELECT Q3.seasonnumber, Q3.episodenumber, Q3.primarytitle, Q3.averagerating
FROM Q3
WHERE Q3.averagerating = (SELECT MAX(Q3.averagerating) FROM Q3);

SELECT * FROM Q4;

--Q5
--Average score of each seasons of friends
select seasonnumber, avg(averagerating) from Q3
group by seasonnumber

-- Q6
-- How many professions are there in the database?
SELECT * FROM principals;
CREATE OR REPLACE VIEW cat(category,count1)
AS SELECT category, COUNT(*) AS count_d FROM principals 
GROUP BY category ORDER BY count_d DESC;
SELECT * FROM cat;
	
