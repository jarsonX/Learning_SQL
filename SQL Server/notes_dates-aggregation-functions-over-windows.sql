--RANKING-FUNCTIONS---------------------------------------------------------------------------------
____________________________________________________________________________________________________

--Sometimes we would like to see the end results of aggregation without changing the grain of our
--data (i.e. without downsampling or upsampling). That's why window function are useful.

--Four window functions supported by MS SQL Server:

--ROW_NUMBER()    unique, ascending integer value starting from 1.
                  --example: 1, 2, 3, 4
--RANK()          ascending, starting from 1, however can have ties and thus skip numbers.
                  --example: 1, 2, 2, 4
--DENSE_RANK()    ascending, starting from 1 and also can have ties but does not skip numbers.
                  --example: 1, 2, 2, 3
--NTILE()

--Syntax
SELECT 
  column1,
  ROW_NUMBER() OVER(ORDER BY column1 DESC) AS rn
FROM tab
ORDER BY column1 DESC

--PARTITION-BY-clause
--A clause accepted by OVER() which splits up the window by some column or set of columns.

SELECT
  Team,
  RunsScored,
  ROW_NUMBER() OVER(PARTITION BY Team
                    ORDER BY RunsScored DESC) AS rn
FROM Scores
ORDER BY RunsScored DESC

--|--Team--|--RunsScored--|--rn--|
--|________|______________|______|
--|--AZ----|--8-----------|--1---|
--|--AZ----|--6-----------|--2---|
--|--AZ----|--3-----------|--3---|
--|--FLA---|--7-----------|--1---|
--|--FLA---|--7-----------|--2---|
--|--FLA---|--6-----------|--3---|


--AGGREGATE-FUNCTIONS-------------------------------------------------------------------------------
____________________________________________________________________________________________________

--In addition to ranking functions, we can also use windows on aggregate functions, like: AVG(),
--COUNT(), MAX(), MIN(), SUM() etc.

SELECT
  Team,
  RunsScored,
  MAX(RunsScored) OVER(PARTITION BY Team) AS MaxRuns
FROM Scores
ORDER BY RunsScored DESC
  
--|--Team--|--RunsScored--|--MaxRuns--|
--|________|______________|___________|
--|--AZ----|--8-----------|--8--------|
--|--AZ----|--6-----------|--8--------|
--|--AZ----|--3-----------|--8--------|
--|--FLA---|--7-----------|--7--------|
--|--FLA---|--7-----------|--7--------|
--|--FLA---|--6-----------|--7--------|

--An aggregate function with an empty OVER() clause does the same thing as the non-windowed aggregation
--function except for one difference: it does not require that we group by non-aggregated columns.

SELECT
  Team,
  RunsScored,
  MAX(RunsScored) OVER() AS MaxRuns
FROM Scores
ORDER BY RunsScored DESC

--|--Team--|--RunsScored--|--MaxRuns--|
--|________|______________|___________|
--|--AZ----|--8-----------|--8--------|
--|--AZ----|--6-----------|--8--------|
--|--AZ----|--3-----------|--8--------|
--|--FLA---|--7-----------|--8--------|
--|--FLA---|--7-----------|--8--------|
--|--FLA---|--6-----------|--8--------|
