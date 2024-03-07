/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
*/



/*
with bn_0 as (
	select actor_id 
	from actor 
	where first_name = 'RUSSEL' 
	AND last_name = 'BACALL' 
), 	

bn_1 as (
SELECT a1.actor_id 
FROM actor a1 
JOIN film_actor fa1 on (a1.actor_id = fa1.actor_id)
JOIN film_actor fa2 on (fa1.film_id = fa2.film_id) 
JOIN actor a2 on (fa2.actor_id = a2.actor_id) 
WHERE a2.actor_id in (select * from bn_0) 
and a1.actor_id not in (select * from bn_0)
)


SELECT DISTINCT a1.first_name || ' ' || a1.last_name AS "Actor Name"
FROM actor a1 
JOIN film_actor fa1 on (a1.actor_id = fa1.actor_id)  
JOIN film_actor fa2 on (fa1.film_id = fa2.film_id)  
JOIN actor a2 on (fa2.actor_id = a2.actor_id) 
WHERE a2.actor_id IN (select * from bn_1)
AND a1.actor_id not in (select * from bn_0)
AND a1.actor_id not in (select * from bn_1)
order by "Actor Name";
                       
*/


with bn_0 as (
	SELECT actor_id 
	FROM actor 
	where first_name='RUSSELL' and last_name='BACALL'
),

bn_1 as (
	SELECT a1.actor_id from actor a1
	JOIN film_actor fa1 on (a1.actor_id = fa1.actor_id)
	JOIN film_actor fa2 on (fa1.film_id = fa2.film_id)
	JOIN actor a2 on (fa2.actor_id = a2.actor_id)
	where a2.actor_id in (select * from bn_0)
	and a1.actor_id not in (select * from bn_0)
)

select distinct a1.first_name || ' ' || a1.last_name as "Actor Name" from actor a1
JOIN film_actor fa1 on (a1.actor_id = fa1.actor_id)
JOIN film_actor fa2 on (fa1.film_id = fa2.film_id)
JOIN actor a2 on (fa2.actor_id = a2.actor_id)
where a2.actor_id in (select * from bn_1)
AND a1.actor_id not in (select * from bn_0)
AND a1.actor_id not in (select * from bn_1)
order by "Actor Name";
