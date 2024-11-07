-- DATAPROJECT: Logic and SQL Queries

-- 2. Show the names of all movies with a rating of 'R'.
SELECT title 
FROM film f 
WHERE rating = 'R';

-- 3. Find the names of actors who have an "actor_id" between 30 and 40.
SELECT first_name 
FROM actor a 
WHERE actor_id BETWEEN 30 AND 40;

-- 4. Get movies where the language matches the original language. (--> original_language_id only has NULL values)
SELECT title 
FROM film f 
WHERE language_id = original_language_id;

-- 5. Sort movies by duration in ascending order.
SELECT title, length 
FROM film f 
ORDER BY length ASC;

-- 6. Find the first and last names of actors whose last name contains 'Allen'.
SELECT first_name, last_name 
FROM actor a 
WHERE last_name LIKE 'ALLEN';

-- 7. Find the total number of movies in each rating category from the "film" table and show the rating along with the count.
SELECT rating, COUNT(*) AS total_films
FROM film f
GROUP BY rating;

-- 8. Find the titles of all movies that are 'PG-13' or have a duration over 3 hours in the film table.
SELECT title
FROM film f
WHERE rating = 'PG-13' OR length > 180;

-- 9. Find the variability of movie replacement costs.
SELECT STDDEV(replacement_cost)
FROM film f;

-- 10. Find the maximum and minimum duration of a movie in our database.
SELECT MAX(length) AS max_length, MIN(length) AS min_length
FROM film f;

-- 11. Find the amount of the third-to-last payment ordered by payment date.
SELECT amount
FROM payment p
ORDER BY payment_date DESC
LIMIT 1 OFFSET 2;

-- 12. Find the titles of movies in the "film" table that are not rated 'NC-17' or 'G'.
SELECT title
FROM film f
WHERE rating NOT IN ('NC-17', 'G');

-- 13. Find the average duration of movies for each rating in the film table and display the rating along with the average duration.
SELECT rating, AVG(length) AS average_length
FROM film f
GROUP BY rating;

-- 14. Find the titles of all movies that are longer than 180 minutes.
SELECT title
FROM film f
WHERE length > 180;

-- 15. How much total revenue has the company generated?
SELECT SUM(amount) AS total_income
FROM payment p;

-- 16. Show the 10 customers with the highest ID.
SELECT *
FROM customer c
ORDER BY customer_id DESC
LIMIT 10;

-- 17. Find the first and last names of actors who appear in the movie titled 'Egg Igby'.
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'EGG IGBY';

-- 18. Select all unique movie titles.
SELECT DISTINCT title
FROM film f;

-- 19. Find the titles of movies that are comedies and over 180 minutes long in the "film" table.
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;

-- 20. Find the categories of movies with an average duration over 110 minutes, and show the category name along with the average duration.
SELECT c.name AS category, AVG(f.length) AS average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

-- 21. What is the average rental duration of movies?
SELECT AVG(rental_duration) AS average_rental_duration
FROM film f;

-- 22. Create a column with the full names of all actors.
SELECT CONCAT(first_name, ' ', last_name) AS complete_name
FROM actor a;

-- 23. Number of rentals per day, sorted by rental count in descending order.
SELECT rental_date, COUNT(*) AS num_rentals
FROM rental r
GROUP BY rental_date
ORDER BY num_rentals DESC;

-- 24. Find movies with a duration above the average.
SELECT title
FROM film f
WHERE length > (SELECT AVG(length) FROM film);

-- 25. Find the number of rentals registered per month.
SELECT EXTRACT(MONTH FROM rental_date) AS month, COUNT(*) AS total_rentals
FROM rental r
GROUP BY month
ORDER BY month;

-- 26. Find the average, standard deviation, and variance of total payment amounts.
SELECT AVG(amount) AS average_payment, 
STDDEV(amount) AS standard_deviation, 
VAR_SAMP(amount) AS variance
FROM payment p;

-- 27. Which movies rent for above the average price?
SELECT title, rental_rate
FROM film f
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

-- 28. Show the IDs of actors who have appeared in more than 40 movies.
SELECT actor_id
FROM film_actor fa
GROUP BY actor_id
HAVING COUNT(film_id) > 40;

-- 29. Get all movies and, if available in inventory, show the available quantity.
SELECT f.title, COUNT(i.inventory_id) AS available_quantity
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id AND i.inventory_id IS NOT NULL
GROUP BY f.film_id;

-- 30. Get actors and the number of movies they've appeared in.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_films
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 31. Get all movies and show the actors who appeared in them, even if some movies have no associated actors.
SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id;

-- 32. Get all actors and show the movies they appeared in, even if some actors haven't appeared in any movies.
SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id;

-- 33. Get all movies and all rental records.
SELECT *
FROM film f
CROSS JOIN rental;

-- 34. Find the 5 customers who have spent the most money with us.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 35. Select all actors whose first name is 'Johnny'.
SELECT *
FROM actor a
WHERE first_name = 'JOHNNY';

