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
),
gdp AS(
SELECT
	sf.year AS gdp_year,
	sf.percent_diff AS gdp_diff
FROM
	t_milan_boleslav_project_sql_secondary_final sf
)
SELECT
	common_year,
	percent_diff_price,
	percent_diff_payroll,
	gdp_diff
FROM
	payroll
LEFT JOIN price ON
	payroll.common_year = year_for_price
LEFT JOIN gdp ON
	payroll.common_year = gdp_year
ORDER BY
	common_year;