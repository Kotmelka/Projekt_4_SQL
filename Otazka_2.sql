-- 2. Množství mléka a chleba 
-- v roce 2006 919 kg chleba a 1026 litrů mléka
-- v roce 2018 1051 kg chleba a 1285 litrů mléka
SELECT 
    t1.year,
    t1.price_category_name,
    t1.avg_wage,
    t1.avg_price,
    ROUND(t1.avg_wage / t1.avg_price, 0) as purchase_power
FROM t_tereza_kotmelova_project_sql_primary_final t1
WHERE t1.year IN (2006, 2018)
    AND t1.price_category_code IN (111301, 114201)  -- kódy pro mléko a chléb
GROUP BY t1.year, t1.price_category_code;