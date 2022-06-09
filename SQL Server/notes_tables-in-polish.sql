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

3). UPDATE + TOP + WHERE

UPDATE TOP(10) HumarResources.Employee