-- 36. Rename the column "first_name" as Name and "last_name" as Surname.
SELECT first_name AS Name, last_name AS Surname
FROM actor a;

-- 37. Find the lowest and highest actor IDs in the actor table.
SELECT MIN(actor_id) AS lowest_id, MAX(actor_id) AS highest_id
FROM actor a;

-- 38. Count the number of actors in the "actor" table.
SELECT COUNT(*) AS total_actors
FROM actor a;

-- 39. Select all actors and sort them by last name in ascending order.
SELECT * 
FROM actor a 
ORDER BY last_name ASC;

-- 40. Select the first 5 movies from the "film" table.
SELECT * 
FROM film f 
LIMIT 5;

-- 41. Group actors by first name and count how many actors have the same first name. What is the most common name?
SELECT first_name, COUNT(*) AS count
FROM actor a
GROUP BY first_name
ORDER BY count DESC
LIMIT 1;

-- 42. Find all rentals and the names of the customers who made them.
SELECT r.rental_id, r.rental_date, c.first_name, c.last_name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id;

-- 43. Show all customers and their rentals if they exist, including those without rentals.
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;

-- 44. Perform a CROSS JOIN between the tables film and category. Does this query provide any value? Why? Write the answer after the query.
SELECT *
FROM film f
CROSS JOIN category;
-- Answer: A CROSS JOIN between film and category generates a combination of all possible movies and categories, which doesn’t provide value
-- as it does not reflect the actual relationship between a movie and its category.

-- 45. Find the actors who have participated in movies in the 'Action' category.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 46. Find all actors who have not participated in any movies. (--> all actors have participated in at least one)
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

-- 47. Select the names of actors and the number of movies in which they have participated.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS movie_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 48. Create a view called "actor_number_of_movies" that shows the names of actors and the number of movies they have participated in.
CREATE VIEW actor_number_of_movies AS
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS movie_count
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

--SELECT * FROM actor_number_of_movies;

-- 49. Calculate the total number of rentals made by each customer.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 50. Calculate the total duration of movies in the 'Action' category.
SELECT SUM(f.length) AS total_duration_in_action_films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 51. Create a temporary table called "client_rental_temporary" to store the total rentals by each customer.
CREATE TEMPORARY TABLE client_rental_temporary AS
SELECT customer_id, COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY customer_id;

-- 52. Create a temporary table called "rented_movies" to store movies that have been rented at least 10 times.
CREATE TEMPORARY TABLE rented_movies AS
SELECT film_id, COUNT(rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY film_id
HAVING COUNT(rental_id) >= 10;

-- 53. Find the title of movies rented by the customer with the name 'Tammy Sanders' that have not yet been returned. Order results alphabetically by movie title.
SELECT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'TAMMY' AND c.last_name = 'SANDERS'
  AND r.return_date IS NULL
ORDER BY f.title;

-- 54. Find the names of actors who have acted in at least one movie in the 'Sci-Fi' category. Order results alphabetically by last name.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;

-- 55. Find the first and last names of actors who have acted in movies rented after the movie 'Spartacus Cheaper' was rented for the first time. Order results alphabetically by last name.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(rental_date)
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    WHERE f.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name;

-- 56. Find the first and last names of actors who have not acted in any movies in the 'Music' category.
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fa.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
);

-- 57. Find the title of all movies that were rented for more than 8 days. (--> since intervals can't be compared with numerics, convert to seconds and then to days for comparison)
SELECT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE EXTRACT(EPOCH FROM (r.return_date - r.rental_date)) / 86400 > 8;

-- 58. Find the title of all movies that are in the same category as 'Animation'.
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.category_id = (
    SELECT c2.category_id
    FROM category c2
    WHERE c2.name = 'Animation'
);

-- 59. Find the titles of movies that have the same duration as the movie with the title 'Dancing Fever'. Order results alphabetically by movie title.
SELECT title
FROM film
WHERE length = (SELECT length FROM film WHERE title = 'DANCING FEVER')
  AND title <> 'DANCING FEVER'
ORDER BY title;

-- 60. Find the names of customers who have rented at least 7 different movies. Order results alphabetically by last name.
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    GROUP BY r.customer_id
    HAVING COUNT(DISTINCT f.film_id) >= 7
)
ORDER BY last_name, first_name;

-- 61. Find the total number of movies rented by category and display the category name along with the rental count.
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- 62. Find the number of movies by category released in 2006.
SELECT c.name AS category_name, COUNT(f.film_id) AS film_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE f.release_year = 2006
GROUP BY c.name;

-- 63. Find the total revenue generated by category, showing the category name and total revenue.
SELECT c.name AS category_name, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- 64. Find the average rental duration of movies in each category, showing the category name and average rental duration.
SELECT c.name AS category_name, AVG(f.rental_duration) AS avg_rental_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

