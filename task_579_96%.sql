WITH cte1 AS(
SELECT
	* ,
	MAX(MONTH) OVER(PARTITION BY id) l_m
FROM
	Employee)

SELECT
	tab1.id,
	tab1.month,
	tab1.salary + IFNULL(tab2.salary,
	0) + IFNULL(tab3.salary,
	0) AS Salary
FROM
	cte1 AS tab1
LEFT JOIN cte1 AS tab2 ON
	tab1.id = tab2.id
	AND tab1.month = tab2.month + 1
LEFT JOIN cte1 AS tab3 ON
	tab1.id = tab3.id
	AND tab1.month = tab3.month + 2
WHERE
	tab1.month <> tab1.l_m
ORDER BY
	tab1.id,
	tab1.month DESC