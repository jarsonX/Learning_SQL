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

--DATENAME--------------------------------------------------------------------------------

--Returns a certain part of the date.

DATENAME(datepart, date)

year        yyyy, yy
month       mm, m
dayofyear   dy, y
week        wk, ww
weekday     dw, w


--DATEPART--------------------------------------------------------------------------------

--Works like DATENAME but the returned values are all integers.

DATEPART(datepart, date)


--DATEFROMPARTS---------------------------------------------------------------------------

DATEFROMPARTS(year, month, day)

--The opposite of DATENAME and DATEPART. The inputs are integers.
