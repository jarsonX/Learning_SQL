--MANIPULATING-TIME-----------------------------------------------------------------------
__________________________________________________________________________________________

--Function that return system date and time

--Higher precision                    --Lower precision
SYSDATETIME()                         GETDATE()
SYSUTCDATETIME()                      GETUTCDATE()
SYSDATETIMEOFFSET()                   CURRENT_TIMESTAMP


--RETURNING-DATE-AND-TIME-PARTS-----------------------------------------------------------
__________________________________________________________________________________________

YEAR()
MONTH()
DAY()


DATENAME(datepart, date)-------------------------------------------------------------------

--Returns a certain part of the date.

year        yyyy, yy
month       mm, m
dayofyear   dy, y
week        wk, ww
weekday     dw, w


DATEPART(datepart, date)-------------------------------------------------------------------

--Works like DATENAME but the returned values are all integers.



DATEFROMPARTS(year, month, day)------------------------------------------------------------

--The opposite of DATENAME and DATEPART. The inputs are integers.


--ARITHMETIC-OPERATIONS-ON-DATES----------------------------------------------------------
__________________________________________________________________________________________

DATEADD(datepart, number, date)
DATEDIFF(datepart, start_date, end_date)


--VALIDATING-IF-AN-EXPRESSION-IS-A-DATE---------------------------------------------------
__________________________________________________________________________________________

--Remember that SQL Server can interpret character strings that look like dates in a 
--different way than you would expect. Depending on your settings, the string "29-04-2019" 
--could be interpreted as the 29th of April, or an error can be thrown that the conversion 
--to a date was not possible. In the first situation, SQL Server expects a day-month-year 
--format, while in the second, it probably expects a month-day-year and the 29th month does 
--not exist.

ISDATE(expression)-------------------------------------------------------------------------  
--Determines wheter an expression is a valid date.
--The output is 1 if 'date', 'time' or 'datetime' Do not recognize 'datetime2' type.

SET DATEFORMAT {format}--------------------------------------------------------------------
--Sets the order of the date parts (year, month, day) for interpreting strings as dates.
--Valid formats: mdy, dmy, ymd, ydm, myd, dym

DECLARE @date1 NVARCHAR(20) = '12-30-2019'
DECLARE @date2 NVARCHAR(20) = '30-12-2019'

SET DATEFORMAT dmy;
SELECT
	ISDATE(@date1) AS invalid_dmy,
	ISDATE(@date2) AS valid_dmy;

SET LANGUAGE {language}---------------------------------------------------------------------
--Sets language for the session. It impacts how dates are interpreted.
