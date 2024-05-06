WITH raw AS(
SELECT
	*,
	SUM(salary) OVER(PARTITION BY experience
ORDER BY
	experience,
	salary) AS cumulative
FROM
	Candidates),

assembl_seniors AS(
SELECT
	*
FROM
	raw
WHERE
	experience = 'Senior'
	AND cumulative < 70000),

assembl_juniors AS(
SELECT
	*
FROM
	raw
WHERE
	experience = 'Junior'
	AND cumulative <(

IF(((
	SELECT
		SUM(salary)
	FROM
		assembl_seniors)>0),
	70000-(
	SELECT
		SUM(salary)
	FROM
		assembl_seniors),
	70000)))

SELECT
	employee_id
FROM
	assembl_seniors
UNION
SELECT
	employee_id
FROM
	assembl_juniors