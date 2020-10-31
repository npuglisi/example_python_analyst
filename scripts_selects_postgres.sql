
select count(*) from players
select * from matchmaking_stats_summary
select * from player_monthly_stats

select p.*
from players p 
left join player_monthly_stats pm on pm.player_id = p.player_id
where pm.id is null
order by 2 desc

select cast(created_at as date), p.cadastrado_em
from matchmaking_stats_summary m
inner join players p on p.player_id = m.player_id

select p.player_id, cast(created_at as date), p.cadastrado_em, pm.*
from players p 
inner join player_monthly_stats pm on pm.player_id = p.player_id
left join matchmaking_stats_summary m on p.player_id = m.player_id
where m.id is null

select player_id, (cast(total_played as float)/60)/60 as hours, kills, deaths, cast(kills as float)/ cast(deaths as float) 
from player_monthly_stats 
where kills > 0 and deaths > 0 
order by 5 desc

select avg(cast(total_played as float)/3600)
from player_monthly_stats

select p.*
from player_monthly_stats p
left join matchmaking_stats_summary m on p.player_id = m.player_id
where m.id is null

select cast(p.total_played as float)/3600,wins+loss, cast(p.kills as float)/ cast(p.deaths as float) 
from player_monthly_stats p
left join matchmaking_stats_summary m on p.player_id = m.player_id
where m.id is null
group by 1,2,3
having (p.wins+p.loss) >= 8 and (cast(p.kills as float)/ cast(p.deaths as float) ) < 1
order by 1 asc

select cast(p.total_played as float)/3600 as hours,wins+loss as total_played, wins, loss
from player_monthly_stats p
left join matchmaking_stats_summary m on p.player_id = m.player_id
where m.id is null
group by 1,2,3,4
having (p.wins+p.loss) >= 8 and (p.wins-p.loss) < 0
order by 1 asc