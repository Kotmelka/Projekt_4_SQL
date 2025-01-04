-- 1. Růst mezd v odvětvích -- v některých odvětvích klesly, jen ve třech pouze rostly: ostatní činnosti, zdravotní a sociální péče a zpracovatelský průmysl
WITH wage_growth AS (
    SELECT 
        t1.year,
        t1.industry_name,
        t1.avg_wage as current_wage,
        LAG(t1.avg_wage) OVER (PARTITION BY t1.industry_branch_code ORDER BY t1.year) as prev_wage
    FROM t_tereza_kotmelova_project_sql_primary_final t1
    WHERE t1.value_type_code = 5958
)
SELECT 
    industry_name,
    year,
    ROUND(((current_wage - prev_wage) / prev_wage * 100), 2) as growth_percent
FROM wage_growth
WHERE prev_wage IS NOT NULL
ORDER BY industry_name, year;