/* For each customer, find the movie that they have rented most recently.
 *
 * NOTE:
 * This problem can be solved with either a subquery (using techniques we've covered in class),
 * or a new type of join called a LATERAL JOIN.
 * You are not required to use LATERAL JOINs,
 * and we will not cover in class how to use them.
 * Nevertheless, they can greatly simplify your code,
 * and so I recommend that you learn to use them.
 * The website <https://linuxhint.com/postgres-lateral-join/> provides a LATERAL JOIN that solves this problem.
 * All of the subsequent problems in this homework can be solved with LATERAL JOINs
 * (or slightly less conveniently with subqueries).
 */

SELECT
    c.first_name,
    c.last_name,
    m.title,
    MAX(r.rental_date) as rental_date
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film m ON i.film_id = m.film_id
WHERE
    (r.customer_id, r.rental_date) IN (
        SELECT
            customer_id,
            MAX(rental_date) AS rental_date
        FROM
            rental
        GROUP BY
            customer_id
    )
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    m.title
ORDER BY
    c.last_name, c.first_name;
