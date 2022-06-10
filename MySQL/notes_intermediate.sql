-------------------------------------------------------------------------SUB-QUERIES, NESTED QUERIES
____________________________________________________________________________________________________

Sub-queries can be used in:
- WHERE clause
- SELECT clause (list of columns)
- FROM clause

____________________________________________________________________________________________________
in WHERE

SELECT EMP_ID, F_NAME, L_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (
                SELECT AVG(SALARY)
                FROM EMPLOYEES
                );

____________________________________________________________________________________________________
in SELECT (column expressions)

SELECT EMP_ID, SALARY, (SELECT AVG(SALARY)
                        FROM EMPLOYEES) AS AVG_SALARY
FROM EMPLOYEES

____________________________________________________________________________________________________
in FROM (derived tables/derived expressions)

SELECT *
FROM (SELECT EMP_ID, F_NAME, L_NAME, DEP_ID
      FROM EMPLOYEES) AS EMP4ALL
      
------------------------------------------------------------------------WORKING WITH MULTIPLE TABLES
____________________________________________________________________________________________________      
