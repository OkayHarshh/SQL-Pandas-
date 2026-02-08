-- ============================================================
-- DAY 6 : MORE SUBQUERIES PRACTICE
-- Dataset : matches, deliveries
-- Focus   : scalar, IN, correlated, nested subqueries
-- ============================================================


-- Q1. Find matches where total runs are LESS than overall average match runs

SELECT match_id,
       SUM(total_runs) AS match_runs
FROM deliveries
GROUP BY match_id
HAVING SUM(total_runs) <
(
    SELECT AVG(match_runs)
    FROM (
        SELECT SUM(total_runs) AS match_runs
        FROM deliveries
        GROUP BY match_id
    ) t
);


-- Q2. Find batters who scored runs in matches
-- that had more than 400 total runs

SELECT DISTINCT batter
FROM deliveries
WHERE match_id IN
(
    SELECT match_id
    FROM deliveries
    GROUP BY match_id
    HAVING SUM(total_runs) > 400
);


-- Q3. Find bowlers who bowled in FINAL matches
-- Assume final = highest match_id in each season

SELECT DISTINCT bowler
FROM deliveries
WHERE match_id IN
(
    SELECT MAX(match_id)
    FROM matches
    GROUP BY season
);


-- Q4. Find seasons where total runs are ABOVE overall average season runs

SELECT season,
       SUM(total_runs) AS season_runs
FROM matches m
JOIN deliveries d
  ON m.match_id = d.match_id
GROUP BY season
HAVING SUM(total_runs) >
(
    SELECT AVG(season_runs)
    FROM (
        SELECT m2.season,
               SUM(d2.total_runs) AS season_runs
        FROM matches m2
        JOIN deliveries d2
          ON m2.match_id = d2.match_id
        GROUP BY m2.season
    ) s
);


-- Q5. Find batters who NEVER scored a six
-- Using NOT IN subquery

SELECT DISTINCT batter
FROM deliveries
WHERE batter NOT IN
(
    SELECT batter
    FROM deliveries
    WHERE runs_batter = 6
);


-- Q6. Find matches where ANY batter scored 50+ runs

SELECT DISTINCT match_id
FROM deliveries
WHERE batter IN
(
    SELECT batter
    FROM deliveries
    GROUP BY match_id, batter
    HAVING SUM(runs_batter) >= 50
);


-- Q7. Find venues where matches had ABOVE average runs
-- compared to that venue's own average

SELECT venue, match_id, match_runs
FROM (
    SELECT m.venue,
           d.match_id,
           SUM(d.total_runs) AS match_runs
    FROM deliveries d
    JOIN matches m
      ON d.match_id = m.match_id
    GROUP BY m.venue, d.match_id
) x
WHERE match_runs >
(
    SELECT AVG(match_runs)
    FROM (
        SELECT m2.venue,
               d2.match_id,
               SUM(d2.total_runs) AS match_runs
        FROM deliveries d2
        JOIN matches m2
          ON d2.match_id = m2.match_id
        WHERE m2.venue = x.venue
        GROUP BY m2.venue, d2.match_id
    ) y
);


-- Q8. Find teams that won more matches than the team
-- with minimum wins

SELECT winner,
       COUNT(*) AS wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
HAVING COUNT(*) >
(
    SELECT MIN(win_count)
    FROM (
        SELECT COUNT(*) AS win_count
        FROM matches
        WHERE winner IS NOT NULL
        GROUP BY winner
    ) t
);


-- Q9. Find bowlers who conceded more runs than
-- average runs conceded per bowler

SELECT bowler,
       SUM(total_runs) AS runs_conceded
FROM deliveries
GROUP BY bowler
HAVING SUM(total_runs) >
(
    SELECT AVG(total_runs)
    FROM (
        SELECT SUM(total_runs) AS total_runs
        FROM deliveries
        GROUP BY bowler
    ) s
);


-- Q10. Find matches where runs were higher than
-- average runs in that SAME season (correlated subquery)

SELECT m.season,
       d.match_id,
       SUM(d.total_runs) AS match_runs
FROM deliveries d
JOIN matches m
  ON d.match_id = m.match_id
GROUP BY m.season, d.match_id
HAVING SUM(d.total_runs) >
(
    SELECT AVG(season_runs)
    FROM (
        SELECT m2.season,
               d2.match_id,
               SUM(d2.total_runs) AS season_runs
        FROM deliveries d2
        JOIN matches m2
          ON d2.match_id = m2.match_id
        GROUP BY m2.season, d2.match_id
    ) t
    WHERE t.season = m.season
);
