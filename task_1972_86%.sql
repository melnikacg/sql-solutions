WITH summary AS (
SELECT
	caller_id,
	recipient_id,
	call_time
FROM
	Calls
UNION
SELECT
	recipient_id,
	caller_id,
	call_time
FROM
	Calls),

CTE_2 AS(
SELECT
	*,
	FIRST_VALUE(recipient_id) OVER(PARTITION BY caller_id,
	DATE(call_time)) f_,
	LAST_VALUE(recipient_id) OVER(PARTITION BY caller_id,
	DATE(call_time)) l_
FROM
	summary)

SELECT
	DISTINCT caller_id user_id
FROM
	CTE_2
WHERE
	f_ = l_