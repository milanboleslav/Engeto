-- Základní pohled
WITH payroll AS
(
SELECT
	DISTINCT pf.common_year,
	sum(pf.year_salary),
	sum(pf.prev_year_salary),
	round(sum(pf.year_salary) - sum(pf.prev_year_salary), 1) / sum(pf.year_salary) * 100 AS percent_diff_payroll
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	pf.common_year 
),
price AS (
SELECT
	DISTINCT pf.common_year AS year_for_price,
	sum(pf.price) AS price_actual,
	sum(pf.price_prev) AS price_prev,
	round(sum(pf.price) - sum(pf.price_prev), 1) / sum(pf.price) * 100 AS percent_diff_price
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	year_for_price
)
SELECT
	common_year,
	percent_diff_price - percent_diff_payroll AS difference
FROM
	payroll
LEFT JOIN price ON
	payroll.common_year = year_for_price
ORDER BY
	difference DESC;

-- Detailní pohled
WITH question_1 AS (
SELECT
	pf.common_year,
	pf.industry,
	pf.year_salary,	
	pf.prev_year_salary,
	round(sum(pf.year_salary) - sum(pf.prev_year_salary), 1) / sum(pf.year_salary) * 100 AS percent_diff_payroll
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	pf.common_year,
	pf.year_salary,
	pf.industry
ORDER BY
	pf.common_year,
	pf.industry
	),
	question_3 AS (
SELECT
	pf.common_year AS year_for_price,
	pf.name,
	sum(pf.price) AS price_actual,
	sum(pf.price_prev) AS price_prev,
	round(sum(pf.price) - sum(pf.price_prev), 1) / sum(pf.price) * 100 AS percent_diff
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	year_for_price,
	pf.name
ORDER BY
	year_for_price,
	pf.price)
SELECT
	*
FROM
	question_1
JOIN question_3 ON
	question_1.common_year = question_3.year_for_price
WHERE
	question_3.percent_diff - question_1.percent_diff_payroll > 10
ORDER BY
	question_3.percent_diff DESC,
	question_1.percent_diff_payroll ASC
	;