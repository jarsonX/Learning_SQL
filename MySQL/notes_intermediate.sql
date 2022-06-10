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

Ways to access multiple tables in the same query:
- Sub-queries
- Implicit JOIN
- JOIN operators    (described along with other JOIN operators in relevant section)

____________________________________________________________________________________________________
SUB-QUERY

SELECT DEPT_ID_DEP, DEP_NAME
FROM DEPARTMENTS
WHERE DEPT_ID_DEP IN (
  SELECT DEP_ID
  FROM EMPLOYEES
  WHERE SALARY > 70000);
  
____________________________________________________________________________________________________
IMPLICIT JOIN

SELECT *                                  Implicit CROSS JOIN (Cartesian Join)
FROM EMPLOYEES, DEPARTMENTS

SELECT *
FROM EMPLOYEES AS E, DEPARTMENTS AS D     Implicit INNER JOIN
WHERE E.DEP_ID = D.DEPT_ID_DEP;
