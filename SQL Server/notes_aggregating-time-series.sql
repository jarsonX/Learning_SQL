--KEY-AGGREGATION-FUNCTIONS-------------------------------------------------------------------------
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







