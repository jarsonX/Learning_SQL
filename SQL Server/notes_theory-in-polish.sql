PODSTAWY BAZ DANYCH I SQL

_________________________________________________________________________________________________________________
BAZY DANYCH

Baza danych - zestaw informacji opisujących pewne obiekty; wyróżniamy modele proste (kartotekowe, hierarchiczne)
oraz złożone (relacyjne, obiektowe, relacyjno-obiektowe).

Model relacyjny opiera się na matematycznej teorii mnogości / teorii zbiorów. Grupy podobnych obiektów ujęte są
w postaci tabel. Pomiędzy tabelami zachodzą relacje.

Struktura modeul relacyjnego powinna opierać się na modelu gwiazdy. Centralnym obiektem jest tabela faktów.
Opisują ją tabele wymiarów. Jednocześnie dobra struktura, to taka, która zbudowana jest jak "płatek śniegu".

_________________________________________________________________________________________________________________
TERMINOLOGIA

Wiersz = krotka = rekord; zawiera obiekt
Atrybut = kolumna (nazwa i typ danych)
Dziedzina = zbiór dopuszczalnych wartości dla atrybutu
Stopień krotności relacji = liczba atrybutów relacji
Moc relacji = ilość krotek, które znajdują się w relacji

_________________________________________________________________________________________________________________
12 POSTULATÓW CODDA

Edgar Frank „Ted” Codd (ur. 23 sierpnia 1923 w Isle of Portland, zm. 18 kwietnia 2003 w Williams Island, Aventura) 
– brytyjski informatyk, znany przede wszystkim ze swojego wkładu w rozwój teorii relacyjnych baz danych.

13 zasad numerowanych od 0 do 12, współcześnie automatycznie zaszytych w bazach:

0. System musi być kwalifikowany jako relacyjny, jako baza danych i jako system zarządzania.
1. Postulat informacyjny - dane są reprezentowane jedynie poprzez wartości atrybutów w wierszach tabel,
2. Postulat dostępu - każda wartość w bazie danych jest dostępna poprzez podanie nazwy tabeli, atrybutu oraz 
wartości klucza podstawowego,
3. Postulat dotyczący wartości NULL - dostępna jest specjalna wartość NULL dla reprezentacji wartości nieokreślonej 
jak i nieadekwatnej, innej od wszystkich i podlegającej przetwarzaniu,
4. Postulat dotyczący katalogu - wymaga się, aby system obsługiwał wbudowany katalog relacyjny z bieżącym dostępem 
dla uprawnionych użytkowników używających języka zapytań,
5. Postulat języka danych - system musi dostarczać pełnego języka przetwarzania danych, który może być używany 
w trybie interaktywnym jak i w obrębie programów aplikacyjnych, obsługuje operacje definiowania danych, operacje 
manipulowania danymi, ograniczenia związane z bezpieczeństwem i integralnością oraz operacje zarządzania 
transakcjami,
6. Postulat modyfikowalności perspektyw - system musi umożliwiać modyfikowanie perspektyw, o ile jest ono 
(modyfikowanie) semantycznie realizowalne,
7. Postulat modyfikowalności danych - system musi umożliwiać operacje modyfikacji danych, musi obsługiwać 
operatory INSERT, UPDATE oraz DELETE,
8. Postulat fizycznej niezależności danych - zmiany fizycznej reprezentacji danych i organizacji dostępu nie 
wpływają na aplikacje,
9. Postulat logicznej niezależności danych - zmiany wartości w tabelach nie wpływają na aplikacje,
10. Postulat niezależności więzów spójności - więzy spójności są definiowane w bazie i nie zależą od aplikacji,
11. Postulat niezależności dystrybucyjnej - działanie aplikacji nie zależy od modyfikacji i dystrybucji bazy,
12. Postulat bezpieczeństwa względem operacji niskiego poziomu - operacje niskiego poziomu nie mogą naruszać 
modelu relacyjnego i więzów spójności. 

_________________________________________________________________________________________________________________
WŁASNOŚCI RELACJI

1. Kolumna ma jednoznaczną nazwę, unikatową w ramach danej tabeli.
2. Wszystkie wartości w kolumnie są tego samego typu.
3. Każdy wiersz jest unikalny.
4. Każde pole (tj. przecięcie kolumny z wierszem) zawiera wartość atomową. Nie przechowujemy w jednym polu większej
ilości informacji, niż to konieczne.
5. Każda relacja zawiera PRIMARY KEY, tj. kolumnę lub kolumny, których wartości pozawlają na jednoznaczną
identyfikację wiersza.