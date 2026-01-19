-- =========================================
-- DAY 2 : FILTERING & AGGREGATION
--
-- =========================================


-- 1. Top 10 run scorers (overall)
SELECT batter,
       SUM(runs_batter) AS runs
FROM deliveries
GROUP BY batter
ORDER BY runs DESC
LIMIT 10;


-- 2. Top 10 wicket takers (excluding run-outs)
SELECT bowler,
       COUNT(*) AS wickets
FROM deliveries
WHERE is_player_dismissed IS NOT NULL
  AND dismissal_kind NOT IN ('run out', 'retired hurt')
GROUP BY bowler
ORDER BY wickets DESC
LIMIT 10;


-- 3. Average runs per match
SELECT
    SUM(total_runs) * 1.0 / COUNT(DISTINCT match_id) AS avg_runs_per_match
FROM deliveries;


-- 4. Most sixes hit by a batter
SELECT batter,
       COUNT(*) AS sixes
FROM deliveries
WHERE runs_batter = 6
GROUP BY batter
ORDER BY sixes DESC
LIMIT 1;


-- 5. Most fours hit by a batter
SELECT batter,
       COUNT(*) AS fours
FROM deliveries
WHERE runs_batter = 4
GROUP BY batter
ORDER BY fours DESC
LIMIT 1;


-- 6. Team scoring most runs in powerplay (overs 1–6)
SELECT batting_team,
       SUM(total_runs) AS powerplay_runs
FROM deliveries
WHERE over BETWEEN 1 AND 6
GROUP BY batting_team
ORDER BY powerplay_runs DESC
LIMIT 1;


-- 7. Team conceding most runs in death overs (16–20)
SELECT bowling_team,
       SUM(total_runs) AS runs_conceded
FROM deliveries
WHERE over BETWEEN 16 AND 20
GROUP BY bowling_team
ORDER BY runs_conceded DESC
LIMIT 1;


-- 8. Matches where a team scored 200+ runs
SELECT match_id,
       batting_team,
       SUM(total_runs) AS runs
FROM deliveries
GROUP BY match_id, batting_team
HAVING SUM(total_runs) >= 200
ORDER BY runs DESC;


-- 9. Batters who played at least 50 matches
SELECT batter,
       COUNT(DISTINCT match_id) AS matches
FROM deliveries
GROUP BY batter
HAVING COUNT(DISTINCT match_id) >= 50
ORDER BY matches DESC;


-- 10. Bowlers with economy < 7 (minimum 300 overs)
SELECT bowler,
       SUM(total_runs) * 6.0 / COUNT(*) AS economy
FROM deliveries
GROUP BY bowler
HAVING COUNT(*) >= 300 * 6
   AND SUM(total_runs) * 6.0 / COUNT(*) < 7
ORDER BY economy;
