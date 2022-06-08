FUNCTIONS
############################################################

yy, yyyy  YEAR()
qq, q     QUARTER()
mm, m     MONTH()
dd, d     DAY()
          DAYOFMONTH()
dw        DAYOFWEEK()  /  WEEKDAY()
dy, y     DAYOFYEAR()
wk, ww    WEEK()
hh        HOUR()
mi, n     MINUTE()
ss, s     SECOND() 
ms        MILISECOND()
mcs       MICROSECOND()
ns        NANOSECOND()

CURRENT_DATE, CURRENT_TIME

Example:
SELECT ID
FROM table_name
WHERE MONTH(Dates) = '05'
