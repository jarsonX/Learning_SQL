SQL w wersji SQL Server

_________________________________________________________________________________________________________________
CAST

CAST(expression AS data_type [(length)]) - konwertuje zmienną na inny typ

________________________________________________________________________________________________________________
ZMIENNE

DECLARE - deklaracja zmiennej (nazwa, typ)
SET - przypisanie wartości zmiennej

Przykład:

DECLARE @LastName VARCHAR(30),
        @FirstName VARCHAR(30)
        
SET @LastName = 'Leon'
SET @FirstName = 'Pies'

SELECT LastName, FirstName, HomePhone
FROM Employees
WHERE LastName LIKE @LastName AND FirstName LIKE @FirstName

________________________________________________________________________________________________________________
WHILE ORAZ PRINT

Pętla WHILE wykonywana jest tak długo, jak długo spełniony jest określony warunek. Może być kontrolowana z użyciem
BREAK i CONTINUE.

WHILE x > 10
        {sql_statement | statement_block | BREAK | CONTINUE}
        
Przykład:

WHILE (SELECT AVG(ListPrice) FROM Production.Product) < 300
BEGIN
        UPDATE Production.Product
                SET ListPrice = ListPrice * 2
        SELECT MAX(ListPrice) FROM Production.Product
        IF (SELECT MAX(ListPrice) FROM Production.Product) > 500
                BREAK
        ELSE
                CONTINUE
END
PRINT 'Too much for the market to bear'

________________________________________________________________________________________________________________
FUNKCJE RANKINGUJĄCE

Każda funkcja rankingująca działa w oparciu o funkcję OVER.

>>> LAG 
Odwołuje się do wartości poprzedniego wiersza.

LAG(scalar_expression [, offset][, default])
        OVER ([partition_by_clause] order_by_clause)
        
>>> LEAD
Odwołuje się do wartości kolejnego wiersza.

LEAD(scalar_expression [, offset][, default]
        OVER ([partition_by_clause] order_by_clause)
        
>>> ROW_NUMBER
Numeruje elementy wyniku zapytania.

ROW_NUMBER()
        OVER([PARTITION BY value_expression, ... [n]]
        order_by_clause)
        
>>> DENSE_RANK()
Numeruje elementy wyniku zapytania. Jeżeli elementy posiadają taką samą wartość, otrzymują jednakowy ranking.

DENSE_RANK()
        OVER([partition_by_clause] order_by_clause)
        
>>> RANK()
Numeruje elementy wyniku zapytania. Jeżeli elementy posiadają taką samą wartość, otrzymują jednakowy ranking,
a kolejna liczba w rankingu jest pomijana (np. 1, 2, 2, 4, 5).

RANK()
        OVER([partition_by_clause] order_by_clause)


