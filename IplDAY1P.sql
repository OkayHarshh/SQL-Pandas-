--  PostgreSQL SQL Practice – Day 1
-- Dataset: IPL (matches / deliveries tables)
-- Focus: Basics (SELECT, WHERE, DISTINCT, BETWEEN, IN, IS NULL)

----------------------------------------------------
-- 1. Show all records from matches table
----------------------------------------------------
SELECT * FROM matches;

----------------------------------------------------
-- 2. Show only the id, season, and winner columns
----------------------------------------------------
SELECT id, season, winner
FROM matches;

----------------------------------------------------
-- 3. List all distinct seasons played
----------------------------------------------------
SELECT DISTINCT season
FROM matches;

----------------------------------------------------
-- 4. Get all matches played in season 2018
----------------------------------------------------
SELECT *
FROM matches
WHERE season = 2018;

----------------------------------------------------
-- 5. Show all matches where city is 'Delhi'
----------------------------------------------------
SELECT *
FROM matches
WHERE city = 'Delhi';

----------------------------------------------------
-- 6. Get matches where the toss winner is 'CSK'
----------------------------------------------------
SELECT *
FROM matches
WHERE toss_winner = 'Chennai Super Kings';

----------------------------------------------------
-- 7. Find matches played between 2016 and 2019
----------------------------------------------------
SELECT *
FROM matches
WHERE season BETWEEN 2016 AND 2019;

----------------------------------------------------
-- 8. Show matches where result was NOT 'normal'
----------------------------------------------------
SELECT *
FROM matches
WHERE result != 'normal';

----------------------------------------------------
-- 9. Find matches where winner is missing (NULL)
----------------------------------------------------
SELECT *
FROM matches
WHERE winner IS NULL;

----------------------------------------------------
-- 10. Show matches where team1 is either 'RCB' or 'MI'
----------------------------------------------------
SELECT *
FROM matches
WHERE team1 IN ('Royal Challengers Bangalore', 'Mumbai Indians');
