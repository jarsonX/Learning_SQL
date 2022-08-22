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
