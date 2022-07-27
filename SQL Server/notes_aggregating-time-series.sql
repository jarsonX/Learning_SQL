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
