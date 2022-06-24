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
OPERACJE NA ZBIORACH, ŁĄCZENIA PIONOWE (UNION)

Łączenie wyników dwóch lub więcej zapytań w jeden rezultat. Zapytania muszą zwracać taką samą ilość kolumn oraz
kompatybilne typy danych. Nazwy odpowiadających sobie kolumn mogą się różnić.

UNION łączy zestawy i usuwa duplikaty
UNION ALL jak wyżej, ale nie usuwa duplikatów
INTERSECT zwraca część wspólną
EXCEPT / MINUS zwraca tylko to, co było w pierwszej tabeli i nie powtarzało się w drugiej

Przykład:

SELECT name
FROM cycling
WHERE country = 'PL'
UNION
SELECT name
FROM skating
WHERE country = 'PL'
