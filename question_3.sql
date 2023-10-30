WITH question_3 AS (
SELECT
	pf.common_year,
	pf.name,
	sum(pf.price) AS price_actual,
	LAG (sum(pf.price),
	1) OVER (PARTITION BY pf.name
ORDER BY
	pf.common_year) AS price_prev,
	round(sum(pf.price) - LAG (sum(pf.price), 1) OVER (PARTITION BY pf.name ORDER BY pf.common_year)) / sum(pf.price) * 100 AS percent_diff
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	pf.name,
	pf.common_year
ORDER BY
	pf.common_year,
	pf.price)
SELECT
	*
FROM
	question_3
GROUP BY
	name,
	common_year
HAVING
	percent_diff IS NOT NULL
ORDER BY
	percent_diff 
;
	

