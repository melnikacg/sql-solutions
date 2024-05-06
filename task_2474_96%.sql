WITH summary AS(
SELECT
	customer_id,
	YEAR(order_date) YEAR,
	sum(price) price
FROM
	Orders
GROUP BY
	customer_id,
	YEAR),

scored AS(
SELECT
	customer_id,
	YEAR,
	price,
	CASE
		WHEN LAG(YEAR) OVER(PARTITION BY customer_id
	ORDER BY
		YEAR) IS NULL THEN 0
		ELSE

LAG(YEAR) OVER(PARTITION BY customer_id
	ORDER BY
		YEAR)<> YEAR-1
	END AS exclude_gap,
	CASE
		WHEN (price <= LAG(price) OVER(PARTITION BY customer_id
	ORDER BY
		YEAR)) THEN 1
		ELSE 0
	END AS exclude_pr
FROM
	summary)

SELECT
	customer_id
FROM
	scored
GROUP BY
	customer_id
HAVING
	SUM(exclude_gap)= 0
	AND SUM(exclude_pr)= 0