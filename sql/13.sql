/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
WITH RankedFilms AS (
    SELECT
        actor.actor_id,
        actor.first_name,
        actor.last_name,
        film.film_id,
        film.title,
        RANK() OVER (PARTITION BY actor.actor_id ORDER BY SUM(payment.amount) DESC, film.title) AS rank,
        SUM(payment.amount) AS revenue
    FROM
        actor
    JOIN
        film_actor ON actor.actor_id = film_actor.actor_id
    JOIN
        film ON film_actor.film_id = film.film_id
    JOIN
        inventory ON film.film_id = inventory.film_id
    JOIN
        rental ON inventory.inventory_id = rental.inventory_id
    JOIN
        payment ON rental.rental_id = payment.rental_id
    GROUP BY
        actor.actor_id,
        actor.first_name,
        actor.last_name,
        film.film_id,
        film.title
)
SELECT
    actor_id,
    first_name,
    last_name,
    film_id,
    title,
    rank,
    revenue
FROM
    RankedFilms
WHERE
    rank <= 3;

