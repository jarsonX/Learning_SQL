PODSTAWY BAZ DANYCH I SQL

_________________________________________________________________________________________________________________
TERMINOLOGIA

Baza danych - zestaw informacji opisujących pewne obiekty; wyróżniamy modele proste (kartotekowe, hierarchiczne)
oraz złożone (relacyjne, obiektowe, relacyjno-obiektowe).

Model relacyjny opiera się na matematycznej teorii mnogości / teorii zbiorów. Grupy podobnych obiektów ujęte są
w postaci tabel. Pomiędzy tabelami zachodzą relacje.

Struktura modeul relacyjnego powinna opierać się na modelu gwiazdy. Centralnym obiektem jest tabela faktów.
Opisują ją tabele wymiarów. Jednocześnie dobra struktura, to taka, która zbudowana jest jak "płatek śniegu".

wiersz = krotka = rekord; zawiera obiekt
atrybut = kolumna (nazwa i typ danych)
dziedzina = zbiór dopuszczalnych wartości dla atrybutu
stopień krotności relacji = liczba atrybutów relacji
moc relacji = ilość krotek, które znajdują się w relacji
