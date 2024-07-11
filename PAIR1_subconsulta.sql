-- Extraed los pedidos con el máximo "order_date" para cada empleado.

--  jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada. --

SELECT order_id, customer_id,employee_id, order_date, required_date
FROM orders o1
WHERE order_date = (
 SELECT MAX( order_date)
 FROM orders o2
 WHERE o1.employee_id = o2.employee_id);
 
 


SELECT order_id,required_date, order_date
FROM orders
GROUP BY order_date DESC;

SELECT order_id ,employee_id
FROM orders;

-- Extraed el precio unitario máximo (unit_price) de cada producto vendido.

-- Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas. --

SELECT DISTINCT product_id, unit_price AS Max_Unit_price_sold
FROM order_details o1
WHERE unit_price = (
 SELECT MAX( unit_price) 
 FROM order_details o2
 WHERE o1.product_id = o2.product_id)
 ORDER BY product_id ;
 
 -- Extraed información de los productos "Beverages"

-- En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría. --

SELECT product_id, product_name, category_id
FROM products
WHERE category_id IN (
  SELECT category_id
  FROM categories
  WHERE category_name = "Beverages");
  
  
-- Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país

-- Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales.  -- 

SELECT DISTINCT country
FROM customers
WHERE country NOT IN (
  SELECT country
  FROM suppliers);


-- Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"

-- Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.-- 

SELECT order_id, customer_id
FROM orders
WHERE order_id IN (
  SELECT order_id
 FROM order_details
 WHERE product_id = 6 AND quantity >= 20);
 
 
