-- DATAPROJECT: Lógica y consultas SQL

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
SELECT title 
FROM film f 
WHERE rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
SELECT first_name 
FROM actor a 
WHERE actor_id BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original. (--> original_language_id solo tiene valores NULL)
SELECT title 
FROM film f 
WHERE language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
SELECT title, length 
FROM film f 
ORDER BY length ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
SELECT first_name, last_name 
FROM actor a 
WHERE last_name LIKE 'ALLEN';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
SELECT rating, COUNT(*) AS total_films
FROM film f
GROUP BY rating;

-- 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
SELECT title
FROM film f
WHERE rating = 'PG-13' OR length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT STDDEV(replacement_cost)
FROM film f;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MAX(length) AS max_length, MIN(length) AS min_length
FROM film f;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT amount
FROM payment p
ORDER BY payment_date DESC
LIMIT 1 OFFSET 2;

-- 12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
SELECT title
FROM film f
WHERE rating NOT IN ('NC-17', 'G');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT rating, AVG(length) AS average_length
FROM film f
GROUP BY rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT title
FROM film f
WHERE length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM(amount) AS total_income
FROM payment p;

-- 16. Muestra los 10 clientes con mayor valor de id.
SELECT *
FROM customer c
ORDER BY customer_id DESC
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT title
FROM film f;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT c.name AS category, AVG(f.length) AS average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(rental_duration) AS average_rental_duration
FROM film f;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT CONCAT(first_name, ' ', last_name) AS complete_name
FROM actor a;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT rental_date, COUNT(*) AS num_rentals
FROM rental r
GROUP BY rental_date
ORDER BY num_rentals DESC;

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT title
FROM film f
WHERE length > (SELECT AVG(length) FROM film);

-- 25. Averigua el número de alquileres registrados por mes.
SELECT EXTRACT(MONTH FROM rental_date) AS month, COUNT(*) AS total_rentals
FROM rental r
GROUP BY month
ORDER BY month;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT AVG(amount) AS average_payment, 
STDDEV(amount) AS standard_deviation, 
VAR_SAMP(amount) AS variance
FROM payment p;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT title, rental_rate
FROM film f
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT actor_id
FROM film_actor fa
GROUP BY actor_id
HAVING COUNT(film_id) > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
SELECT f.title, COUNT(i.inventory_id) AS available_quantity
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id AND i.inventory_id IS NOT NULL
GROUP BY f.film_id;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_films
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT *
FROM film f
CROSS JOIN rental;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT *
FROM actor a
WHERE first_name = 'JOHNNY';

-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
SELECT first_name AS Name, last_name AS Surname
FROM actor a;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT MIN(actor_id) AS lowest_id, MAX(actor_id) AS highest_id
FROM actor a;

-- 38. Cuenta cuántos actores hay en la tabla “actorˮ.
SELECT COUNT(*) AS total_actors
FROM actor a;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT * 
FROM actor a 
ORDER BY last_name ASC;

-- 40. Selecciona las primeras 5 películas de la tabla “filmˮ.
SELECT * 
FROM film f 
LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT first_name, COUNT(*) AS count
FROM actor a
GROUP BY first_name
ORDER BY count DESC
LIMIT 1;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT r.rental_id, r.rental_date, c.first_name, c.last_name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT *
FROM film f
CROSS JOIN category;
-- Respuesta: Un CROSS JOIN entre film y category genera una combinación de todas las películas y categorías posibles, lo cual no aporta valor
-- ya que no refleja la relación concreta de una película a su categoría.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas. (--> todos han participado en alguna)
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS movie_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
CREATE VIEW actor_number_of_movies AS
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS movie_count
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

--SELECT * FROM actor_number_of_movies;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT SUM(f.length) AS total_duration_in_action_films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE client_rental_temporary AS
SELECT customer_id, COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY customer_id;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT film_id, COUNT(rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY film_id
HAVING COUNT(rental_id) >= 10;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
SELECT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'TAMMY' AND c.last_name = 'SANDERS'
  AND r.return_date IS NULL
ORDER BY f.title;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
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

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fa.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
);

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días. (--> como no se pueden comparar intervals con numerics, hacemos la conversión a segundos y despues a dias para hacer la comparación)
SELECT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE EXTRACT(EPOCH FROM (r.return_date - r.rental_date)) / 86400 > 8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.category_id = (
    SELECT c2.category_id
    FROM category c2
    WHERE c2.name = 'Animation'
);

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
SELECT title
FROM film
WHERE length = (SELECT length FROM film WHERE title = 'DANCING FEVER')
  AND title <> 'DANCING FEVER'
ORDER BY title;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
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

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT c.name AS category_name, COUNT(f.film_id) AS film_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE f.release_year = 2006
GROUP BY c.category_id, c.name;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT staff.staff_id, store.store_id
FROM staff
CROSS JOIN store;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;
