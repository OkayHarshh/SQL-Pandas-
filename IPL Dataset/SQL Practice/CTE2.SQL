-- =========================================================
-- DAY 9 : MORE CTE PRACTICE
-- Dataset : matches, deliveries
-- Focus   : multi-step transformations using WITH
-- =========================================================


-- Q1. Total runs per match, then find top 5 highest scoring matches

WITH match_runs AS (
    SELECT match_id,
           SUM(total_runs) AS runs
    FROM deliveries
    GROUP BY match_id
)
SELECT *
FROM match_runs
ORDER BY runs DESC
LIMIT 5;



-- Q2. Find seasons where total runs exceed overall average season runs

WITH season_runs AS (
    SELECT m.season,
           SUM(d.total_runs) AS runs
    FROM matches m
    JOIN deliveries d
      ON m.match_id = d.match_id
    GROUP BY m.season
),
avg_season_runs AS (
    SELECT AVG(runs) AS avg_runs
    FROM season_runs
)
SELECT *
FROM season_runs
WHERE runs > (SELECT avg_runs FROM avg_season_runs);



-- Q3. Find batters top 10 run scorers

WITH batter_runs AS (
    SELECT batter,
           SUM(runs_batter) AS runs
    FROM deliveries
    GROUP BY batter
)
SELECT *
FROM batter_runs
ORDER BY runs DESC
LIMIT 10;



-- Q4. Find bowlers economy (runs conceded per over approx)

WITH bowler_runs AS (
    SELECT bowler,
           SUM(total_runs) AS runs
    FROM deliveries
    GROUP BY bowler
),
bowler_balls AS (
    SELECT bowler,
           COUNT(*) AS balls
    FROM deliveries
    GROUP BY bowler
),
economy AS (
    SELECT r.bowler,
           r.runs * 6.0 / b.balls AS economy
    FROM bowler_runs r
    JOIN bowler_balls b
      ON r.bowler = b.bowler
)
SELECT *
FROM economy
ORDER BY economy;



-- Q5. Find teams win percentage

WITH team_matches AS (
    SELECT team1 AS team FROM matches
    UNION ALL
    SELECT team2 FROM matches
),
match_count AS (
    SELECT team,
           COUNT(*) AS matches_played
    FROM team_matches
    GROUP BY team
),
team_wins AS (
    SELECT winner AS team,
           COUNT(*) AS wins
    FROM matches
    WHERE winner IS NOT NULL
    GROUP BY winner
)
SELECT m.team,
       matches_played,
       COALESCE(wins,0) AS wins,
       COALESCE(wins,0) * 100.0 / matches_played AS win_pct
FROM match_count m
LEFT JOIN team_wins w
  ON m.team = w.team;



-- Q6. Venue average match score

WITH match_runs AS (
    SELECT match_id,
           SUM(total_runs) AS runs
    FROM deliveries
    GROUP BY match_id
),
venue_scores AS (
    SELECT m.venue,
           r.runs
    FROM matches m
    JOIN match_runs r
      ON m.match_id = r.match_id
)
SELECT venue,
       AVG(runs) AS avg_score
FROM venue_scores
GROUP BY venue
ORDER BY avg_score DESC;



-- Q7. Find best season for batting (highest avg match score)

WITH match_runs AS (
    SELECT m.season,
           d.match_id,
           SUM(d.total_runs) AS runs
    FROM matches m
    JOIN deliveries d
      ON m.match_id = d.match_id
    GROUP BY m.season, d.match_id
),
season_avg AS (
    SELECT season,
           AVG(runs) AS avg_runs
    FROM match_runs
    GROUP BY season
)
SELECT *
FROM season_avg
ORDER BY avg_runs DESC
LIMIT 1;



-- Q8. Top wicket-taking bowlers

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
ORDER BY wickets DESC
LIMIT 10;



-- Q9. Matches with highest wicket count

WITH match_wickets AS (
    SELECT match_id,
           COUNT(*) AS wickets
    FROM deliveries
    WHERE is_player_dismissed IS NOT NULL
    GROUP BY match_id
)
SELECT *
FROM match_wickets
ORDER BY wickets DESC
LIMIT 5;



-- Q10. Season-wise total sixes

WITH season_sixes AS (
    SELECT m.season,
           COUNT(*) AS sixes
    FROM deliveries d
    JOIN matches m
      ON d.match_id = m.match_id
    WHERE runs_batter = 6
    GROUP BY m.season
)
SELECT *
FROM season_sixes
ORDER BY sixes DESC;
