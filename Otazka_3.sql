-- 3. Nejpomalejší zdražování -- nejpomaleji zdražoval "Cukr krystalový"
WITH price_changes AS (
    SELECT 
        t1.price_category_name,
        t1.year,
        AVG(t1.avg_price) as avg_year_price,
        LAG(AVG(t1.avg_price)) OVER (PARTITION BY t1.price_category_code ORDER BY t1.year) as prev_year_price
    FROM t_tereza_kotmelova_project_sql_primary_final t1
    GROUP BY t1.price_category_name, t1.year
)
SELECT 
    price_category_name,
    ROUND(AVG((avg_year_price - prev_year_price) / prev_year_price * 100), 2) as avg_growth
FROM price_changes
WHERE prev_year_price IS NOT NULL
GROUP BY price_category_name
ORDER BY avg_growth
LIMIT 1;