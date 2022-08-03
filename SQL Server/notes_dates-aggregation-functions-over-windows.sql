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

--RANGE-AND-ROWS--------------------------------------------------------------------------
__________________________________________________________________________________________

--When creating window functions we have two options: 'RANGE' and 'ROWS'.

--RANGE - specify a range of results
	- 'duplicates' processsed all at once
	- only supports UNBOUNDED and CURRENT ROW

--ROWS  - specify number of rows to include
	- 'duplictes' processed a row at a time
	- supports UNBOUNDED, CURRENT ROW and number of rows


--RUNNING-TOTALS-AND-MOVING-AVERAGES------------------------------------------------------
__________________________________________________________________________________________

--Running-totals--------------------------------------------------------------------------

SELECT
	Team,
	Game,
	RunsScored,
	SUM(RunsScored) OVER(
		PARTITION BY Team
		ORDER BY Game ASC
		RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS TotalRuns
FROM Scores


--Moving-averages-------------------------------------------------------------------------

SELECT
	Team,
	Game,
	RunsScored,
	AVG(RunsScored) OVER(
		PARTITION BY Team
		ORDER BY Game ASC
		ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
	) AS AvgRuns
FROM Scores

--Remember that there is no functionality in T-SQL like 'RANGE BETWEEN 6 DAYS AND CURRENT
--ROW'. Instead, we need to use 'ROWS BETWEEN 6 PRECEDING AND CURRENT ROW'. This assumes
--we have a row for each date. If not, we need to use a calendar table, start from there
--and LEFT JOIN our table. This will fill in missing days with 0 values.


--LAG-AND-LEAD----------------------------------------------------------------------------
__________________________________________________________________________________________

--LAG-------------------------------------------------------------------------------------

--Gives a prior row in a window given a particular partition strategy and ordering.

SELECT
	CustomerID,
	MonthStartDate,
	LAG(NumberOfVisits) OVER(
		PARTITION BY CustomerID
		ORDER BY MonthStartDate
	) AS Prior,
	NumberOfVisits
FROM DaySpaRollup

--|-CustomerID-|-MonthStartDate-|-Prior-|-NumberOfVisits-|
--|------------|----------------|-------|----------------|
--| 1          | 2018-12-01     | NULL  | 49             |
--| 1          | 2019-01-01     | 49    | 117            |
--| 1          | 2019-02-01     | 117   | 104            |
--|------------|----------------|-------|----------------|


--LEAD------------------------------------------------------------------------------------

--Works like LAG except that it looks at the next record instead of the prior record.


--Specifying-number-of-rows-back----------------------------------------------------------

--LAG and LEAD take an optional parameter which represents the number of rows back to 
--look.

SELECT
	CustomerID,
	MonthStartDate,
	LAG(NumberOfVisits, 2) OVER(PARTITION BY CustomerID ORDER BY MonthStartDate
	) AS Prior2,
	LAG(NumberOfVisits, 1) OVER(PARTITION BY CustomerID ORDER BY MonthStartDate
	) AS Prior1D,
	NumberOfVisits
FROM DaySpaRollup

--In the case above we would have information about previous-previous-month, previous-
--month and current month.


--LAG-and-LEAD-vs-WHERE-------------------------------------------------------------------

--Note that LAG and LEAD execute AFTER the WHERE clause, so when we make filters using
--WHERE there is a risk, we'll get some unexpected NULL values (because some rows were
--already excluded).

--Solution
--Create a CTE with LAD/LEAD on the entire dataset.
--Reference that CTE in the main query and filter with WHERE.


--Days-between-values---------------------------------------------------------------------

--We do not always have datapoints (i.e. queried values like 'incidents' or 'visits') on
--each day of the week, so calling LAG or LEAD the 'prior day' is misleading. Those are
--really prior periods. One way of dealing with this is using a calendar table (see
--a note within Moving-averages section). However, sometimes we might want to have
--information regarding the number of days/weeks etc. between datapoints instead. This can
--be achieved by combining DATEDIFF with LAG and LEAD.
