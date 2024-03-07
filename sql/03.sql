/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

select c.country, sum(p.amount) as total_payments
from payment p
join customer cm on cm.customer_id = p.customer_id
join address a on a.address_id = cm.address_id 
join city ct on ct.city_id = a.city_id 
join country c on c.country_id = ct.country_id
group by c.country
order by total_payments DESC, c.country;
