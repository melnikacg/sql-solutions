with distinct_hosts as (SELECT DISTINCT 
        CONCAT(price, room_type, host_since, zipcode, number_of_reviews) AS host_id,
        number_of_reviews,
        price
    FROM 
        airbnb_host_searches)

SELECT
	CASE
		WHEN number_of_reviews = 0 THEN 'New'
		WHEN number_of_reviews < 6 THEN 'Rising'
		WHEN number_of_reviews < 16 THEN 'Trending Up'
		WHEN number_of_reviews < 41 THEN 'Popular'
		ELSE 'Hot'
	END AS host_popularity,
	min(price) min_price,
	avg(price) avg_price,
	max(price) max_price
FROM
	distinct_hosts
GROUP BY
	host_popularity
	
