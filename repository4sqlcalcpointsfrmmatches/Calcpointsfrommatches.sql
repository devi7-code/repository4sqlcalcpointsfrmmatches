drop table teams;
drop table matches;

create table teams
(team_id integer not null,
team_name varchar(30) not null,
unique(team_id)
);

insert into teams (
   team_id
 , team_name
)
values
(  10 , 'Give'),
(  20 , 'Never'),
(  30 ,  'You' ),
(  40 ,  'up'  ),
(  50 ,  'Gonna');



create table matches 
(match_id integer not null,
host_team integer not null,
guest_team integer not null,
host_goals integer not null,
guest_goals integer not null,
unique(match_id)
);

insert into matches (
   match_id
 , host_team
 , guest_team
 , host_goals
 , guest_goals
)
values
(  1 , 30 , 20 , 1 , 0 ),
(  2 , 10 , 20 , 1 , 2 ),
(  3 , 20 , 50 , 2 , 2 ),
(  4 , 10 , 30 , 1 , 0 ),
(  6 , 30 , 50 , 0 , 1 );
  
SELECT SET1.team_id,SET1.team_name,CASE WHEN SET2.points IS NULL THEN 0 ELSE SET2.points END AS num_points FROM
(select team_id,team_name from teams ) AS SET1 LEFT JOIN

(SELECT team_id,sum(victory) AS points from(
SELECT
   
    host_team  AS team_id,
    
    SUM(CASE WHEN host_goals > guest_goals THEN 3 WHEN host_goals = guest_goals THEN 1 ELSE 0 END) AS victory
FROM
    matches GROUP BY team_id

UNION ALL

SELECT
    
    guest_team  AS team_id,
  
    SUM(CASE WHEN guest_goals > host_goals THEN 3 WHEN guest_goals = host_goals THEN 1 ELSE 0 END) AS victory
    
    FROM

    matches GROUP BY team_id) AS ENDDATA GROUP BY team_id ) AS SET2 ON SET1.team_id=SET2.team_id order by points desc;


