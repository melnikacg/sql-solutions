WITH score_table AS(
SELECT
	country,
	CONCAT(winery,
	' (',
	SUM(points),
	')') AS winery,
	DENSE_RANK() OVER(PARTITION BY country
ORDER BY
	sum(points) DESC,
	winery) score
FROM
	Wineries
GROUP BY
	country,
	winery)

SELECT
	country,
	MAX(CASE WHEN score = 1 THEN winery END) AS top_winery,
	IFNULL(MAX(CASE WHEN score = 2 THEN winery END),
	'No second winery') AS second_winery,
	IFNULL(MAX(CASE WHEN score = 3 THEN winery END),
	'No third winery') AS third_winery
FROM
	score_table
GROUP BY
	country