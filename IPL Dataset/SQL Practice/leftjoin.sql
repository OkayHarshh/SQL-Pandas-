-- Show all matches and any delivery info--

SELECT M.ID , D.OVER 
FROM MATCHES M 
LEFT JOIN DELIVERIES D
ON M.ID = D.MATCH_ID


---Count deliveries per match (including zero)--

select m.id , count(d.match_id) as deliveries_count
from matches m 
left join deliveries d
on m.id = d.match_id
group by m.id
order by m.id


-- Find matches with zero deliveries--
select m.id
from matches m 
left join deliveries d
on m.id = d.match_id
where d.match_id is null

--Find matches with zero deliveries--
select m.id , d.player_dismissed
from matches m 
left join deliveries d
on m.id = d.match_id
and d.player_dismissed is not null



--Show all teams and how many matches they won (even if 0)

select t.team , count(m.winner) as wins
from (
select team1 as team from matches
union
select team2 from matches
)t
left join matches m on t.team = m.winner
group by t.team


-- teams that never won --

select t.team FROM (
  SELECT team1 AS team FROM matches
  UNION
  SELECT team2 FROM matches
) t
left join matches m on t.team = m.winner
where m.winner is null
