SELECT  'Hola!'  AS tipo_nombre
FROM customers;


/* Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/

SELECT city, company_name, contact_name
	FROM customers
    WHERE city LIKE 'A%' OR city LIKE 'B%';


/*Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades que empiezan por "L".*/

SELECT customers.city, customers.company_name, customers.contact_name, COUNT(orders.order_id) AS Numero_pedidos
	FROM customers
    JOIN orders
    ON customers.customer_id = orders.customer_id
    GROUP BY customers.city, customers.company_name, customers.contact_name
    HAVING customers.city  LIKE  'L%' ;


/*Todos los clientes cuyo "country" no incluya "USA".
Nuestro objetivo es extraer los clientes que no sean de USA. Extraer el nombre de contacto, su pais y el nombre de la compañia.*/

SELECT customers.country, customers.company_name, customers.contact_name
	FROM customers
    WHERE customers.country NOT LIKE  'USA' ;



/*Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT customers.contact_name
	FROM customers
    WHERE customers.company_name NOT LIKE  '_a%' ;


/*Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD. Mostrad la ciudad 
a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). Pero importante! No debe haber 
duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. 
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT.*/

SELECT city, company_name, contact_name, 'cliente' AS Relacion
FROM customers
UNION
SELECT city, company_name, contact_name, 'provedor' AS Relacion
FROM suppliers;




/*Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".*/

SELECT * 
FROM categories
WHERE description like '%sweet%' OR description LIKE '%Sweet%';



/*Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD:

💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar dos columnas usando concat para unir dos columnas.*/

SELECT contact_name
FROM customers
UNION
SELECT concat( first_name, last_name)  
FROM employees;