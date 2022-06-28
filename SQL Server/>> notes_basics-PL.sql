Podstawy SQL w wersji SQL Server

_________________________________________________________________________________________________________________
SKŁADNIA PODSTAWOWA
                                  Kolejność wg której działa silnik
SELECT kolumna_1, kolumna_2       5
FROM tabela                       1
WHERE wyrażenie_logiczne          2
GROUP BY kryterium grupowania     3 
HAVING kryterium filtrowania      4
ORDER BY kolumna_1, kolumna_2     6

_________________________________________________________________________________________________________________
WHERE - typowe użycia

...WHERE FirstName LIKE  'A%'
                         '%a%'
                         '_a%'
                         '[a-k]%'
                         '[^a-k]%' - spoza zbioru
                         
...WHERE State IN ('WA', 'NV', 'UT')

Przydatne operatory: IN, BETWEEN ... AND ..., AND, OR, NOT, LIKE.

_________________________________________________________________________________________________________________
ORDER BY

Sortować można poprzez:
- nazwę kolumny
- alias
- pozycje kolumny (np. '1' - pierwsza)
- wyliczone wyrażenie

ORDER BY column_1
ORDER BY column_1 DESC
ORDER BY 2, 1           - sortuj po kolumnie 2, a potem po kolumnie 1

_________________________________________________________________________________________________________________
NULL - szczególna wartość

SELECT CompanyName, Region
FROM Suppliers
WHERE Region IS NULL        

Powyższe zwróci wszystkie rekordy, gdzie brakuje informacji odnośnie regionu. Region = '' nie zwróciłoby tej
informacji.

_________________________________________________________________________________________________________________
TOP [PERCENT] [WITH TIES]

SELECT TOP X ProductName

WITH TIES uwzględnia identyczne wartości końcowe.

_________________________________________________________________________________________________________________
FUNKCJE AGREGUJĄCE

COUNT, SUM, MAX, MIN, AVG, STDEV, VAR

Dla powyższych przydaje się DISTINCT, np. COUNT DISTINCT().

Z funkcjami agregującymi możemy wykorzystać: GROUP BY oraz HAVING. HAVING działa tylko z GROUP BY.

SELECT SUM(kolumna_1) AS 'suma'
FROM tabela
GROUP BY xxx
HAVING yyy > 1

WHERE filtruje wiersze, HAVING filtruje grupy.
W klauzulach GROUP BY i HAVING nie używamy aliasów.

Przykład:

SELECT ShipCity, COUNT(Freight) AS 'Freight'
FROM Orders
GROUP BY ShipCity
HAVING COUNT(Freight) > 10

_________________________________________________________________________________________________________________
WIDOKI

Utrwalone zapytanie SELECT.

CREATE VIEW nazwa
AS
instrukcja SELECT

ALTER VIEW nazwa
AS
instrukcja SELECT

DROP VIEW nazwa

Przykład:

CREATE VIEW klienci_USA
AS
SELECT *
FROM Customers
WHERE Country = 'USA'

SELECT * FROM klienci_USA

_________________________________________________________________________________________________________________
PODZAPYTANIA

Zagnieżdżanie zapytań, tj. instrukcja SELECT wewnątrz instrukcji SELECT, zapisywana w nawiasie.

Dzielą się na:
- zwracające pojedynczą wartość skalarną
- zwracające listę wartości (jedną kolumnę)
- zwracające dane tabelaryczne

Do wartości podzapytania odwołujemy się na ogół poprzez operatory IN i NOT IN.

SELECT OrderID, CustomerID
FROM Orders
WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE Country = 'USA'
        )
  
Można również używać operatorów:
- EXISTS - prawdziwe, jeśli zapytanie zwróciło cokolwiek
- ANY/SOME - sprawdza wartość dowolnego wiersza
- ALL - sprawdza wartość wszystkich wierszy

Przykład:
Szukamy klienta, który nie zamówił żadnego produktu, tj. dla każdego klienta w tabeli klientów sprawdzamy
czy w tabeli zamówień nie istnieje choć jedno zamówienie.

SELECT CustomerID, CompanyName
FROM Customers C
WHERE NOT EXISTS (
        SELECT OrderID
        FROM Orders O
        WHERE O.CustomerID = C.CustomerID
        )

>>> PODZAPYTANIA NIEPOWIĄZANE
Zapytanie wewnętrzne wykonywane jest tylko raz, tj. zwraca jeden wynik.

>>> PODZAPYTANIA POWIĄZANE (skorelowane)
Zapytanie wewnętrzne wykonywane jest dla każdego wiersza zwróconego przez zapytanie, tj. zwraca tyle wierszy ile
wierszy liczy wynik zapytania zewnętrznego.





