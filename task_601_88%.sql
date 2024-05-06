WITH summary AS (
SELECT
	id,
	LAG(people) OVER() people_lag,
	LAG(visit_date) OVER() date_lag,
	people people_cur,
	visit_date date_cur,
	LEAD(people) OVER() people_lead,
	LEAD(visit_date) OVER() date_lead
FROM
	stadium),

threes_id AS (
SELECT
	id-1 AS id_lag,
	date_lag,
	people_lag,
	id AS id_cur,
	date_cur,
	people_cur,
	id + 1 AS id_lead,
	date_lead,
	people_lead
FROM
	summary
WHERE
	people_lag >= 100
	AND people_cur >= 100
	AND people_lead >= 100)

SELECT
	id_lag AS id,
	date_lag AS visit_date,
	people_lag AS people
FROM
	threes_id
UNION

SELECT
	id_cur,
	date_cur,
	people_cur
FROM
	threes_id
UNION

SELECT
	id_lead,
	date_lead,
	people_lead
FROM
	threes_id
ORDER BY
	id