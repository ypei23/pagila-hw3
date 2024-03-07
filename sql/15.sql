/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */
SELECT f.title, STRING_AGG(CONCAT(
            INITCAP(SPLIT_PART(a.first_name, ' ', 1)),
            INITCAP(SPLIT_PART(a.last_name, ' ', 1))
        ), 
        ', '
    )  AS actors
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE f.rating = 'G' AND c.name = 'Documentary'
GROUP BY f.film_id;
