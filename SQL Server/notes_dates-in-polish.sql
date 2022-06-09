DATY I CZAS

____________________________________________________________________________________________________
PARAMETRY

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
AKTUALNY CZAS, DATA


