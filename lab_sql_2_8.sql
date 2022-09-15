USE sakila;

-- 1.	Write a query to display for each store its store ID, city, and country.

SELECT a.store_id, city.city, coun.country
FROM sakila.store s
JOIN sakila.address a
ON s.address_id=a.address_id
JOIN sakila.city city
ON city.city_id = a.city_id
JOIN sakila.country coun
ON city.country_id = coun.country_id;

-- 2.	Write a query to display how much business, in dollars, each store brought in.
SELECT SUM(amount)
FROM sakila.payment a
JOIN sakila.staff b
ON a.staff_id = b.staff_id
GROUP BY a.staff_id;

-- 3.	Which film categories are longest?
SELECT AVG(length), c.name
FROM sakila.film a
JOIN film_category b
ON a.film_id = b.film_id
JOIN sakila.category c
ON b.category_id=c.category_id
GROUP by c.name
ORDER by AVG(length) DESC;

-- 4.	Display the most frequently rented movies in descending order.
SELECT title, COUNT(rental_id) AS "number_of_rentals"
FROM sakila.rental r
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film f USING (film_id)
GROUP BY title
ORDER by COUNT(rental_id) DESC;

-- 5.	List the top five genres in gross revenue in descending order.

SELECT cat.name, SUM(amount) AS "rental_amount"
FROM sakila.payment p
JOIN sakila.rental r USING (rental_id)
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film_category f_c USING (film_id)
JOIN sakila.category cat USING (category_id)
GROUP BY cat.name
LIMIT 5;

-- 6.	Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, i.store_id, COUNT(inventory_id) AS "number_of_copies"
FROM sakila.inventory i
JOIN sakila.film f USING (film_id)
WHERE f.title = "Academy Dinosaur" AND store_id=1;


-- 7.	Get all pairs of actors that worked together.

SELECT * from film_actor;

SELECT f_a1.actor_id, CONCAT(a1.first_name,' ', a1.last_name), f_a2.actor_id, CONCAT(a2.first_name,' ', a2.last_name), f.title
FROM sakila.film_actor f_a1
JOIN sakila.actor a1 USING (actor_id)
JOIN sakila.film_actor f_a2
ON (f_a1.actor_id <> f_a2.actor_id) AND (f_a1.film_id = f_a2.film_id)
JOIN sakila.actor a2
ON a2.actor_id=f_a2.actor_id
JOIN sakila.film f
ON f.film_id=f_a2.film_id
ORDER BY f.title;


-- 8.	Get all pairs of customers that have rented the same film more than 3 times.
-- BONUS

-- 9.	For each film, list actor that has acted in more films.
-- BONUS
