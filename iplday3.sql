-- 🏏 DAY 4 – String Functions + ALTER Table (IPL Dataset)

----------------------------------------------------
-- 🔹 Part A: String Functions (5 Questions)
----------------------------------------------------

-- Q1. Show all unique team names in UPPERCASE
SELECT DISTINCT UPPER(team1) AS team_name
FROM matches;

-- Q2. Show first 3 letters of each city name
SELECT DISTINCT SUBSTRING(city, 1, 3) AS city_prefix
FROM matches;

-- Q3. Replace the word "Super" with "S" in all team names
SELECT DISTINCT REPLACE(team1, 'Super', 'S') AS short_name
FROM matches;

-- Q4. Concatenate team1 and team2 as “Matchup”
SELECT CONCAT(team1, ' vs ', team2) AS matchup
FROM matches
LIMIT 10;

-- Q5. Show batsman names in lowercase
SELECT DISTINCT LOWER(batsman) AS player
FROM deliveries
LIMIT 10;

----------------------------------------------------
-- 🔹 Part B: ALTER Table (5 Questions)
----------------------------------------------------

-- Q6. Add a column match_type to matches table
ALTER TABLE matches
ADD COLUMN match_type VARCHAR(20);

-- Q7. Rename column city to match_city
ALTER TABLE matches
RENAME COLUMN city TO match_city;

-- Q8. Increase column length of venue to 200 chars
ALTER TABLE matches
ALTER COLUMN venue TYPE VARCHAR(200);

-- Q9. Drop the result_margin column
ALTER TABLE matches
DROP COLUMN result_margin;

-- Q10. Create a copy of matches table called matches_backup
CREATE TABLE matches_backup AS
SELECT * FROM matches;
