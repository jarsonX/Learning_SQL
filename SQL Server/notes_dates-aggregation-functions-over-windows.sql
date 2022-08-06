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

SELECT
	ir.IncidentDate,
	ir.IncidentTypeID,
    -- Fill in the days since last incident
	DATEDIFF(DAY, LAG(ir.IncidentDate, 1) OVER (
		PARTITION BY ir.IncidentTypeID
		ORDER BY ir.IncidentDate
	), ir.IncidentDate) AS DaysSinceLastIncident,
    -- Fill in the days until next incident
	DATEDIFF(DAY, ir.IncidentDate, LEAD(ir.IncidentDate, 1) OVER (
		PARTITION BY ir.IncidentTypeID
		ORDER BY ir.IncidentDate
	)) AS DaysUntilNextIncident
FROM dbo.IncidentRollup ir
WHERE
	ir.IncidentDate >= '2019-07-02'
	AND ir.IncidentDate <= '2019-07-31'
	AND ir.IncidentTypeID IN (1, 2)
ORDER BY
	ir.IncidentTypeID,
	ir.IncidentDate;
	
	
--FINDING-MAX-LEVELS-OF-OVERLAP-CASE------------------------------------------------------
__________________________________________________________________________________________

--Let's suppose we want to track a number of customers in a shop at a given time and check
--what is the max number of concurrent visitors. We have a table like this:

-- _____________________________________________________________
--| StartTime           | EndTime             | ProductsOrdered |
--|---------------------|---------------------|-----------------|
--| 2019-07-08 14:35:00 | 2019-07-08 16:01:00 |              13 |      
--| 2019-07-08 15:35:00 | 2019-07-08 17:01:00 |              13 | 
--| 2019-07-08 16:35:00 | 2019-07-08 18:01:00 |              17 | 
--| 2019-07-08 17:35:00 | 2019-07-08 19:01:00 |              15 | 
--| 2019-07-08 17:55:00 | 2019-07-08 17:57:00 |               1 | 
--| 2019-07-08 20:35:00 | 2019-07-08 22:01:00 |              13 | 
--| ...                 | ...                 |             ... |
--|---------------------|---------------------|-----------------|


--ALGORITHM-STEP-1------------------------------------------------------------------------

--Break up our start and end times into separate rows so that we have an event per
--entrance and an event per exit.
--Add 2 more columns: EntryCount and StartOrdinal. EntryCount helps us keep track of the
--number of people in the store at a given time and decrements whenever a person leaves.
--StartOrdinal gives us the order of entry, so it will be NULL for any exit.

SELECT
	StartTime AS TimeUTC,
	1 AS EntryCount,
	ROW_NUMBER() OVER(ORDER BY StartTime) AS StartOrdinal
FROM Orders

UNION ALL

SELECT
	EndTime AS TimeUTC,
	-1 AS EntryCount,
	NULL AS StartOrdinal
FROM Orders

--RESULT (dates were omitted)

--Starting points
-- ______________________________________
--| TimeUTC  | EntryCount | StartOrdinal |
--|----------|------------|--------------|
--| 14:35:00 |          1 |            1 |
--| 15:35:00 |          1 |            2 |
--| 16:35:00 |          1 |            3 |
--| 17:35:00 |          1 |            4 |
--| 17:55:00 |          1 |            5 |
--| 20:35:00 |          1 |            6 |
--| ...      |        ... |          ... |
--|----------|------------|--------------|

--Stopping points
-- ______________________________________
--| TimeUTC  | EntryCount | StartOrdinal |
--|----------|------------|--------------|
--| 16:01:00 |         -1 |         NULL |
--| 17:01:00 |         -1 |         NULL |
--| 18:01:00 |         -1 |         NULL |
--| 19:01:00 |         -1 |         NULL |
--| 17:57:00 |         -1 |         NULL |
--| 22:01:00 |         -1 |         NULL |
--| ...      |        ... |          ... |
--|----------|------------|--------------|

--The above represents the starting and stopping points for each customer visit.
--We put this in CTE called 'StartStopPoints'.


--ALGORITHM-STEP-2------------------------------------------------------------------------

--Another CTE 'StartStopOrder' below takes each of our start and end times in the first
--query and adds a new ordinal value arranging when people leave and enter. We order by
--time of entry (TimeUTC) and the by StartOrdinal. Ordering by StartOrdinal is important
--because we have exits marked as NULL values, so they will sort before the entrances.
--That way, if a person walks out the door exactly when another person walks in the door,
--we don't say there were two people in. We decrement the counter for the person leaving
--and then increment the counter for the person entering.
--StartOrEndOrdinal value gives us an ordering of the order in which people entered and
--left the store.

SELECT
	TimeUTC,
	EntryCount,
	StartOrdinal,
	ROW_NUMBER() OVER(ORDER BY TimeUTC, StartOrdinal) AS StartOrEndOrdinal
FROM StartStopPoints

--RESULT

-- __________________________________________________________
--| TimeUTC  | EntryCount | StartOrdinal | StartOrEndOrdinal | 
--|----------|------------|--------------|-------------------|
--| 14:35:00 |          1 |            1 |                 1 |
--| 15:35:00 |          1 |            2 |                 2 |
--| 16:01:00 |         -1 |         NULL |                 3 |
--| 16:35:00 |          1 |            3 |                 4 |
--| 17:01:00 |         -1 |         NULL |                 5 |
--| 17:35:00 |          1 |            4 |                 6 |
--| 17:55:00 |          1 |            5 |                 7 |
--| 17:57:00 |         -1 |         NULL |                 8 |
--| 18:01:00 |         -1 |         NULL |                 9 |
--| 19:01:00 |         -1 |         NULL |                10 |
--| 20:35:00 |          1 |            6 |                11 |
--| 22:01:00 |         -1 |         NULL |                12 |
--|----------|------------|--------------|-------------------|

--Now if we see positive entry counts start to outnumber negative entry counts, we have
--more people in the store.

--SOLUTION 1: BRUTE FORCE!
--We might be to sum EntryCount using a running total, e.g. after --row 6 we have 2 people 
--in the store (4 entrances - 2 exits = 2 people).

--SOLUTION 2: MORE EFFICIENT
--We have two StartOrEndOrdinal rows for every StartOrdinal row, so if we double the 
--StartOrdinal value and subtract it from the StartOrEndOrdinal, that leaves us with the
--number of people in the story at any given time.

-- __________________________________________________________________
--| TimeUTC  | StartOrdinal | StartOrEndOrdinal | Calc      | Result |
--|----------|--------------|-------------------|-----------|--------|
--| 14:35:00 |            1 |                 1 | (2*1) - 1 | 1      |
--| 15:35:00 |            2 |                 2 | (2*2) - 2 | 2      |
--| 16:01:00 |         NULL |                 3 | NULL      | NULL   |
--| 16:35:00 |            3 |                 4 | (2*3) - 4 | 2      |
--| 17:01:00 |         NULL |                 5 | NULL      | NULL   |
--| 17:35:00 |            4 |                 6 | (2*4) - 6 | 2      |
--| ...      |          ... |               ... | ...       | ...    |
--|----------|--------------|-------------------|-----------|--------|

--Putting this into SQL, we get back our final total of 3 concurrent visitors.

SELECT
	MAX(2 * StartOrdinal - StartOrEndOrdinal) AS MaxCouncurrentVisitors
FROM StartStopOrder
WHERE EntryCount = 1

-- _______________________
--| MaxConcurrentVisitors |
--|-----------------------|
--|                     3 |
--|-----------------------|	
