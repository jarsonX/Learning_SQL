--------------------------------------------------------------------------------------------REMEMBER
SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY


----------------------------------------------------------------------------------------------BASICS
____________________________________________________________________________________________________
SELECT STATEMENT

SELECT column1, column2, ...
FROM table_name

____________________________________________________________________________________________________
WHERE condition/predicate;

=, >, >=, <, <=, <>, AND, OR, BETWEEN x AND y, IN ('x', 'y')

WHERE firstname LIKE 'D%'
WHERE firstname LIKE 'T___'
WHERE firstname LIKE '[a-d]%'
WHERE firstname LIKE >= 'N'

____________________________________________________________________________________________________
DISTINCT - removes duplicates

SELECT DISTINCT (column_name)
FROM table_name

____________________________________________________________________________________________________
LIMIT - restricts number of rows in MySQL
TOP - same in SQL Server, MS Access
FETCH - same in Oracle

SELECT * from table_name
LIMIT 10

Use OFFSET to determine starting point like:
SELECT * from table_name
LIMIT 10 OFFSET 4  -> this will start at 5


---------------------------------------------------------------------------------AGGREGATE FUNCTIONS
____________________________________________________________________________________________________
COUNT, SUM, MAX, MIN, AVG, STDEV, VAR

SELECT COUNT(*)
FROM table_name

____________________________________________________________________________________________________
GROUP BY and HAVING

GROUP BY column
HAVING x > y

HAVING works only with GROUP BY.


-------------------------------------------------------------------------SCALAR AND STRING FUNCTIONS
____________________________________________________________________________________________________

Perform operations on every input value. String functions are those that operate
on char and varchar.

ROUND, LENGTH, UCASE, LCASE

Example: round every value in column:

SELECT ROUND(column)
FROM table


------------------------------------------------------------------------------------MODIFYING TABLES
____________________________________________________________________________________________________
INSERT - inserts new rows

INSERT INTO table_name (column1, column2, ... )
VALUES (value1, value2, ... );

INSERT INTO table_name (column1, column2, ... )
VALUES (value1, value2, ... ), 
       (value1, value2, ... );

____________________________________________________________________________________________________
UPDATE - updates rows

UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

It is crucial to include WHERE. Otherwise, all rows will be affected.

____________________________________________________________________________________________________
DELETE - deletes rows

DELETE FROM table_name
WHERE condition;


------------------------------------------------------------------------CREATE AND MANIPULATE TABLES
____________________________________________________________________________________________________
CREATE

CREATE TABLE name
       (col1 datatype optional_parameters,
        col2 ...,
        PRIMARY KEY (col1)
        )

____________________________________________________________________________________________________
ALTER
Add or remove columns
Modify the datatype of columns
Add or remove KEYS
Add or remove constraints

Each row specifies ONE change.

ALTER TABLE name
       ADD COLUMN col1 datatype
       ...
       ADD COLUMN colN datatype
       
ALTER TABLE name
       ALTER COLUMN col1 SET DATA TYPE datatype
       
ALTER TABLE name
       DROP COLUMN col1
       
ALTER TABLE name
       RENAME COLUMN col1 to 'ABC'
       
____________________________________________________________________________________________________
DROP - deletes a table

       DROP TABLE name

____________________________________________________________________________________________________
TRUNCATE - deletes all rows in a table

       TRUNCATE TABLE name
              IMMEDIATE     (optional)
  
