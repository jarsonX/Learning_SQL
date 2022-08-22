____________________________________________________________________________________________________
--ANALYTIC-FUNCTIONS--------------------------------------------------------------------------------

--Calculate aggregate value on a group of rows. They are computed on each row, instead of a group of
--data.

FIRST_VALUE(numeric_expression) OVER([PARTITION BY column] ORDER BY COLUMN ROW_or_RANGE frame)
--Returns the first value in an ordered set. ROW_or_RANGE frame sets the partition limits.

LAST_VALUE(numeric_expression) OVER([PARTITION BY column] ORDER BY column ROW_or_RANGE frame)
--Returns the last value in an ordered set.

ROW_or_RANGE frame

RANGE BETWEEN start_boundary AND end_boundary
ROWS BETWEEN start_boundary AND end_boundary

--|---------------------|----------------------------|
--| Boundary            | Description                |
--|---------------------|----------------------------|
--| UNBOUNDED PRECEDING | first row in the partition |
--| UNBOUNDED FOLLOWING | last row in the partition  |
--| CURRENT ROW         | current row                |
--| PRECEDING           | previous row               |
--| FOLLOWING           | next row                   |
--|---------------------|----------------------------|

