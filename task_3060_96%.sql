WITH cte1 AS(
SELECT
	*,
	HOUR(TIMEDIFF(session_start,
	lag(session_end) OVER(PARTITION BY user_id
ORDER BY
	session_start))) d_d
FROM
	Sessions
WHERE
	session_type = 'Streamer'),

cte2 AS(
SELECT
	*,
	HOUR(TIMEDIFF(session_start,
	lag(session_end) OVER(PARTITION BY user_id
ORDER BY
	session_start))) d_d
FROM
	Sessions
WHERE
	session_type = 'Viewer')

SELECT
	user_id
FROM
	cte1
WHERE
	d_d <= 12
UNION

SELECT
	user_id
FROM
	cte2
WHERE
	d_d <= 12
ORDER BY
	user_id