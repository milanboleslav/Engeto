CREATE OR REPLACE
TABLE t_milan_boleslav_project_SQL_secondary_final AS (
SELECT
	e.country,
	e.year,
	e.GDP,
	LAG ((e.GDP),
	1) OVER (PARTITION BY e.country
ORDER BY
	e.year) AS prev_year,
	round(e.GDP - LAG (e.GDP , 1) OVER (PARTITION BY e.country ORDER BY e.year)) / sum(e.GDP) * 100 AS percent_diff
FROM
	economies e
GROUP BY
	e.YEAR,
	e.GDP,
	e.country
HAVING
	e.country IN ('Czech Republic')
	AND e.year BETWEEN 2005 AND 2018
ORDER BY
	e.YEAR);