-- ============================================
-- DAY 4 : LEFT JOIN 
-- Dataset : matches, deliveries
-- Goal    : Understand LEFT JOIN with IPL data
-- ============================================


-- Q1. Show ALL matches and their deliveries (if any)
-- Even if a match has no deliveries, it should appear

SELECT m.match_id,
       d.over
FROM matches m
LEFT JOIN deliveries d
  ON m.match_id = d.match_id;


-- Q2. Find matches that have NO deliveries
-- (abandoned / no play)

SELECT m.match_id
FROM matches m
LEFT JOIN deliveries d
  ON m.match_id = d.match_id
WHERE d.match_id IS NULL;


-- Q3. Count deliveries per match (including matches with zero deliveries)

SELECT m.match_id,
       COUNT(d.match_id) AS delivery_count
FROM matches m
LEFT JOIN deliveries d
  ON m.match_id = d.match_id
GROUP BY m.match_id;


-- Q4. Show all matches and wickets (if any)
-- If no wicket fell, match should still appear

SELECT m.match_id,
       d.is_player_dismissed
FROM matches m
LEFT JOIN deliveries d
  ON m.match_id = d.match_id
 AND d.is_player_dismissed IS NOT NULL;


-- Q5. Find matches where NO wicket fell

SELECT m.match_id
FROM matches m
LEFT JOIN deliveries d
  ON m.match_id = d.match_id
 AND d.is_player_dismissed IS NOT NULL
WHERE d.match_id IS NULL;


-- Q6. Show all teams and number of matches they won
-- Teams with zero wins must appear

SELECT t.team,
       COUNT(m.winner) AS wins
FROM (
    SELECT team1 AS team FROM matches
    UNION
    SELECT team2 FROM matches
) t
LEFT JOIN matches m
  ON t.team = m.winner
GROUP BY t.team;


-- Q7. Find teams that NEVER won a match

SELECT t.team
FROM (
    SELECT team1 AS team FROM matches
    UNION
    SELECT team2 FROM matches
) t
LEFT JOIN matches m
  ON t.team = m.winner
WHERE m.winner IS NULL;


-- Q8. Show total runs per match
-- If a match has no deliveries, show 0 runs

SELECT m.match_id,
       COALESCE(SUM(d.total_runs), 0) AS total_runs
FROM matches m
LEFT JOIN deliveries d
  ON m.match_id = d.match_id
GROUP BY m.match_id;
