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
