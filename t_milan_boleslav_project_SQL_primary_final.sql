CREATE OR REPLACE
TABLE t_milan_boleslav_project_SQL_primary_final AS
WITH t_payroll AS (
SELECT
	avg(cp.value) * 12 AS year_salary,
	LAG (avg(cp.value) * 12,
	1) OVER (PARTITION BY cp.industry_branch_code
ORDER BY
	cp.payroll_year) AS prev_year_salary,
		cpib.name AS industry,
		cp.payroll_year AS common_year
FROM
	czechia_payroll cp
LEFT JOIN czechia_payroll_industry_branch cpib 
		ON
	cp.industry_branch_code = cpib.code
WHERE 
		cp.calculation_code = 200
	AND cp.industry_branch_code IS NOT NULL
	AND cp.unit_code = 200
	AND cp.value_type_code = 5958
	AND cp.payroll_year >= 2006
	AND cp.payroll_year <= 2018
GROUP BY
	industry,
	common_year,
	cpib.name
),
t_price AS (
SELECT
	avg (cp.value) AS price,
		LAG (avg(cp.value),
	1) OVER (PARTITION BY cpc.name
ORDER BY
	YEAR(cp.date_from)) AS price_prev,
	cpc.name AS name,
		cpc.price_value AS price_value,
		cpc.price_unit AS goods_unit,
		YEAR(cp.date_from) AS common_year_p
FROM
	czechia_price cp
LEFT JOIN czechia_price_category cpc 
		ON
	cp.category_code = cpc.code
WHERE
	cp.region_code IS NULL
GROUP BY
	name,
	price_value,
	goods_unit,
	common_year_p)
SELECT
	common_year,
	year_salary,
	prev_year_salary,
	industry,
	name,
	price,
	price_prev,
	price_value,
	goods_unit
FROM
	t_payroll prt
LEFT JOIN t_price pct 
	ON
	prt.common_year = pct.common_year_p 
	;