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

_________________________________________________________________________________________________________________
PROJEKTOWANIE BAZ DANYCH

>>> MODEL KONCEPTUALNY (opis teoretyczny)
1. Analiza informacji, które będą zawarte w bazie.
2. Diagram Encji / Relacji (schemat struktury; encje, relacje, klucze),
   Diagramy przypadków użycia.
3. Schemat bazy (model relacyjny) - kompletny schemat.

>>> DIAGRAM ENCJI / RELACJI (ERD):
- podstawowe elementy:
   - encje - rozróżnialne obiekty
   - tabele - zbiory encji
   - atrybuty - informacje opisujące encje
   - powiązania pomiędzy encjami lub tabelami
- liczności
- klucze
- podklasy

>>> KLUCZE:
- każda tabela musi mieć klucz
- rodzaje:
   - PRIMARY KEY
   - FOREIGN KEY (przy powiązaniach przechodzi z jednej tabeli do drugiej)

>>> CECHY DOBREGO SCHEMATU:
- brak redundancji,
- przejrzystość i czytelność,
- odzwierciedlenie wszystkich obiektów, powiązań,
- wskazanie typów pól, charakteru powiązań

>>> DOKUMENTACJA:
- projekt
- dokumentacja techniczna (schematy, diagramy)
- instrukcje dla konkretnych stanowisk, klientów itp.

_________________________________________________________________________________________________________________
ZASADY PROJEKTOWANIA BAZ DANYCH

1. Dokładność - projekt odpowiada specyfikacji, odzwierciedla rzeczywistość,
2. Unikanie redundancji,
3. Prostota - tylko tyle elementów, ile potrzeba,
4. Dobór właściwych elementów - nie dobieramy atrybutów, które nie są potrzebne (np. wzrost użytkownika biblioteki)

_________________________________________________________________________________________________________________
TWORZENIE PROJEKTU BAZY DANYCH

1. Identyfikacja procesów związanych z bazą (w konkretnej organizacji) i określenie potrzebnych funkcjonalności.
2. Identyfikacja obiektów uczestniczących w tych procesach.
3. Identyfikacja rodzajów powiązań między obiektami.
4. Zdefiniowanie słowników (zbiorów wartości cech atrybutów).
5. Identyfikacja zmiennych swobodnych.

Zmienne swobodne to informacje niepowiązane bezpośrednio z wcześniejszymi obiektami. Przechowuje się je w tabeli,
która nie ma relacji z innymi.

_________________________________________________________________________________________________________________
NORMALIZACJA

Def. 1 - organizowanie danych w bazie.
Def. 2 - eliminowanie powtarzających się danych w relacyjnej bazie danych.

Normalizacja prowadzi od schematu nienormalizowanego przez 5 postaci znormalizowanych, przy czym w większości
wypadków wystarczające są pierwsze 3 postacie.

>>> CELE:
1. Uniknięcie redundancji
2. Wyeliminowanie relacji wieloznacznych (wiele do wielu)
3. Uniknięcie anomalii przy aktualizacji (anomalie: modyfikacje, usuwanie, dołączenie/wstawienie)
4. Uniknięcie niespójności

_________________________________________________________________________________________________________________
ANOMALIE

1. Redundancja - ta sama informacja przechowywana w kilku krotkach. Nadmiarowość kodowania.
2. Anomalia modyfikacji - aktualizcja jednej krotki, nie powoduje aktualizacji innej (choć powinna).
3. Anomalia usuwania - usunięcie jednej informacji powoduje usunięcie drugiej informacji (choć nie powinno).
4. Anomalia dołączania/wstawiania - wprowadzenie informacji zależne jest od wprowadzenia innej informacji,
która jest niedostępna.

_________________________________________________________________________________________________________________
BEZSTRATNE ZŁĄCZENIE

Tabela -> podział -> ponowne połączenie -> ta sama tabela, co na początku

_________________________________________________________________________________________________________________
INTEGRALNOŚĆ BAZY DANYCH

Wewnętrzna - zawartość zgodna sama ze sobą.
Zewnętrzna - zawartość zgodna z rzeczywistością.





