____________________________________________________________________________________________________
COMMON TABLE EXPRESSIONS

If you find yourself listing multiple subqueries in the FROM clause with nested statement, your 
query will likely become long, complex, and difficult to read. Since many queries are written with 
the intention of being saved and re-run in the future, proper organization is key to a seamless 
workflow. Arranging subqueries as CTEs will save you time, space, and confusion in the long run!

--CTE
WITH match_list AS (
    SELECT 
  		country_id,
  	   (home_goal + away_goal) AS goals
    FROM match
    WHERE season = '2013/2014' AND EXTRACT(MONTH FROM date) = '08'))

SELECT 
	name,
    AVG(goals)
FROM league AS l
LEFT JOIN match_list ON l.id = match_list.country_id
GROUP BY l.name;
