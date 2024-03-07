/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT c.customer_id, c.first_name, c.last_name
from customer c 
join (
    SELECT
        customer_id,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rental_date DESC) AS row_num,
        COUNT(*) FILTER (WHERE c.name = 'Action') OVER (PARTITION BY customer_id) AS action_count
    FROM rental AS r
    INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
    INNER JOIN film AS f ON i.film_id = f.film_id
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
) AS subquery on c.customer_id = subquery.customer_id
WHERE row_num <= 5 AND action_count >= 4
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(*) = 5;
