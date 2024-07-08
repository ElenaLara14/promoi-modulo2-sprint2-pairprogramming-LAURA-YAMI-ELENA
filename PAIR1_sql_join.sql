SELECT * FROM northwind.customers;

SELECT customers.customer_id, customers.company_name, COUNT(orders.order_id) AS numpedido 
	FROM customers
	INNER JOIN orders
    ON customers.customer_id = orders.customer_id
    GROUP BY customers.customer_id, customers.company_name, customers.country
    HAVING country = 'UK';
    
    -- Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
    
    
    SELECT customers.company_name, YEAR(orders.order_date) AS anio, SUM(order_details.quantity) AS NumObjetos
    FROM customers
    INNER JOIN orders
    ON customers.customer_id = orders.customer_id
    INNER JOIN order_details
    ON orders.order_id = order_details.order_id
    GROUP BY customers.company_name, YEAR(orders.order_date);
    
    
    -- Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.
    
	SELECT customers.company_name, YEAR(orders.order_date) AS anio, SUM(order_details.quantity) AS NumObjetos, SUM((order_details.unit_price * order_details.quantity)*(1-order_details.discount)) AS DineroTotal
    FROM customers
    INNER JOIN orders
    ON customers.customer_id = orders.customer_id
    INNER JOIN order_details
    ON orders.order_id = order_details.order_id
    GROUP BY customers.company_name, YEAR(orders.order_date);
    