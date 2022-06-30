----------------------------------------------------------------------------------------INTRODUCTION
____________________________________________________________________________________________________
/**
What are window functions and why we need them?

SQL limitation of aggregate functions - you have to GROUP BY with all non-aggregate columns. Window
function allow to work around this!

Window functions perform calculations on an already generated result set (a window), so there is no
need to group data. They are also useful for calculating running totals, rankings and moving averages.

Window funcitons are processed after the whole query except ORDER BY. Therefore, the window function
uses the result set to calculate information, as opposed to using the database directly.

Note that window functions are not available in SQLite.
**/
-------------------------------------------------------------------------------------------FUNCTIONS
____________________________________________________________________________________________________

--How many goals were scored in each match in 2011/2012 and how did that compare to the average?

>> Subquery approach

SELECT
      date,
      (home_goal + away_goal) AS goals,
      (SELECT AVG(home_goal + away_goal)
          FROM match
          WHERE season = '2011/2012') AS overall_avg
FROM match
WHERE season = '2011/2012';
      
>> Window function approach
--The OVER() clause offers significant benefits over subqueries in select. Queries will run faster, 
--and the OVER() clause has a wide range of additional functions and clauses you can include with it.

SELECT
      date,
      (home_goal + away_goal) AS goals,
      AVG(home_goal + away_goal) OVER() AS overall_avg
FROM match
WHERE season = '2011/2012';

____________________________________________________________________________________________________
RANK function

--Generates a column numbering data set from highest to lowest (or vice versa).

--What is the rank of matches based on number of goals?

SELECT
      date,
      (home_goal + away_goal) AS goals
      RANK() OVER(ORDER BY home_goal + away_goal DESC) AS goals_rank
FROM match
WHERE season = '2011/2012';

____________________________________________________________________________________________________
PARTITION BY function

--Calculates separate values for different categories.
--Calculates different calculations in the same column.

--How many goals were scored in each match, and how did that compare to the season's average?

SELECT
      date,
      (home_goal + away_goal) AS goals,
      AVG(home_goal + away_goal) OVER(PARTITION BY season) AS season_avg
FROM match;      

--PARTITION BY can be used to calculate values broken out by multiple columns.

SELECT
      c.name,
      m.season,
      (home_goal + away_goal) AS goals,
      AVG(home_goal + away_goal) OVER(PARTITION BY m.season, c.name) AS season_country_avg
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id

____________________________________________________________________________________________________
SLIDING WINDOWS

--Perform calculations relative to the current row
--Can be used to calculate running totals, sums, averages etc.
--Can be partitioned by one or more columns

--Keywords:
ROWS BETWEEN <start> AND <finish>

PRECEDING               --number of rows before the current row 
FOLLOWING               --...after the current row
UNBOUNDED PRECEDING     --include every row since the beginning
UNBOUNDED FOLLOWING     --...since the end
CURRENT ROW             --stop at the current row

SELECT
      date,
      home_goal,
      away_goal,
      SUM(home_goal)
            OVER(ORDER BY date ROWS BETWEEN
                 UNBOUNDED PRECIDING AND CURRENT ROW) AS running_total
FROM match
WHERE home_team_id = 8456 AND season = '2011/2012';


