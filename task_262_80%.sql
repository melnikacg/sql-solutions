WITH divident AS (
SELECT
	request_at,
	count(*) count_divident
FROM
	Trips AS trips_table
JOIN Users AS user_clients_banned ON
	trips_table.client_id = user_clients_banned.users_id
JOIN Users AS user_drivers_banned ON
	trips_table.driver_id = user_drivers_banned.users_id
WHERE
	(status = 'cancelled_by_driver'
		OR status = 'cancelled_by_client')
	AND user_clients_banned.banned = 'No'
	AND user_drivers_banned.banned = 'No'
	AND (request_at BETWEEN "2013-10-01" AND "2013-10-03")
GROUP BY
	request_at),

divisor AS (
SELECT
	request_at,
	count(*) count_divisor
FROM
	Trips AS trips_table
JOIN Users AS user_table_clients ON
	trips_table.client_id = user_table_clients.users_id
JOIN Users AS user_table_drivers ON
	trips_table.driver_id = user_table_drivers.users_id
WHERE
	user_table_clients.banned = 'No'
	AND user_table_drivers.banned = 'No'
	AND (request_at BETWEEN "2013-10-01" AND "2013-10-03")
GROUP BY
	request_at)

SELECT
	request_at AS DAY,
	round(ifnull(count_divident / count_divisor,
	0),
	2) AS 'Cancellation Rate'
FROM
	divisor
LEFT JOIN divident
		USING (request_at)