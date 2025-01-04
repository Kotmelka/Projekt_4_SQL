-- Vytvoření sekundární tabulky
CREATE OR REPLACE TABLE t_tereza_kotmelova_project_sql_secondary_final AS
SELECT 
    e.country,
    e.year,
    e.GDP,
    c.continent,
    c.currency_code
FROM economies e
JOIN countries c 
    ON e.country = c.country
WHERE c.continent = 'Europe'
    AND e.year BETWEEN 2006 AND 2018
    AND e.GDP IS NOT NULL
    AND e.country != 'Czech Republic'
ORDER BY e.country, e.year;

SELECT * FROM t_tereza_kotmelova_project_sql_secondary_final;