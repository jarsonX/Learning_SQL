--JOIN EXAMPLE

--JOIN
SELECT e.F_NAME, e.L_NAME, d.DEP_NAME
FROM EMPLOYEES AS e
INNER JOIN DEPARTMENTS AS d
	ON e.DEP_ID = d.DEPT_ID_DEP
ORDER BY DEP_NAME, L_NAME DESC;

--similar result without JOIN
SELECT D.DEP_NAME , E.F_NAME, E.L_NAME
FROM EMPLOYEES as E, DEPARTMENTS as D
WHERE E.DEP_ID = D.DEPT_ID_DEP
ORDER BY D.DEP_NAME, E.L_NAME DESC;
