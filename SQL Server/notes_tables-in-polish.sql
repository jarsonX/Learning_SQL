EDYCJA DANYCH I TABEL

_________________________________________________________________________________________________________________
UPDATE

Zmiana wartości komórki, kolumny, wiersza.

Przykłady:

1). Zmienia wartość w trzech kolumnach dla WSZYSTKICH rekordów.

UPDATE Sales.SalesPerson
SET Bonus = 6000, CommissionPct = 10, Sales = NULL

2). Zmienia wartość jednej kolumny dla KONKRETNYCH rekordów.

UPDATE Production.Product
SET Color = N'Metallic Red'
WHERE Name LIKE N'Road-250%' AND Color = N'Red'

3). UPDATE + TOP

UPDATE TOP(10) HumarResources.Employee
SET VacationHours = VacationHours * 1.25

4). UPDATE + TOP + WHERE

UPDATE HumanResources.Employee
SET VacationHours = VacationHours + 8
FROM (SELECT TOP(10) BusinessEntityID
      FROM HumanResources.Employee
      ORDER BY HireDate) AS th
WHERE HumanResources.Employee.BusinessEntityID = th.BusinessEntityID      

_________________________________________________________________________________________________________________
INSERT INTO

Dodanie nowego wiersza do tabeli.

Przykład:

INSERT INTO Employees (ID, fname, lname)
  VALUES (3022, 'John', 'Smith')
  
INSERT INTO OrdersArchive (ID, date, ship_name)
  SELECT ID, date, ship_name FROM Orders
  WHERE order_date >= (DATE()-30)
  
_________________________________________________________________________________________________________________
DELETE

Usuwanie rekordów. 

Dodanie nowego wiersza do tabeli.

DELETE FROM Production.History    - usuwa wszystkie rekordy
WHERE ...                         - opcjonalne, pozwala ograniczyć zakres

