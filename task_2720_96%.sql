WITH summary AS (
SELECT
	user1,
	user2
FROM
	Friends
UNION
SELECT
	user2,
	user1
FROM
	Friends)

SELECT
	s1.user1,
	round (100 * count(DISTINCT s2.user2)/(count(s1.user1) OVER()),
	2) percentage_popularity
FROM
	summary s1
LEFT JOIN summary s2
		USING(user1)
GROUP BY
	user1
ORDER BY
	user1