-- =================================================
-- DAY 5 : SUBQUERIES (BASIC → COMFORT)
-- Dataset : matches, deliveries
-- Goal    : Learn how subqueries THINK
-- =================================================


-- Q1. Find total runs scored in IPL
-- (simple baseline, no subquery yet)

SELECT SUM(total_runs) AS total_runs
FROM deliveries;


-- Q2. Find matches where total runs were ABOVE average runs per match
-- (Subquery in WHERE)

SELECT match_id,
       SUM(total_runs) AS match_runs
FROM deliveries
GROUP BY match_id
HAVING SUM(total_runs) >
(
    SELECT AVG(match_runs)
    FROM (
        SELECT SUM(total_runs) AS match_runs
        FROM deliveries
        GROUP BY match_id
    ) x
);


-- Q3. Find batters who scored MORE than average runs of all batters

SELECT batter,
       SUM(runs_batter) AS runs
FROM deliveries
GROUP BY batter
HAVING SUM(runs_batter) >
(
    SELECT AVG(runs)
    FROM (
        SELECT SUM(runs_batter) AS runs
        FROM deliveries
        GROUP BY batter
    ) t
);


-- Q4. Find the highest run scorer overall
-- (Subquery in HAVING)

SELECT batter,
       SUM(runs_batter) AS runs
FROM deliveries
GROUP BY batter
HAVING SUM(runs_batter) =
(
    SELECT MAX(total_runs)
    FROM (
        SELECT SUM(runs_batter) AS total_runs
        FROM deliveries
        GROUP BY batter
    ) s
);


-- Q5. Find matches played in the season with MOST matches

SELECT *
FROM matches
WHERE season =
(
    SELECT season
    FROM matches
    GROUP BY season
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- Q6. Find teams that won MORE matches than the average wins per team

SELECT winner,
       COUNT(*) AS wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
HAVING COUNT(*) >
(
    SELECT AVG(team_wins)
    FROM (
        SELECT COUNT(*) AS team_wins
        FROM matches
        WHERE winner IS NOT NULL
        GROUP BY winner
    ) w
);


-- Q7. Find bowlers who took MORE wickets than average bowler wickets
-- Wicket = is_player_dismissed IS NOT NULL (excluding run out)

SELECT bowler,
       COUNT(*) AS wickets
FROM deliveries
WHERE is_player_dismissed IS NOT NULL
  AND dismissal_kind NOT IN ('run out', 'retired hurt')
GROUP BY bowler
HAVING COUNT(*) >
(
    SELECT AVG(wicket_count)
    FROM (
        SELECT COUNT(*) AS wicket_count
        FROM deliveries
        WHERE is_player_dismissed IS NOT NULL
          AND dismissal_kind NOT IN ('run out', 'retired hurt')
        GROUP BY bowler
    ) t
);


-- Q8. Find venues where average match score is ABOVE overall average match score

SELECT m.venue,
       AVG(match_runs) AS avg_runs
FROM (
    SELECT match_id,
           SUM(total_runs) AS match_runs
    FROM deliveries
    GROUP BY match_id
) d
JOIN matches m
  ON d.match_id = m.match_id
GROUP BY m.venue
HAVING AVG(match_runs) >
(
    SELECT AVG(match_runs)
    FROM (
        SELECT SUM(total_runs) AS match_runs
        FROM deliveries
        GROUP BY match_id
    ) x
);


-- Q9. Find batters who scored MORE runs than Virat Kohli
-- (scalar subquery)

SELECT batter,
       SUM(runs_batter) AS runs
FROM deliveries
GROUP BY batter
HAVING SUM(runs_batter) >
(
    SELECT SUM(runs_batter)
    FROM deliveries
    WHERE batter = 'Virat Kohli'
);


-- Q10. Find matches where total runs are GREATER than
-- average runs of that SAME season

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
    ) s
    WHERE s.season = m.season
);
