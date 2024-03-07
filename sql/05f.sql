/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

select f2.title
from film f1
join film_actor fa1 on (f1.film_id = fa1.film_id)
join actor on (fa1.actor_id = actor.actor_id)
join film_actor fa2 on (actor.actor_id = fa2.actor_id)
join film f2 on (f2.film_id = fa2.film_id)
where f1.title = 'AMERICAN CIRCUS'

INTERSECT 

SELECT DISTINCT f.title
FROM film f
JOIN film_category fc1 ON f.film_id = fc1.film_id
JOIN film_category fc2 ON fc1.category_id = fc2.category_id
JOIN (
    SELECT film_id
    FROM film
    WHERE title = 'AMERICAN CIRCUS'
) AS ac ON fc2.film_id = ac.film_id
GROUP BY f.title
HAVING COUNT(DISTINCT fc1.category_id) = 2

union all

select 'AMERICAN CIRCUS' AS title
order by title;
