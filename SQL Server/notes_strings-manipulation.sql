--FUNCTIONS-FOR-STRINGS-POSITIONS---------------------------------------------------------
__________________________________________________________________________________________

LEN(string)
--Returns the number of characters of the provided string, excluding the blanks at the end.

CHARINDEX(expression_to_find, expression_to_search [, start_location])
--Looks for a character expression in a given string and returns its starting position.

PATINDEX('%pattern%', expression [, location])
--Similar to CHARINDEX(). Returns the starting position of a pattern in an expression.
--Wildcard characters can be used:

|Wildcard| Explanation                                                                |
|--------|----------------------------------------------------------------------------|
|   %    | Match any string of any length (including zero length).                    |
|   _    | Match on a single character.                                               |
|   []   | Match on any character in [] brackets, e.g. [abc] would match on a, b or c.|

--Example
SELECT
  first_name,
  last_name,
  email
FROM voters
-- Look for first names that contain one of the letters: "x", "w", "q"
WHERE PATINDEX('%[xwq]%', first_name) > 0;


--FUNCTIONS-FOR-STRINGS-TRANSFORMATION----------------------------------------------------
__________________________________________________________________________________________

LOWER(string)
UPPER(string)

LEFT(string, number_of_characters)
RIGHT(string, number_of_characters)

LTRIM(string)  --returns a string after removing the leading blanks
RTRIM(string)  --returns a string after removing the trailing blanks
TRIM([characters from,] string)  --removies blanks from both the beginning and the end

REPLACE(string, searched_string, replacement_string)
--returns a string where all occurences of an expression are replaced with another one

--Example
SELECT REPLACE('I like apples, apples are good.', 'apples', 'oranges')

SUBSTRING(string, start, number_of_characters) --returns part of a string

--Example
SELECT SUBSTRING('123456789', 5, 3)  --result: '567'


--FUNCTIONS-MANIPULATING-GROUPS-OF-STRINGS------------------------------------------------
__________________________________________________________________________________________

--Concatenating using '+' allows to concatenate only strings. With the in-built functions
--any data types can be concatenated. Moreover, '+' might perform an addition if the values
--are not first converted to strings, leading to unexpected results.

--BASICS----------------------------------------------------------------------------------

CONCAT(string1, string2 [, stringN])
CONCAT_WS(separator, string1, string2 [, stringN])  --includes the separator

STRING_AGG(string, separator) [ <order_clause> ]
STRING_AGG(expression, separator) [WITHIN GROUP (ORDER BY expression)]
--Concatenates the values of strings and places separator between them BUT NOT at the end.

--Examples

SELECT
  STRING_AGG(first_name, ', ') AS list_of_names
FROM voters;

SELECT
  STRING_AGG(CONCAT(first_name, ' ', last_name, ' (', first_vote_date, ')'), CHAR(13))
AS list_of_names
FROM voters;

--CHAR(13) is a carriage return character and a list separated by it, will show values one
--below the other.

STRING_SPLIT(string, separator)
--Divides a string into smaller pieces, based on a separator. Returns a single column TABLE.
--Because of that, it cannot be used as a column in the SELECT clause. You can only use it
--in the FROM clause, just like a normal table.


--STRING_AGG()-WITH-GROUP-BY--------------------------------------------------------------

SELECT
  YEAR(first_vote_date) AS voting_year,
  STRING_AGG(first_name, ', ') AS voters
FROM voters
GROUP BY YEAR(first_vote_date);

| voting_year | voters                            |
|-------------|-----------------------------------|
| 2013        | Melody, Clinton, Kaylee, ...      |
| 2014        | Brett, Joe, April, Mackenzie, ... |
| 2015        | Cedric, Julie, Sandra, ...        |
| 2016        | Isabella, Vincent, Haley, ...     |


--STRING_AGG()-WITH-THE-OPTIONAL-<order_clause>-------------------------------------------

--When you have a GROUP BY in your query, you can order your concatenated values based on
--a column.

SELECT
  YEAR(first_vote_date) AS voting_year,
  STRING_AGG(first_name, ', ') WITHIN GROUP (ORDER BY first_name ASC) AS voters
FROM voters
GROUP BY YEAR(first_vote_date);

--Voters appear in alphabetical order:

| voting_year | voters                            |
|-------------|-----------------------------------|
| 2013        | Amanda, Anthony, Carol, ...       |
| 2014        | April, Brett, Bruce, Carl, ...    |
| 2015        | Abigail, Alberto, Alexa, ...      |
| 2016        | Barbara, Haley, Isabella, ...     |
