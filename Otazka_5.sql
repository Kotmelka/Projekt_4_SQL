-- 5. HDP vs mzdy a ceny --nevypadá, že by HDP mělo vliv na změny potravin
SELECT 
    t1.year,
    t2.GDP,
    ROUND(AVG(t1.avg_wage), 2) as avg_wage,
    ROUND(AVG(t1.avg_price), 2) as avg_price,
    ROUND(((t2.GDP - LAG(t2.GDP) OVER (ORDER BY t1.year)) / LAG(t2.GDP) OVER (ORDER BY t1.year) * 100), 2) as gdp_growth,
    ROUND(((AVG(t1.avg_wage) - LAG(AVG(t1.avg_wage)) OVER (ORDER BY t1.year)) / LAG(AVG(t1.avg_wage)) OVER (ORDER BY t1.year) * 100), 2) as wage_growth,
    ROUND(((AVG(t1.avg_price) - LAG(AVG(t1.avg_price)) OVER (ORDER BY t1.year)) / LAG(AVG(t1.avg_price)) OVER (ORDER BY t1.year) * 100), 2) as price_growth
FROM t_tereza_kotmelova_project_sql_primary_final t1
JOIN t_tereza_kotmelova_project_sql_secondary_final t2 
    ON t1.year = t2.year
WHERE t2.country = 'Czech Republic'
GROUP BY t1.year, t2.GDP
ORDER BY t1.year;