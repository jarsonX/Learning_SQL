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
END AS ...

Zastosowanie ZŁOŻONE - sprawdza wiele warunków i zwraca wynik związany z pierwszym spełnionym warunkiem.

CASE argument
WHEN warunek_1 THEN 'Jeżeli prawda_1'           warunek to np. CategoryID = 1 OR CategoryID = 2
WHEN warunek_2 THEN 'Jeżeli prawda_2'
ELSE 'Jeżeli fałsz'
END AS ...

CASE może zostać ujęte w funkcji agregującej, np.:

SELECT season
      , COUNT(CASE WHEN id = 8888
              AND home_goal > away_goal
              THEN id END) AS home_wins
FROM match
GROUP BY season

>>> IIF
Stosowane, gdy są tylko dwie możliwości wyboru.

IIF (warunek, jeżeli_prawda, jeżeli_fałsz)

Przykład:

SELECT ProductName, UnitPirce
IIF (UnitPrice < 20, 'niska cena',
      IIF (UnitPrice BETWEEN 20 AND 40, 'średnia cena', 'wysoka cena')
     ) AS 'Przedział_cenowy'
FROM Products
