# DataProject: Lógica y Consultas SQL

<p align="center">
    <img src="https://github.com/mck21/SqlFilmRentalStore/blob/main/img/header.png" />    
</p>

<div align="center">
    <img src="https://img.shields.io/badge/postgresql-%23336791.svg?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL">
    <img src="https://img.shields.io/badge/dbeaver-%23D35400.svg?style=for-the-badge&logo=dbeaver&logoColor=white" alt="DBeaver">
</div>

<br>

Este repositorio contiene un [script](https://github.com/mck21/SqlFilmRentalStore/blob/main/query/query.sql) con consultas SQL a una base de datos postgres de una tienda de alquiler de películas.<br><br>

# Diagrama de la base de datos

<div align="center">
    <img src="https://github.com/mck21/SqlFilmRentalStore/blob/main/img/dbDiagram.png">
</div>

# Descripción de las tablas

- **actor**: contiene información sobre los actores, como sus nombres y apellidos.

- **address** (dirección): almacena las direcciones asociadas a diferentes entidades, como clientes y tiendas.

- **category** (categoría): incluye las categorías de películas, como 'comedia' o 'acción', para clasificar los títulos.

- **city** (ciudad): contiene una lista de ciudades para complementar las direcciones de clientes o tiendas.

- **country** (país): guarda los países asociados a las ciudades, proporcionando datos geográficos adicionales.

- **customer** (cliente): contiene la información de los clientes que alquilan películas, incluyendo nombres, direcciones y contactos.

- **film** (película): almacena detalles de cada película, como el título, duración, clasificación y descripción.

- **film_actor** (actor_película): tabla de relación que enlaza películas con actores, indicando en qué películas ha actuado cada actor.

- **film_category** (categoría_película): tabla de relación que enlaza películas con sus categorías.

- **inventory** (inventario): registra la cantidad de copias disponibles de cada película en cada tienda.

- **language** (idioma): guarda los idiomas en los que están disponibles las películas.

- **payment** (pago): almacena información sobre los pagos realizados por los clientes, incluyendo el monto y la fecha.

- **rental** (alquiler): contiene registros de alquileres realizados, incluyendo las películas alquiladas y las fechas de devolución.

- **staff** (empleado): guarda la información sobre el personal de las tiendas, como nombres, direcciones y datos de contacto.

- **store** (tienda): contiene detalles sobre las tiendas donde se alquilan las películas, incluyendo su ubicación y gerente.


# Paso a paso

1 > Crea una conexión PostgreSQL en DBeaver: **Database** > **New Database Connection** > **PostgreSQL**.

2 > Abre un nuevo script SQL en la conexión creada.

3 > Importa o copia el contenido de [create_db.sql](https://github.com/mck21/SqlFilmRentalStore/blob/main/schema/create_db.sql) desde el repositorio al nuevo script.

4 > Ejecuta el script para crear la base de datos (`Run` o `Ctrl + Enter`).

Listo!


