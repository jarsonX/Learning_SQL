--JOIN EXAMPLE

--JOIN
SELECT e.F_Name, e.L_Name, d.DEP_Name
FROM Employees AS e
INNER JOIN Departments AS d
	ON e.DEP_ID = d.DEPT_ID_DEP
ORDER BY DEP_Name, L_Name DESC;

--similar result without JOIN
SELECT e.F_Name, e.L_Name, d.DEP_Name
FROM Employees as e, Departments as d
WHERE E.DEP_ID = D.DEPT_ID_DEP
ORDER BY D.DEP_Name, E.L_Name DESC;
