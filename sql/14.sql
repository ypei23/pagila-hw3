/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
WITH RankedFilms AS (
    SELECT
        category.name AS category,
        film.title AS title,
        COUNT(rental.rental_id) AS total_rentals,
        ROW_NUMBER() OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC, title DESC) AS ranking
    FROM
        film
    INNER JOIN
        film_category ON film.film_id = film_category.film_id
    INNER JOIN
        category ON film_category.category_id = category.category_id
    INNER JOIN
        inventory ON film.film_id = inventory.film_id
    INNER JOIN
        rental ON inventory.inventory_id = rental.inventory_id
    GROUP BY
        category.name, film.title
)
SELECT
    category as name,
    title,
    total_rentals as "total rentals"
FROM
    RankedFilms
WHERE
    ranking <= 5
ORDER BY category, "total rentals" DESC, title;
