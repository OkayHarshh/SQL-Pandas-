

----------------------------------------------------
-- 1. Show the match_id, venue, and batting team for all deliveries
----------------------------------------------------
SELECT d.match_id, m.venue, d.batting_team
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 2. Get the bowler name with the venue of the match he bowled in
----------------------------------------------------
SELECT d.match_id, d.bowler, m.venue
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 3. List batsman and the city of the match in which they played
----------------------------------------------------
SELECT d.batsman, m.city
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 4. Show match_id, toss_winner, and bowling_team for each delivery
----------------------------------------------------
SELECT d.match_id, m.toss_winner, d.bowling_team
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 5. Find all deliveries with the corresponding winner of that match
----------------------------------------------------
SELECT d.match_id, d.batsman, d.total_runs, m.winner
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 6. Show match_id, umpire1, and batsman from deliveries
----------------------------------------------------
SELECT d.match_id, m.umpire1, d.batsman
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 7. Display match_id, team1, team2, and bowler from deliveries
----------------------------------------------------
SELECT d.match_id, m.team1, m.team2, d.bowler
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 8. Show match_id, venue, and total_runs for every delivery
----------------------------------------------------
SELECT d.match_id, m.venue, d.total_runs
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 9. Get batsman, bowler, and match winner for each delivery
----------------------------------------------------
SELECT d.batsman, d.bowler, m.winner
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;

----------------------------------------------------
-- 10. Show batting_team, city, and date for each delivery
----------------------------------------------------
SELECT d.batting_team, m.city, m.date
FROM deliveries d
INNER JOIN matches m ON d.match_id = m.match_id;
