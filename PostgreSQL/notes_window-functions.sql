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
RANKING function

>> RANK()
--Generates a column numbering data set from highest to lowest (or vice versa). Assigns the same
--number to rows with identical values, skipping over the next numbers in such cases.

--What is the rank of matches based on number of goals?

SELECT
      date,
      (home_goal + away_goal) AS goals
      RANK() OVER(ORDER BY home_goal + away_goal DESC) AS goals_rank
FROM match
WHERE season = '2011/2012';

>> Other ranking functions
ROW_NUMBER() --always assings unique numbers, even for duplicates
DENSE_RANK() --works similarily to RANK() but doesn't skip over the next numbers
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
--Can be used to calculate running totals, sums, averages etc. (between any two points)
--Can be partitioned by one or more columns

--Keywords:
ROWS BETWEEN <start> AND <finish>

PRECEDING               --number of rows before the current row, e.g. 1 PRECEDING
FOLLOWING               --...after the current row
UNBOUNDED PRECEDING     --include every row since the beginning
UNBOUNDED FOLLOWING     --...since the end
CURRENT ROW             --stop at the current row

--Ascending order
SELECT
      date,
      home_goal,
      away_goal,
      SUM(home_goal)
            OVER(ORDER BY date ROWS BETWEEN
                 UNBOUNDED PRECIDING AND CURRENT ROW) AS running_total
FROM match
WHERE home_team_id = 8456 AND season = '2011/2012';

--Descending order
SELECT 
    date,
    home_goal,
    away_goal,
    SUM(home_goal) 
            OVER(ORDER BY date DESC ROWS BETWEEN 
                 CURRENT ROW AND UNBOUNDED FOLLOWING) AS running_total
FROM match
WHERE home_team_id = 8456 AND season = '2011/2012';

____________________________________________________________________________________________________
PAGING

--Splitting data into approximately equal chunks. Useful for splitting data into thirds or quartiles.

NTILE(n) --splits data into n approximately equal pages.

SELECT
  DISTINCT(event),
  NTILE(10) OVER (ORDER BY event ASC) AS Page
FROM Events
ORDER BY Event ASC;

____________________________________________________________________________________________________
AGGREGATE WINDOW FUNCTIONS

--window function for filtering
WITH Athlete_Medals AS (
  SELECT
    Athlete, COUNT(*) AS Medals
  FROM Summer_Medals
  GROUP BY Athlete)

--query
SELECT Year,
       Medals,
       SUM(Medals) OVER (ORDER BY Year ASC) AS Medals_count
FROM Athlete_medals

--Let's say we'd like to count medals per country:
SELECT Year,
       Country,
       Medals,
       SUM(Medals) OVER(PARTITION BY Country)
FROM Athlete_medals

____________________________________________________________________________________________________
FRAMES

--Frames allow you to restrict the rows passed as input to your window function to a sliding window 
--for you to define the start and finish.

--Example with LAST_VALUE function:

LAST_VALUE(City) OVER(
           ORDER BY Year ASC
           RANGE BETWEEN
                  UNBOUNDED PRECEDING AND
                  UNBOUNDED FOLLOWING
           ) AS Last_city
           
--Frame: RANGE BETWEEN ... . Without the frame, LAST_VALUE would return the row's value in the City
--column (so the City and Last_city columns would have the same value).

--By default, frame starts at the beginning of a table or partition and ends at the current row.

--Defining the frame - it always starts with RANGE BETWEEN or ROWS BETWEEN. It needs to have a start
--and a finish that can be set with one of three clauses: PRECEDDING, CURRENT ROW, FOLLOWING.

ROWS BETWEEN <start> AND <finish>
      n PRECEDING                   --e.g. ROWS BETWEEN 3 PRECEDING AND CURRENT ROW (4 rows)
      CURRENT ROW                   --     ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING (3 rows)
      n FOLLOWING                   --     ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING (5 rows)
      
____________________________________________________________________________________________________
AGGREGATE WINDOW FUNCTIONS AND FRAMES

--Moving averages (average of last n periods)
--Moving totals (sum of last n periods)

--Example

SELECT Year, 
       Medals,
       SUM(Medals) OVER(
            ORDER BY Year ASC
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Medals_MT
       FROM US_Medals  --assuming US_Medals is a CTE that counts US medals
       ORDER BY Year ASC;      

 
____________________________________________________________________________________________________
RANGE BETWEEN vs ROWS BETWEEN

--Difference: RANGE treats duplicates in the columns in ORDER BY subclause as single entities
--(summing them and displaying that sum for each duplicate), whereas ROWS does not.

____________________________________________________________________________________________________
PIVOTING

--Transforms a table by making columns out of the unique values of one of its columns. Useful when
--preparing data for visualization and reporting.

| Country | Year | Awards |               | Country | 2005 | 2012 |  --Pivoted by year
|---------|------|--------|               |---------|------|------|
| PL      | 2005 | 12     |               | PL      | 12   | 20   |
| PL      | 2012 | 20     |               

--CROSSTAB is a function that allows to pivot by a ceratin column. It needs to be preceded by
--CREATE EXTENSION statement. CREATE EXTENSION make extra functions available for use, e.g.
--tablefunc extension allows CROSSTAB.

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM CROSSTAB($$
      source_sql TEXT $$) AS ct                 
                          (column_1 DATA_TYPE_1,
                           ...
                           column_N DATA_TYPE_N);

____________________________________________________________________________________________________
OTHER USEFUL FUNCTIONS

LAG(column, n) --returns column's value at n rows before the current row
LEAD(column, n)
FIRST_VALUE(column)
LAST_VALUE(column)
