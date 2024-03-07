/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

SELECT DISTINCT
    actor.first_name || ' ' || actor.last_name AS "Actor Name"
FROM
    film_actor
JOIN
    actor ON film_actor.actor_id = actor.actor_id
JOIN
    film ON film_actor.film_id = film.film_id
WHERE
    film.film_id IN (
        SELECT
            film_id
        FROM
            film_actor
        JOIN
            actor ON film_actor.actor_id = actor.actor_id
        WHERE
            actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
    )
AND NOT
    (actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL')
order by "Actor Name";
