SELECT * FROM northwind.products;

SELECT product_id, unit_price AS lowestPrice
FROM products
WHERE unit_price = (SELECT MIN(unit_price) FROM products);

SELECT product_id, unit_price AS highestPrice
FROM products
WHERE unit_price = (SELECT MAX(unit_price) FROM products);

SELECT COUNT(product_id), AVG(unit_price) AS precio_medio
FROM products;

SELECT * FROM northwind.orders;

SELECT MAX(freight)
FROM orders
WHERE ship_country = "UK";

SELECT MIN(freight)
FROM orders
WHERE ship_country = "UK";

SELECT product_id, unit_price
FROM products
WHERE unit_price > 28.87;

SELECT product_id, discontinued
FROM products
WHERE discontinued = 1;

SELECT product_id, product_name, discontinued
FROM products
WHERE discontinued = 0
ORDER BY product_id desc
LIMIT 10


SELECT * FROM northwind.orders;

SELECT employee_id, COUNT(order_id), MAX(freight)
FROM orders
GROUP BY employee_id;

SELECT shipped_date, order_id, employee_id
FROM orders
WHERE shipped_date REGEXP '0000-00-00 00:00:00'
ORDER BY employee_id;

-- el problema era que no habiamos metido en el group by el order_date y entonces no lo ordenaba por esa columna.
SELECT order_date,
       COUNT(order_id) AS num_orders,
       YEAR(order_date) AS anio,
       MONTH(order_date) AS mes,
       DAY(order_date) AS dia
FROM orders
GROUP BY order_date, YEAR(order_date), MONTH(order_date), DAY(order_date)
ORDER BY order_date;

-- Número de pedidos por mes y año: agrupe los pedidos por cada mes concreto de cada año.
SELECT order_date,
       COUNT(order_id) AS num_orders,
       YEAR(order_date) AS anio,
       MONTH(order_date) AS mes
FROM orders
GROUP BY order_date, YEAR(order_date), MONTH(order_date)
ORDER BY order_date;

-- Seleccionad las ciudades con 4 o más empleadas: Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más 
-- empleadas de cara a estudiar la apertura de nuevas oficinas.
SELECT * FROM northwind.employees;

SELECT city, COUNT(employee_id)
FROM employees
GROUP BY city, employee_id
HAVING  COUNT(employee_id) >= 4;

-- Cread una nueva columna basándonos en la cantidad monetaria: Necesitamos una consulta que clasifique los pedidos en dos categorías 
-- ("Alto" y "Bajo") en función de la cantidad monetaria total que han supuesto: por encima o por debajo de 2000 euros.
SELECT * FROM northwind.order_details;

SELECT order_id, (unit_price * quantity) AS beneficio,
    CASE
        WHEN (unit_price * quantity) < 2000 THEN 'BAJO'
        WHEN (unit_price * quantity) > 2000 THEN 'ALTO'
        ELSE 'MEDIO'
    END AS rango_beneficio
FROM 
    order_details;

