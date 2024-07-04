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


