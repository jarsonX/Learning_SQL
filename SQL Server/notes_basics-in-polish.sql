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
FUNKCJE AGREGUJĄCE

COUNT, SUM, MAX, MIN, AVG, STDEV, VAR

Z funkcjami agregującymi możemy wykorzystać: GROUP BY oraz HAVING. HAVING działa tylko z GROUP BY.

SELECT SUM(kolumna_1) AS 'suma'
FROM tabela
GROUP BY xxx
HAVING yyy > 1

WHERE filtruje wiersze, HAVING filtruje grupy.
W klauzulach GROUP BY i HAVING nie używamy aliasów.

_________________________________________________________________________________________________________________
ŁĄCZENIE TABEL

Iloczyn kartezjański - zbiór, w którym każdy wiersz z pierwszej tabeli połączony jest z każdym wierszem
w drugiej tabeli. Wiersze niepasujące do złączenia są odrzucane. Istotne są klucze główne i obce.

>>> ZŁĄCZENIA WEWNĘTRZNE

JOIN... ON...
INNER JOIN... ON...   część wspólna obu tabel

>>> ZŁĄCZENIA ZEWNĘTRZNE

LEFT JOIN... ON...        lewa tabela + to, co w prawej pasuje do lewej
RIGHT JOIN... ON...
FULL JOIN... ON...        wszystkie obiekty z obu tabel
CROSS JOIN... ON...       każdy obiekt pierwszej tabeli z każdym obiektem drugiej tabeli

>>> OUTER JOINS
Działają jak podstawowe JOINS, ale wykluczają część wspólną.

LEFT OUTER JOIN... ON...  lewa tabela z wyłączeniem tego, co jest wspólne między lewą a prawą
RIGHT OUTER JOIN... ON...
FULL OUTER JOIN... ON...

Przykład:

SELECT cities.name, countries.name
FROM cities
JOIN countries
  ON cities.country_id = countries.id

_________________________________________________________________________________________________________________
ŁĄCZENIA PIONOWE

UNION łączy zestawy i usuwa duplikaty
UNION ALL jak wyżej, ale nie usuwa duplikatów
INTERSECT zwraca część wspólną
EXCEPT zwraca tylko to, co było w pierwszej tabeli i nie powtarzało się w drugiej

Przykład:

SELECT name
FROM cycling
WHERE country = 'PL'
UNION
SELECT name
FROM skating
WHERE country = 'PL'

_________________________________________________________________________________________________________________
INSTRUKCJE WARUNKOWE

>>> CASE
Stosowane przy wielu możliwościach wyboru. Przypomina konstrukcję IF... THEN... ELSE.... 
Sprawdza warunek dla każdego wiersza zwracanego w wyniku zapytania.

Zastosowanie PROSTE - jedna wartość porównywana do listy wartości; zwraca PIERWSZE dopasowanie.

CASE argument
WHEN wartość_1 THEN 'Jeżeli prawda_1'           wartość to np. '1'
WHEN wartość_2 THEN 'Jeżeli prawda_2'
ELSE 'Jeżeli fałsz'
END

Zastosowanie ZŁOŻONE - sprawdza wiele warunków i zwraca wynik związany z pierwszym spełnionym warunkiem.

CASE argument
WHEN warunek_1 THEN 'Jeżeli prawda_1'           warunek to np. CategoryID = 1 OR CategoryID = 2
WHEN warunek_2 THEN 'Jeżeli prawda_2'
ELSE 'Jeżeli fałsz'
END

>>> IIF
Stosowane, gdy są tylko dwie możliwości wyboru.

IIF (warunek, jeżeli_prawda, jeżeli_fałsz)

Przykład:

SELECT ProductName, UnitPirce
IIF (UnitPrice < 20, 'niska cena',
      IIF (UnitPrice BETWEEN 20 AND 40, 'średnia cena', 'wysoka cena')
     ) AS 'Przedział_cenowy'
FROM Products

_________________________________________________________________________________________________________________
WIDOKI

_________________________________________________________________________________________________________________
PODZAPYTANIA

_________________________________________________________________________________________________________________
DATY I CZAS




