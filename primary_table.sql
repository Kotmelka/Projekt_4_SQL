-- Vytvoření primární tabulky
CREATE OR REPLACE TABLE t_tereza_kotmelova_project_sql_primary_final AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY cp.payroll_year, cp.industry_branch_code, cpc.code) as id,
    cp.payroll_year AS year,
    QUARTER(cpe.date_from) AS quarter,
    cp.industry_branch_code,
    cpib.name AS industry_name,
    cp.value_type_code,
    cpvt.name AS value_type_name,
    ROUND(AVG(cp.value), 2) AS avg_wage,
    cp.unit_code,
    cpu.name AS unit_name,
    cpc.code AS price_category_code,
    cpc.name AS price_category_name,
    ROUND(AVG(cpe.value), 2) AS avg_price
FROM czechia_payroll cp
LEFT JOIN czechia_payroll_industry_branch cpib 
    ON cp.industry_branch_code = cpib.code
LEFT JOIN czechia_payroll_value_type cpvt 
    ON cp.value_type_code = cpvt.code
LEFT JOIN czechia_payroll_unit cpu 
    ON cp.unit_code = cpu.code
LEFT JOIN czechia_price cpe 
    ON YEAR(cpe.date_from) = cp.payroll_year
LEFT JOIN czechia_price_category cpc 
    ON cpe.category_code = cpc.code
WHERE cp.payroll_year BETWEEN 2006 AND 2018
    AND cp.value_type_code = 5958
    AND cp.unit_code = 200
	AND cp.calculation_code = 200
    AND cp.industry_branch_code IS NOT NULL
GROUP BY cp.payroll_year, cp.industry_branch_code, cpc.code;

SELECT * FROM t_tereza_kotmelova_project_sql_primary_final;