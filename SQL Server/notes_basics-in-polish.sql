Podstawy SQL w wersji SQL Server

_________________________________________________________________________________________________________________
SKŁADNIA PODSTAWOWA

SELECT kolumna_1, kolumna_2     atrybuty
FROM tabela                     relacje
WHERE wyrażenie_logiczne        ograniczenia
ORDER BY kolumna_1, kolumna_2

_________________________________________________________________________________________________________________
FUNKCJE AGREGUJĄCE

COUNT, SUM, MAX, MIN, AVG, STDEV, VAR

Z funkcjami agregującymi możemy wykorzystać: GROUP BY oraz HAVING. HAVING działa tylko z GROUP BY.

SELECT SUM(kolumna_1) AS 'suma'
FROM tabela
GROUP BY xxx
HAVING yyy > 1

