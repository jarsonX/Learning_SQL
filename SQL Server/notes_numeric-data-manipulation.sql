____________________________________________________________________________________________________
--ANALYTIC-FUNCTIONS--------------------------------------------------------------------------------

--Calculate aggregate value on a group of rows. They are computed on each row, instead of a group of
--data.

FIRST_VALUE(numeric_expression) OVER([PARTITION BY column] ORDER BY COLUMN ROW_or_RANGE frame)
--Returns the first value in an ordered set. ROW_or_RANGE frame sets the partition limits.

LAST_VALUE(numeric_expression) OVER([PARTITION BY column] ORDER BY column ROW_or_RANGE frame)
--Returns the last value in an ordered set.

PARTITION LIMITS
--The limits of each partition can be explicitly specified after ORDER BY from the OVER clause.
--Remember that analytic functions are applied by default from the first row of the partition
--until the current row.

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

EXAMPLE
--We want to compare the total votes of each person with the minimum number of votes recorded by
--a person and with the maximum. The voters should be divided per gender.

SELECT
    first_name + ' ' + last_name AS name,
    gender,
    total_votes AS votes,
    FIRST_VALUE(total_votes)
        OVER(PARTITION BY gender ORDER BY total_votes) AS min_votes,
    LAST VALUE(total_votes)
        OVER(PARTITION BY gender ORDER BY total_votes
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_votes
FROM voters      

LAG(numeric_expression) OVER([PARTITION BY column] ORDER BY column)
--Accesses data from a previous row in the same result set.

LEAD(numeric_expression) OVER([PARTITION BY column] ORDER BY column)
--Accesses data from a subsequent row in the same result set.

EXAMPLE
--We select information about the different types of chocolates from the company 'Felchlin',
--their cocoa percentage and the rating received. We'd like to compare the percentage of
--each bar with the one of the bar that received the nearest lower rating and also higher
--rating.

SELECT
    broad_bean_origin AS bean_origin,
    rating,
    cocoa_percent,
    LAG(cocoa_percent) OVER(ORDER BY rating) AS percent_lower_rating,
    LEAD(cocoa_percent) OVER(ORDER BY rating) AS percent_higher_rating
FROM ratings
WHERE company = 'Felchlin'
ORDER BY rating ASC

____________________________________________________________________________________________________
--MATHEMATICAL-FUNCTIONS----------------------------------------------------------------------------

--BASIC
ABS(num)
SIGN(num)  --returns the sign of an expression, as an integer

--ROUNDING
CEILING(num)  --returns the smallest integer greater than or equal to the num
--e.g. -50.49 -> -50, 73.71 -> 74
FLOOR(num) --returns the largest integer less than or equal to the num
--e.g. -50.49 -> -51, 73.71 -> 73
ROUND(num, length) --returns a numeric value, rounded to the specified length 
--e.g. ROUND(-50.493, 1) -> -50.500, ROUND(73.715, 2) -> 73.720

--EXPONENTIAL
POWER(num, power)
SQUARE(num) --the same as POWER(num, 2)
SQRT(num)

--Note that the numeric expression received by exponential functions as the first parameter must be
--a float number or an expression that can be implicitly converted to a float.
