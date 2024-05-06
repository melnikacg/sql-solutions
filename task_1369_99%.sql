SELECT
	username,
	activity,
	startDate,
	endDate
FROM
	(
	SELECT
		* ,
		ROW_NUMBER() OVER (PARTITION BY username
	ORDER BY
		startDate DESC) AS seqnum
	FROM
		UserActivity) i
WHERE
	seqnum = 2
UNION

SELECT
	*
FROM
	UserActivity
WHERE
	username IN (
	SELECT
		username
	FROM
		UserActivity
	GROUP BY
		username
	HAVING
		count(*) = 1)