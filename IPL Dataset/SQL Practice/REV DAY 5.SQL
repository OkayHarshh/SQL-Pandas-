-- TEAM PLAYED BUT NEVER WON --

SELECT DISTINCT T.TEAM 
FROM (
SELECT TEAM1 AS TEAM FROM MATCHES 
UNION
SELECT TEAM2 FROM MATCHES
)T 
LEFT JOIN MATCHES M
ON T.TEAM = M.WINNER
WHERE M.WINNER IS NULL;


----BOWLERS NEVER TOOK WICKET---

SELECT DISTINCT D.BOWLER
FROM DELIVERIES D
LEFT JOIN DELIVERIES W
ON D.BOWLER = W.BOWLER
AND W.PLAYER_DISMISSED IS NOT NULL

WHERE W.BOWLER IS NULL



-- TEAM THAT PLAYED BUT NEVER WON --

SELECT DISTINCT T.TEAM
FROM (
SELECT TEAM1 AS TEAM FROM MATCHES WHERE SEASON = 'IPL-2019'
UNION
SELECT TEAM2 FROM MATCHES WHERE SEASON='IPL-2019'
)T
LEFT JOIN MATCHES M
ON T.TEAM = M.WINNER
AND M.SEASON = 'IPL-2019'
WHERE M.WINNER IS NULL;


--CITY HOSTED MATCHES BUT NEVER A FINAL --

Select distinct m.city
from matches m
left join 
(
select season , max(id) as final_match
from matches
group by season

)f 

on m.id = f.final_match
where f.final_match is null
and m.city is not null;

--Matches where no wicket fell--

select m.id from matches m
left join deliveries d 
on m.id = d.match_id
and d.player_dismissed is not null
where d.match_id is null

--VENUUE WWHERE NO 200 SCORE --

SELECT DISTINCT m.venue
FROM matches m
LEFT JOIN (
    SELECT d.match_id
    FROM deliveries d
    GROUP BY d.match_id, d.batting_team
    HAVING SUM(d.total_runs) >= 200
) big_scores
  ON m.id = big_scores.match_id
WHERE big_scores.match_id IS NULL;
