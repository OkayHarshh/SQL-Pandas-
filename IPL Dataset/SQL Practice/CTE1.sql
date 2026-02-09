-- =========================================================
-- DAY 8 : CTE (WITH CLAUSE) PRACTICE
-- Dataset : matches, deliveries
-- Goal    : Replace subqueries with readable SQL
-- =========================================================


-- Q1. Total runs per match using CTE

WITH match_runs AS (
    SELECT match_id,
           SUM(total_runs) AS total_runs
    FROM deliveries
    GROUP BY match_id
)
SELECT *
FROM match_runs;



-- Q2. Find matches where runs are ABOVE average match runs

WITH match_runs AS (
    SELECT match_id,
           SUM(total_runs) AS total_runs
    FROM deliveries
    GROUP BY match_id
),
avg_runs AS (
    SELECT AVG(total_runs) AS avg_run
    FROM match_runs
)
SELECT *
FROM match_runs
WHERE total_runs > (SELECT avg_run FROM avg_runs);



-- Q3. Total runs scored per season

WITH season_runs AS (
    SELECT m.season,
           SUM(d.total_runs) AS runs
    FROM matches m
    JOIN deliveries d
      ON m.match_id = d.match_id
    GROUP BY m.season
)
SELECT *
FROM season_runs
ORDER BY runs DESC;



-- Q4. Highest scoring season

WITH season_runs AS (
    SELECT m.season,
           SUM(d.total_runs) AS runs
    FROM matches m
    JOIN deliveries d
      ON m.match_id = d.match_id
    GROUP BY m.season
)
SELECT *
FROM season_runs
ORDER BY runs DESC
LIMIT 1;



-- Q5. Batters total runs using CTE

WITH batter_runs AS (
    SELECT batter,
           SUM(runs_batter) AS runs
    FROM deliveries
    GROUP BY batter
)
SELECT *
FROM batter_runs
ORDER BY runs DESC;



-- Q6. Batters who scored ABOVE average batter runs

WITH batter_runs AS (
    SELECT batter,
           SUM(runs_batter) AS runs
    FROM deliveries
    GROUP BY batter
),
avg_batter_runs AS (
    SELECT AVG(runs) AS avg_runs
    FROM batter_runs
)
SELECT *
FROM batter_runs
WHERE runs > (SELECT avg_runs FROM avg_batter_runs);



-- Q7. Bowlers wickets using CTE
-- Exclude run out & retired hurt

WITH bowler_wickets AS (
    SELECT bowler,
           COUNT(*) AS wickets
    FROM deliveries
    WHERE is_player_dismissed IS NOT NULL
      AND dismissal_kind NOT IN ('run out', 'retired hurt')
    GROUP BY bowler
)
SELECT *
FROM bowler_wickets
ORDER BY wickets DESC;



-- Q8. Matches with above-average wickets

WITH wickets_per_match AS (
    SELECT match_id,
           COUNT(*) AS wickets
    FROM deliveries
    WHERE is_player_dismissed IS NOT NULL
    GROUP BY match_id
),
avg_wickets AS (
    SELECT AVG(wickets) AS avg_w
    FROM wickets_per_match
)
SELECT *
FROM wickets_per_match
WHERE wickets > (SELECT avg_w FROM avg_wickets);



-- Q9. Total runs per venue using CTE

WITH venue_runs AS (
    SELECT m.venue,
           SUM(d.total_runs) AS runs
    FROM matches m
    JOIN deliveries d
      ON m.match_id = d.match_id
    GROUP BY m.venue
)
SELECT *
FROM venue_runs
ORDER BY runs DESC;



-- Q10. Find venues where runs are ABOVE average venue runs

WITH venue_runs AS (
    SELECT m.venue,
           SUM(d.total_runs) AS runs
    FROM matches m
    JOIN deliveries d
      ON m.match_id = d.match_id
    GROUP BY m.venue
),
avg_runs AS (
    SELECT AVG(runs) AS avg_r
    FROM venue_runs
)
SELECT *
FROM venue_runs
WHERE runs > (SELECT avg_r FROM avg_runs);
