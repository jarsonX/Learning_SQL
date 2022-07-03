The same problem resolved with: subqueries, correlated subqueries and CTEs.

------------------------------------------------------------------------------------------SUBQUERIES
----------------------------------------------------------------------------------------------------
SELECT
    m.date,
    -- Get the home and away team names
    home.hometeam,
    away.awayteam,
    m.home_goal,
    m.away_goal
FROM match AS m

-- Join the home subquery to the match table
LEFT JOIN (
  SELECT match.id, team.team_long_name AS hometeam
  FROM match
  LEFT JOIN team
  ON match.hometeam_id = team.team_api_id) AS home
ON home.id = m.id

-- Join the away subquery to the match table
LEFT JOIN (
  SELECT match.id, team.team_long_name AS awayteam
  FROM match
  LEFT JOIN team
  -- Get the away team ID in the subquery
  ON match.awayteam_id = team.team_api_id) AS away
ON away.id = m.id

-------------------------------------------------------------------------------CORRELATED-SUBQUERIES
----------------------------------------------------------------------------------------------------
SELECT
     m.date,
     
     (SELECT team_long_name
     FROM team AS t
     WHERE t.team_api_id = m.hometeam_id) AS hometeam,

     (SELECT team_long_name
     FROM team AS t
     WHERE t.team_api_id = m.awayteam_id) AS awayteam,

     home_goal,
     away_goal

FROM match AS m;

------------------------------------------------------------------------------------------------CTEs
----------------------------------------------------------------------------------------------------
WITH home AS (
  SELECT m.id, m.date, 
  	 t.team_long_name AS hometeam, m.home_goal
  FROM match AS m
  LEFT JOIN team AS t 
  ON m.hometeam_id = t.team_api_id),

away AS (
  SELECT m.id, m.date, 
  	 t.team_long_name AS awayteam, m.away_goal
  FROM match AS m
  LEFT JOIN team AS t 
  ON m.awayteam_id = t.team_api_id)

SELECT 
    home.date,
    home.hometeam,
    away.awayteam,
    home.home_goal,
    away.away_goal

FROM home
INNER JOIN away
ON home.id = away.id;
