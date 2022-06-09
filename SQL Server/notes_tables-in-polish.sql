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
WHERE...                          - opcjonalne, pozwala ograniczyć zakres

_________________________________________________________________________________________________________________
TWORZENIE I MODYFIKACJA BAZY DANYCH

CREATE DATABASE name
DROP DATABASE name
ALTER DATABASE

Przykład:

ALTER DATABASE Northwind
MODIFY NAME = "Północny wiatr"

_________________________________________________________________________________________________________________
TWORZENIE I MODYFIKACJA TABEL

Typy danych:
- numeryczne
- data i czas
- znakowe
- binarne
- przestrzenne
- pozostałe

>>> CREATE TABLE

Przykłady:

CREATE TABLE name (
      kolumna_1 datatype constraint
      kolumna_2 datatype constraint
      )
      
CREATE TABLE Persons ( 
      PersonID int,
      LastName varchar(255),
      FirstName varchar(255),
      Address varchar (255),
      )
      
CREATE TABLE nowa_tabela AS
      SELECT kolumna_1, kolumna_2
      FROM istniejąca_tabela
      WHERE...
    
>>> ALTER TABLE

ALTER TABLE name
      ADD kolumna_1 datatype constraint,
      DROP COLUMN kolumna_2
      ALTER COLUMN kolumna_3 datatype
      
>>> DROP TABLE
      
DROP TABLE name

_________________________________________________________________________________________________________________
PRIMARY KEY

CREATE TABLE Persons ( 
      PersonID int PRIMARY KEY, ...
      
CREATE TABLE Persons (
      ID int NOT NULL,
      LastName varchar(255) NOT NULL,
      FirstName varchar(255),
      Age int DEFAULT 18,
      CONSTRAINT PK_person PRMARY KEY (ID, LastName)        - klucz stworzony z dwóch wartości
      )

_________________________________________________________________________________________________________________
CONSTRAINTS
Określają zasady/reguły dla danych w tabeli. Mogą zostać określone w momencie jej tworzenia lub później poprzez
ALTER TABLE.

NOT NULL
UNIQUE
PRIMARY KEY
FOREIGN KEY
CHECK condition
DEFAULT (podstawowa wartość, jeśli nie podano innej)
CREATE INDEX
