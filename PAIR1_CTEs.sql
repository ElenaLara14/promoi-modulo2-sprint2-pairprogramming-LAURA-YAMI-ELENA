-- 1.  Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
-- Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.
WITH compañia AS (SELECT company_name, customer_id
					FROM customers)
                    
SELECT *
FROM compañia;
                    
-- 2 Selecciona solo los de que vengan de "Germany"
-- Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".

WITH compañia AS (SELECT company_name, customer_id, country
					FROM customers
                   )
                    
SELECT company_name, customer_id
FROM compañia
WHERE country = 'Germany';

-- 3. Extraed el id de las facturas y su fecha de cada cliente. En este caso queremos extraer todas las facturas que se han emitido 
-- a un cliente, su fecha la compañia a la que pertenece.
-- 📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).

WITH nombre_comp AS( SELECT company_name, customer_id
						FROM customers
                        )
SELECT o.order_id, o.customer_id, o.order_date, c.company_name
FROM orders o
INNER JOIN nombre_comp c
ON o.customer_id = c.customer_id;


-- 4. Contad el número de facturas por cliente.
-- Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.

WITH nombre_comp AS( SELECT company_name, customer_id
						FROM customers
                        )
SELECT o.customer_id, c.company_name, COUNT(o.order_id) as NumFacturas
FROM orders o
INNER JOIN nombre_comp c
ON o.customer_id = c.customer_id
GROUP BY o.customer_id;

-- 5. Cuál la cantidad media pedida de todos los productos ProductID.
-- Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.

WITH suma AS (
    SELECT product_id, SUM(quantity) AS total_quantity
    FROM order_details
    GROUP BY product_id
)
SELECT AVG(o.quantity) AS media, p.product_name
FROM order_details o
JOIN suma s ON o.product_id = s.product_id
JOIN products p ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_name


/*BONUS: Estos ejercicios no es obligatorio realizarlos. Los podéis hacer más adelante para poder practicar las CTE´s.

Usando una CTE, extraer el nombre de las diferentes categorías de productos, con su precio medio, máximo y mínimo.

La empresa nos ha pedido que busquemos el nombre de cliente, su teléfono y el número de pedidos que ha hecho cada uno de ellos.

Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre del cliente y su teléfono, para aquellos clientes que hayan hecho más de 6 pedidos en el año 1998.

Modifica la consulta anterior para obtener los mismos resultados pero con los pedidos por año que ha hecho cada cliente./*
