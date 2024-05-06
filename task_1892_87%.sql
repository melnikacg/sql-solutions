WITH friends_full AS (
SELECT
	user1_id,
	user2_id
FROM
	Friendship
UNION
SELECT
	user2_id,
	user1_id
FROM
	Friendship),

redundant_t AS (
SELECT
	user1_id AS user_id,
	page_id,
	count(user2_id) AS friends_likes
FROM
	friends_full f_f
LEFT JOIN Likes l ON
	l.user_id = f_f.user2_id
GROUP BY
	user1_id,
	page_id
ORDER BY
	user1_id)

SELECT
	r_t.user_id,
	r_t.page_id,
	r_t.friends_likes
FROM
	redundant_t AS r_t
LEFT JOIN Likes l
		USING (user_id,
	page_id)
WHERE
	l.page_id IS NULL