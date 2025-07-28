--  List all Marvel movies released after 2015.

SELECT * FROM marvel
WHERE year > 2015

-- Show DC movies with a box office collection greater than 500 crores.

SELECT * FROM dc
WHERE collection > 500

-- 3. List all directors of Marvel movies, without duplicates.

SELECT DISTINCT director FROM marvel;


--  Get top 5 highest-grossing DC movies (by box_office).

SELECT * FROM dc
ORDER BY box_office DESC
LIMIT 5;



--  List all Marvel movies with their verdicts.

SELECT m.title, m.director, mi.verdict
FROM marvel m
JOIN marvel_info mi ON m.movie_id = mi.movie_id;


-- Show DC movies along with their cinematographers.

SELECT d.title, d.director, di.cinematographer
FROM dc d
JOIN dc_info di ON d.movie_id = di.movie_id;


-- List Marvel movies directed by ‘Russo Brothers’ with their verdicts.


SELECT m.title, mi.verdict
FROM marvel m
JOIN marvel_info mi ON m.movie_id = mi.movie_id
WHERE m.director = 'Russo Brothers';




--  Get all movies (Marvel + DC) with title, director, verdict, and cinematographer.


-- Marvel part
SELECT m.title, m.director, mi.verdict, mi.cinematographer
FROM marvel m
JOIN marvel_info mi ON m.movie_id = mi.movie_id

UNION ALL

-- DC part
SELECT d.title, d.director, di.verdict, di.cinematographer
FROM dc d
JOIN dc_info di ON d.movie_id = di.movie_id;




-- Find total box office collection of all DC movies.


SELECT SUM(box_office) AS total_box_office
FROM dc;




--  Find how many movies each Marvel director has made.


SELECT director, COUNT(*) AS movie_count
FROM marvel
GROUP BY director;




-- Show average box office collection for Marvel movies by each verdict.

SELECT mi.verdict, AVG(m.box_office) AS avg_box_office
FROM marvel m
JOIN marvel_info mi ON m.movie_id = mi.movie_id
GROUP BY mi.verdict;


-- Find Marvel movies with box office greater than the average Marvel box office.


SELECT * FROM marvel
WHERE box_office > (
    SELECT AVG(box_office) FROM marvel
);


--  Get the title of the highest-grossing DC movie.

SELECT title FROM dc
WHERE box_office = (
    SELECT MAX(box_office) FROM dc
);


--  List all Marvel movies that have the same cinematographer as any DC movie.

SELECT m.title
FROM marvel m
JOIN marvel_info mi ON m.movie_id = mi.movie_id
WHERE mi.cinematographer IN (
    SELECT DISTINCT cinematographer FROM dc_info
);





-- . Find the cinematographer(s) who worked on both Marvel and DC movies


SELECT cinematographer
FROM marvel_info
WHERE cinematographer IN (
    SELECT cinematographer FROM dc_info
);


