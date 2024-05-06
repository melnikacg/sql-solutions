WITH cte AS (
SELECT
	2018 AS Number
UNION
SELECT
	2019
UNION
SELECT
	2020),

cte2 AS (
SELECT
	Number AS report_year,
	CAST(concat(CAST(Number AS CHAR(50)),
	'-01-01') AS date) AS year_start,
	CAST(concat(CAST(Number AS CHAR(50)),
	'-12-31') AS date) AS year_end
FROM
	cte)

SELECT
	product_id,
	product_name,
	CAST(report_year AS char) report_year,
	(DATEDIFF(LEAST(year_end,
	period_end),
	GREATEST(year_start,
	period_start))+ 1)* average_daily_sales AS total_amount
FROM
	cte2 AS dates
JOIN Sales AS sales
JOIN Product AS products
		USING(product_id)
WHERE
	dates.report_year BETWEEN YEAR(period_start) AND YEAR(period_end)
ORDER BY
	product_id,
	report_year