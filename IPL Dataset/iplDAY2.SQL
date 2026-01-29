-- 🏏 PostgreSQL Practice – Day 3: Grouping & Joins

-- 1. Find how many matches were played in each season
SELECT season, COUNT(*) AS total_matches
FROM matches
GROUP BY season
ORDER BY season;

-- 2. Find how many matches each team has won
SELECT winner, COUNT(*) AS wins
FROM matches
GROUP BY winner
ORDER BY wins DESC;

-- 3. Find cities that have hosted more than 30 matches
SELECT city, COUNT(*) AS matches_hosted
FROM matches
GROUP BY city
HAVING COUNT(*) > 30
ORDER BY matches_hosted DESC;

-- 4. Find batsmen with more than 2000 total runs
SELECT batsman, SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY batsman
HAVING SUM(batsman_runs) > 2000
ORDER BY total_runs DESC;

-- 5. Find bowlers who have bowled more than 3000 balls
SELECT bowler, COUNT(*) AS balls_bowled
FROM deliveries
GROUP BY bowler
HAVING COUNT(*) > 3000
ORDER BY balls_bowled DESC;

-- 6. Find number of matches won by each team in each season
SELECT season, winner, COUNT(*) AS wins
FROM matches
GROUP BY season, winner
ORDER BY season, wins DESC;

-- 7. Find matches where toss winner also won the match
SELECT *
FROM matches
WHERE toss_winner = winner;

-- 8. Find number of sixes hit by each batsman
SELECT batsman, COUNT(*) AS sixes
FROM deliveries
WHERE batsman_runs = 6
GROUP BY batsman
ORDER BY sixes DESC
LIMIT 10;

-- 9. Season-wise total runs scored (using JOIN)
SELECT m.season, SUM(d.total_runs) AS season_runs
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.season
ORDER BY m.season;

-- 10. Top 5 batsmen by runs in 2016 season (using JOIN)
SELECT d.batsman, SUM(d.batsman_runs) AS runs
FROM deliveries d
JOIN matches m ON d.match_id = m.id
WHERE m.season = 2016
GROUP BY d.batsman
ORDER BY runs DESC
LIMIT 5;
