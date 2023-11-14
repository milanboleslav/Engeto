WITH salary AS (
SELECT
	pf.common_year AS s_year,
	round(pf.year_salary) AS avg_salary
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	pf.common_year
HAVING
	common_year IN (2006, 2018)
),
prices AS (
SELECT 	
	common_year,
	name,
	price,
	price_value,
	goods_unit
FROM
	t_milan_boleslav_project_sql_primary_final pf
WHERE 
	(name LIKE 'Mléko%'
		OR name LIKE 'Chléb%')
	AND
	common_year IN (2006, 2018)
)
SELECT
	avg_salary,
	-- (sum(salary.year_salary)/prices.price,
	s_year,
	prices.price,
	round(avg_salary / prices.price) AS RESULT
FROM
	salary
LEFT JOIN prices ON
	common_year = s_year
GROUP BY
	s_year,
	prices.price
;

-- Detail result
WITH milk_last AS (
SELECT 
	last_value(pf.price) OVER (PARTITION BY pf.name
ORDER BY
	pf.common_year DESC) AS 'milk_last_value'
	-- 19.82
FROM
	t_milan_boleslav_project_sql_primary_final pf
WHERE
	pf.name LIKE 'Mléko%'
LIMIT 1
),
milk_first AS (
SELECT 
	first_value(pf.price) OVER (PARTITION BY pf.name
ORDER BY
	pf.common_year) AS 'milk_first_value'
	-- 14.44
FROM
	t_milan_boleslav_project_sql_primary_final pf
WHERE
	pf.name LIKE 'Mléko%'
LIMIT 1
),
chleb_last AS (
SELECT 
	last_value(pf.price) OVER (PARTITION BY pf.name
ORDER BY
	pf.common_year DESC) AS 'chleb_last_value'
FROM
	t_milan_boleslav_project_sql_primary_final pf
WHERE
	pf.name LIKE 'chleb%'
	-- 24.24
LIMIT 1
),
chleb_first AS (
SELECT 
	first_value(pf.price) OVER (PARTITION BY pf.name
ORDER BY
	pf.common_year) AS 'chleb_first_value'
	-- 16.12
FROM
	t_milan_boleslav_project_sql_primary_final pf
WHERE
	pf.name LIKE 'chleb%'
LIMIT 1
),
first_year AS (
SELECT
	pf.common_year,
	pf.industry,
	first_value (pf.year_salary) OVER (PARTITION BY pf.industry
ORDER BY
	pf.common_year) AS first_year_income
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	pf.common_year,
	pf.industry
HAVING
	pf.common_year = 2006
),
last_year AS (
SELECT
	pf.common_year,
	pf.industry,
	pf.year_salary,
	last_value (pf.year_salary) OVER (PARTITION BY pf.industry
ORDER BY
	pf.common_year DESC) AS last_year_income
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	pf.common_year,
	pf.industry
HAVING
	pf.common_year = 2018
)
SELECT
	fy.industry,
	'In first year was income:',
	first_year_income,
	'In last year was income:',
	last_year_income,
	'In first year you can buy:',
	round(first_year_income / milk_first_value) AS pcs_milk_first_year,
	'pieces of milk',
	'In last year you can buy:',
	round(last_year_income / milk_last_value) AS pcs_milk_last_year,
	'pieces of  milk',
	'In first year you can buy:',
	round(first_year_income / chleb_first_value) AS pcs_bread_first_year,
	'pieces of bread',
	'In last year you can buy:',
	round(last_year_income / chleb_last_value) AS pcs_bread_last_year,
	'pieces of bread'
FROM
	milk_first
JOIN milk_last
JOIN chleb_last
JOIN chleb_first
JOIN first_year AS fy
JOIN last_year AS ly ON
	fy.industry = ly.industry
GROUP BY
	fy.industry,
	first_year_income,
	last_year_income;