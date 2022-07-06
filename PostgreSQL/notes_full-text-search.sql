FULL-TEXT SEARCH

--Searching using tsvector is much more efficient than using LIKE '%' and provide --a foundation for more advanced full-text search queries.

--Example: find all titles that contain word 'elf'

SELECT title, description
FROM film
-- Convert the title to a tsvector and match it against the tsquery
WHERE to_tsvector(title) @@ to_tsquery('elf');

@@ is a match operator for comparison
