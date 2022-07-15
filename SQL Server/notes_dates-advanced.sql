TIME SERIES IN T-SQL

__________________________________________________________________________________________
ROUND DATES-------------------------------------------------------------------------------

DECLARE
	@SomeTime DATETIME2(7) = '2018-06-14 16:29:36.2248991';

SELECT
	DATEADD(YEAR, DATEDIFF(YEAR, 0, @SomeTime), 0)
	DATEADD(DAY, DATEDIFF(DAY, 0, @SomeTime), 0) AS RoundedToDay,
	DATEADD(HOUR, DATEDIFF(HOUR, 0, @SomeTime), 0) AS RoundedToHour,
	DATEADD(MINUTE, DATEDIFF(MINUTE, 0, @SomeTime), 0) AS RoundedToMinute;

__________________________________________________________________________________________
FORMATTING-DATES--------------------------------------------------------------------------

CAST()------------------------------------------------------------------------------------

--Converts one data type to another, including dates. However, we have no control over
--formatting from dates to strings. Available in most SQL versions. Uses ANSI standard.

CAST(input AS type)

--Examples

DECLARE
	@SomeDate DATETIME2(3) = '1991-06-04 08:00:09',
	@SomeString NVARCHAR(30) = '1991-06-04 08:00:09',
	@OldDateTime DATETIME = '1991-06-04 08:00:09';

SELECT
	CAST(@SomeDate AS NVARCHAR(30)) AS DateToString,
	CAST(@SomeString AS DATETIME2(3)) AS StringToDate,
	CAST(@OldDateTime AS NVARCHAR(30)) AS OldDateToString;


CONVERT()---------------------------------------------------------------------------------

--Converts one data type to another, including dates. Gives some control over formatting
--from dates to strings using the style parameter. Available only in T-SQL.

CONVERT(type, input, style)

--In case of styles, there is a lot of options. The ones below are just examples.

--Examples

DECLARE
	@SomeDate DATETIME(3) = '1793-02-21 11:13:19.033';

SELECT
	CONVERT(NVARCHAR(3), @SomeDate, 0) AS DefaultForm,
	CONVERT(NVARCHAR(3), @SomeDate, 1) AS US_mdy,
	CONVERT(NVARCHAR(3), @SomeDate, 101) AS US_mdyyyy,
	CONVERT(NVARCHAR(3), @SomeDate, 120) AS ODBC_sec


FORMAT()----------------------------------------------------------------------------------

--Provides much flexibility for formatting. Uses .NET framework for conversion (processes
--more rows) and thus it can be slower than CAST() or CONVERT(). However, this starts to
--be an issue with 50,000-100,000 rows. Available only in T-SQL.

FORMAT(input, format-code[, optional-culture])

--There is a lot of format-codes and you can also create your own using date parts.

--Examples

DECLARE
	@SomeDate DATETIME(3) = '1793-02-21 11:13:19.033';

SELECT
	FORMAT(@SomeDate, 'd', 'en-US') AS US_d
	FORMAT(@SomeDate, 'd', 'de-DE') AS DE_d
	FORMAT(@SomeDate, 'D', 'de-DE') AS DE_D
	FORMAT(@SomeDate, 'yyy-MM-dd') AS yMd;

__________________________________________________________________________________________
CALENDAR-TABLES---------------------------------------------------------------------------

--A table that stores information for easy retrieval, much like a 'warehouse dimension'.
--It can be used to simplify queries.

--Building a calendar table

CREATE TABLE dbo.Calendar
(
	DataKey INT NOT NULL,
	[Date] DATE NOT NULL,
	[Day] TINYINT NOT NULL,
	DayOfWeek TINYINT NOT NULL,
	DayName VARCHAR(10) NOT NULL,
	...
)

--However, we usually do not build it whole from scratch. It's better to use a script 
--found online.

APPLY()
--Executes a function for each row in a result set. Quite useful in many situation,
--including working with calendar tables.

__________________________________________________________________________________________
BUILDING-DATES-FROM-PARTS-----------------------------------------------------------------

DATEFROMPARTS(year, month, day)  --takes integers, returns date

TIMEFROMPARTS(hour, minute, second, fraction, precision)  --precision from 0 to 7

DATETIMEFROMPARTS(year, month, day, hour, minute, second, ms)

DATETIME2FROMPARTS(year, month, day, hour, minute, second, fraction, precision)

SMALLDATETIMEFROMPARTS(year, month, day, hour, minute)

DATETIMEOFFSETFROMPARTS(year, month, day, hour, minute, second, fraction, hour_offset,
			minute_offset, precision)  --allows to specify time-zone

__________________________________________________________________________________________
TRANSLATING-DATE-STRINGS------------------------------------------------------------------

--Like when reading data from CSVs or external sources.

CAST('13/05/90' AS DATE) AS birthday  --around 250k conversions per second

CONVERT(DATETIME2(3), 'May 13, 1990 11:52:29.998 AM') AS birthday  --around 240k

PARSE('25 Dezember 2014' AS DATE USING 'de-de') AS Wiehnachten  --around 12k
--the cost of using PARSE is significant so it's not recommended if not required

__________________________________________________________________________________________
SET-LANGUAGE------------------------------------------------------------------------------

--Allows to change the language in the current session. Useful when we need to use month
--names in a specific language (and pass those to formatting functions).

SET LANGUAGE 'FRENCH'
