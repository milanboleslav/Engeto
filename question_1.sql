WITH question_1 AS (
SELECT
	pf.common_year,
	pf.year_salary,
	pf.prev_year_salary, 	
	pf.industry
FROM
	t_milan_boleslav_project_sql_primary_final pf
GROUP BY
	pf.common_year,
	pf.year_salary,
	pf.industry
ORDER BY
	pf.common_year,
	pf.industry
	)
SELECT
	*
FROM
	question_1
WHERE
	question_1.year_salary < question_1.prev_year_salary
	;