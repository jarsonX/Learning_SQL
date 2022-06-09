SQL w wersji SQL Server

_________________________________________________________________________________________________________________
CAST

CAST(expression AS data_type [(length)]) - konwertuje zmienną na inny typ

_________________________________________________________________________________________________________________
PRZYDATNE FUNKCJE

LEN (string_expression)
LEFT/RIGHT (text, length)
SUBSTRING (text, start, length)
LTRIM (text) - czyści białe znaki
REPLACE(text, pattern, replacement)
CONCAT(text1, text2, textN)
LOWER/UPPER(text)
CHARINDEX(text_to_find, text_to_search, [start])

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


