WITH summary AS (
SELECT
	invoice_id,
	product_id,
	quantity,
	price,
	quantity * price AS total
FROM
	Purchases
JOIN Products
		USING (product_id)
ORDER BY
	invoice_id),

score_tab AS (
SELECT
	invoice_id,
	sum(total),
	RANK() OVER(
	ORDER BY sum(total) DESC,
	invoice_id) score
FROM
	summary
GROUP BY
	invoice_id)

SELECT
	product_id,
	quantity,
	total AS price
FROM
	score_tab
JOIN summary
		USING (invoice_id)
WHERE
	score = 1