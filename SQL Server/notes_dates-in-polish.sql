DATY I CZAS

__________________________________________________________________________________________________
AKTUALNY CZAS, DATA

SYSDATETIME()
SYSDATETIMEOFFSET
GETDATE()
GETUTCDATE()

____________________________________________________________________________________________________
PARAMETR DATEPART

yy, yyyy  YEAR()
qq, q     QUARTER()
mm, m     MONTH()
dd, d     DAY()
dw        WEEKDAY()
dy, y     DAYOFYEAR()
wk, ww    WEEK()
hh        HOUR()
mi, n     MINUTE()
ss, s     SECOND() 
ms        MILISECOND()
mcs       MICROSECOND()
ns        NANOSECOND()

Przykład:

SELECT ID
FROM table_name
WHERE MONTH(Dates) = '05'

____________________________________________________________________________________________________
DATENAME - zwraca nazwę

DATENAME(datepart_parameter, data)

Przykład: SELECT DATENAME(dw, GETDATE()) AS 'dzień tygodnia'
____________________________________________________________________________________________________
EKSTRAKT

SELECT  YEAR (GETDATE()) AS 'rok'
SELECT  MONTH (GETDATE()) AS 'miesiąc'
SELECT  DAY (GETDATE()) AS 'dzień'

lub

DATEPART(yy, GETDATE()) AS 'rok'
DATEPART(mm, GETDATE()) AS 'miesiąc'
DATEPART(dd, GETDATE()) AS 'dzień'

____________________________________________________________________________________________________
DZIAŁANIA NA DATACH

DATEDIFF(datepart_parameter, START_DATE, END_DATE)
DATEADD(datepart_parameter, liczba, data)           np. SELECT DATEADD(ww, 3, '2018-08-15')

Przykład: znajdź pierwszy dzień miesiąca

SELECT DATEADD(dd, -DAY(GETDATE()-1), GETDATE())
