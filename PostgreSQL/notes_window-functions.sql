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
**/
--------------------------------------------------------------------------------------------EXAMPLES
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


