-- =========================================
-- DAY 1 : IPL SQL FUNDAMENTALS

-- =========================================


-- 1. Total matches played
SELECT COUNT(*) AS total_matches
FROM matches;


-- 2. Total number of seasons
SELECT COUNT(DISTINCT season) AS total_seasons
FROM matches;


-- 3. Matches played per season
SELECT season,
       COUNT(*) AS matches
FROM matches
GROUP BY season
ORDER BY season;


-- 4. Total distinct venues
SELECT COUNT(DISTINCT venue) AS venues
FROM matches;


-- 5. Total runs scored in IPL
SELECT SUM(total_runs) AS total_runs
FROM deliveries;


-- 6. Total wickets fallen
-- Wicket = is_player_dismissed IS NOT NULL
SELECT COUNT(*) AS total_wickets
FROM deliveries
WHERE is_player_dismissed IS NOT NULL;


-- 7. Runs per innings
SELECT inning,
       SUM(total_runs) AS runs
FROM deliveries
GROUP BY inning
ORDER BY inning;


-- 8. Number of no-result / abandoned matches
SELECT COUNT(*) AS no_result_matches
FROM matches
WHERE winner IS NULL;


-- 9. Matches played per city
SELECT city,
       COUNT(*) AS matches
FROM matches
WHERE city IS NOT NULL
GROUP BY city
ORDER BY matches DESC;


-- 10. Highest team total in a single match
SELECT match_id,
       batting_team,
       SUM(total_runs) AS runs
FROM deliveries
GROUP BY match_id, batting_team
ORDER BY runs DESC
LIMIT 1;
