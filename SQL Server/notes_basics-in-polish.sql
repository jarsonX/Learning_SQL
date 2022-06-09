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
CROSS JOIN... ON...

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


