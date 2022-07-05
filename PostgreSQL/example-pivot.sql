____________________________________________________________________________________________________
BASIC PIVOT

--You have the following table of Pole Vault gold medalist countries by gender in 2008 and 2012.

| Gender | Year | Country |
|--------|------|---------|
| Men    | 2008 | AUS     |
| Men    | 2012 | FRA     |
| Women  | 2008 | RUS     |
| Women  | 2012 | USA     |

--Pivot it by Year to get the following reshaped, cleaner table.

| Gender | 2008 | 2012 |
|--------|------|------|
| Men    | AUS  | FRA  |
| Women  | RUS  | USA  |


-- Create the correct extention to enable CROSSTAB
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM CROSSTAB($$
  SELECT
    Gender, Year, Country
  FROM Summer_Medals
  WHERE
    Year IN (2008, 2012)
    AND Medal = 'Gold'
    AND Event = 'Pole Vault'
  ORDER By Gender ASC, Year ASC;
-- Fill in the correct column names for the pivoted table
$$) AS ct (Gender VARCHAR,
           "2008" VARCHAR,
           "2012" VARCHAR)

ORDER BY Gender ASC;

____________________________________________________________________________________________________
PIVOTING WITH RANKING

--You want to produce an easy scannable table of the rankings of the three most populous EU countries 
--by how many gold medals they've earned in the 2004 through 2012 Olympic games. The table needs to 
--be in this format:

| Country | 2004 | 2008 | 2012 |
|---------|------|------|------|
| FRA     | ...  | ...  | ...  |
| GBR     | ...  | ...  | ...  |
| GER     | ...  | ...  | ...  |

--You'll need to count the gold medals each country has earned, produce the ranks of each country by 
--medals earned, then pivot the table to this shape.

--STEP-1
--Count the gold medals that France (FRA), the UK (GBR), and Germany (GER) have earned per country 
--and year.

--STEP-2
--Select the country and year columns, then rank the three countries by how many gold medals they 
--earned per year.

--STEP-3
--Pivot the query's results by Year by filling in the new table's correct column names.

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM CROSSTAB($$
  WITH Country_Awards AS (
    SELECT
      Country,
      Year,
      COUNT(*) AS Awards
    FROM Summer_Medals
    WHERE
      Country IN ('FRA', 'GBR', 'GER')
      AND Year IN (2004, 2008, 2012)
      AND Medal = 'Gold'
    GROUP BY Country, Year)

  SELECT
    Country,
    Year,
    RANK() OVER
      (PARTITION BY Year
       ORDER BY Awards DESC) :: INTEGER AS rank
  FROM Country_Awards
  ORDER BY Country ASC, Year ASC;
$$) AS ct (Country VARCHAR,
           "2004" INTEGER,
           "2008" INTEGER,
           "2012" INTEGER)

Order by Country ASC;
