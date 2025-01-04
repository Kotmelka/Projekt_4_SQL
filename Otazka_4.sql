-- 4. Výrazný nárůst cen vs. mezd -- výrazný nárůst nebyl nikde --výsledek query je null
WITH yearly_changes AS (
    SELECT 
        t1.year,
        AVG(t1.avg_wage) as avg_year_wage,
        AVG(t1.avg_price) as avg_year_price,
        LAG(AVG(t1.avg_wage)) OVER (ORDER BY t1.year) as prev_year_wage,
        LAG(AVG(t1.avg_price)) OVER (ORDER BY t1.year) as prev_year_price
    FROM t_tereza_kotmelova_project_sql_primary_final t1
    GROUP BY t1.year
)
SELECT 
    year,
    ROUND(((avg_year_price - prev_year_price) / prev_year_price * 100) - 
          ((avg_year_wage - prev_year_wage) / prev_year_wage * 100), 2) as difference
FROM yearly_changes
WHERE prev_year_wage IS NOT NULL
HAVING difference > 10;