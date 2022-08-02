--BASIC-AGGREGATION-FUNCTIONS-----------------------------------------------------------------------
____________________________________________________________________________________________________

COUNT()
COUNT_BIG()           --like COUNT() but returns BIGINT (64-bit INTEGER)
COUNT(DISTINCT ...)
SUM()
MIN()
MAX()

--What-counts-with-COUNT----------------------------------------------------------------------------

COUNT(*)  --returns number of rows, including nulls
COUNT(Column)  --returns number of rows in Column where the value IS NOT NULL

COUNT(NULLIF(Column, 1990))  --set NULL if 1990 and count NOT NULL values in the column


--STATISTICAL-AGGREGATION-FUNCTIONS-----------------------------------------------------------------
____________________________________________________________________________________________________

AVG()
STDEV()  --standard deviation
STDEVP()  --population standard deviation (only if we're looking at the entire population)
VAR()  --variance
VARP()  --population variance

--There's no median function built-in SQL Server. However, we can use PERCENTILE_CONT(). It takes
--a parameter, which is percentile you'd like, e.g. we want 50th percentile or 'median'.

SELECT TOP(1)  --because PERCENTILE_CONT is a window function, it returns a row for each row sent in.
  PERCENTILE_CONT(0.5)
    WITHIN GROUP(ORDER BY SomeValue DESC)
    OVER() AS Median
FROM SomeTable

--Calculating median like above is very costly. You don't want to run it against large tables on
--a busy production server.


--DOWNSAMPLING--------------------------------------------------------------------------------------
____________________________________________________________________________________________________

--Changing data to a coarser grain (aggregating), e.g.: cast datetime type to a date type gives 
--daily data rather than a combination of date and time (uogólniamy dane dotyczące czasu). 
--Converting a DATETIME2 or DATETIME to a data type with just a date and NO time component, i.e. the
--DATE type is the simplest downsampling technique.

SELECT CAST(SomeDate AS DATE) AS SomeDate
FROM SomeTable

--Further downsampling, e.g. suppose we want the hour instead of day.

SELECT
  DATEADD(HOUR, DATEDIFF(HOUR, 0, SomeDate), 0) AS SomeDate  --time = SQL Server starting point
FROM SomeTable

--DATEDIFF(HOUR, 0, SomeDate) gives hours, e.g. 1,048,470, from time 0 to SomeDate.
--DATEADD(HOUR, 1048470, 0) 


--GROUPING-BY-ROLLUP,-CUBE-AND-GROUPING-SETS--------------------------------------------------------
____________________________________________________________________________________________________

--ROLLUP
--Works best with hierarchical data. Rollup takes each combination of the first column followed by
--matching value in the second column and so on, showing aggregates for each.

SELECT
  t.Month,
  t.Day,
  SUM(t.Events) AS Events
FROM Table_dates AS t
GROUP BY
  t.Month,
  t.Day
WITH ROLLUP
ORDER BY
  t.Month,
  t.Day
  
--Cartesian aggregation with CUBE
--Useful for cases where we want the full combination of all aggregations between columns. The
--problem is, it's probably gonna give us more results than we really need.

SELECT
  t.IncidentType,
  t.Office,
  SUM(t.Events) AS Events
FROM Table_events AS t
GROUP BY
  t.IncidentType,
  t.Office
WITH CUBE
ORDER BY
  t.IncidentyType,
  t.Office
  
--GROUPING SETS
--Similar to CUBE but enables to control the level of aggregation and allows to include any
--combination of aggregates we need.
  
--Here we define two grouping sets:
  
SELECT
  t.IncidentType,
  t.Office,
  SUM(t.Events) AS Events
FROM Table_events AS t
GROUP BY GROUPING SETS
(
  (t.IncidentType, t.Office),   -- Grouping I: combination of incident types and offices
  ()                            -- Grouping II: empty, just to give us the grand total
)
ORDER BY
  t.IncidentType,
  t.Office
 
