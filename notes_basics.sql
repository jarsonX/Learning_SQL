BASICS
################################################################################
________________________________________
SELECT STATEMENT

SELECT column1, column2, ...
FROM table_name
WHERE condition/predicate;

________________________________________
COUNT

SELECT COUNT(*)
FROM table_name

________________________________________
DISTINCT - removes duplicates

SELECT DISTINCT column_name
FROM table_name

________________________________________
LIMIT - restricts number of rows

SELECT * from table_name
LIMIT 10

Use OFFSET to determine starting point like:
SELECT * from table_name
LIMIT 10 OFFSET 4  -> this will start at 5

MODIFYING TABLES
################################################################################
________________________________________
INSERT - inserts new rows

INSERT INTO table_name (column1, column2, ... )
VALUES (value1, value2, ... );

INSERT INTO table_name (column1, column2, ... )
VALUES (value1, value2, ... ), 
       (value1, value2, ... );

________________________________________
UPDATE - updates rows

UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

It is crucial to include WHERE. Otherwise, all rows will be affected.

________________________________________
DELETE - deletes rows

DELETE FROM table_name
WHERE condition;
