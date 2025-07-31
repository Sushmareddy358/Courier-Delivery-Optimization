-- 1. Top 3 most ordered products
SELECT p.product_id, p.name, COUNT(uo.product_id) AS order_count
FROM user_orders uo
JOIN products p ON uo.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY order_count DESC
LIMIT 3;

-- 2. Date with highest number of orders
SELECT COUNT(order_id) AS max_count, CAST(ca.time AS DATE) AS delivery_date
FROM courier_actions ca
GROUP BY delivery_date
ORDER BY max_count DESC
LIMIT 1;

-- 3. Distribution of order actions by gender
SELECT u.sex, ua.action, COUNT(*) AS action_count
FROM user_actions ua
JOIN users u ON ua.user_id = u.user_id
GROUP BY u.sex, ua.action
ORDER BY u.sex, action_count DESC;

-- 4. Count of orders handled by each courier
SELECT c.courier_id, COUNT(uo.order_id) AS orders_handled
FROM user_orders uo
JOIN couriers c ON uo.couriers_courier_id = c.courier_id
GROUP BY c.courier_id
ORDER BY orders_handled DESC;

-- 5. Orders placed by individual users
SELECT u.user_id, COUNT(uo.order_id) AS total_orders
FROM user_orders uo
JOIN users u ON uo.users_user_id = u.user_id
GROUP BY u.user_id
ORDER BY total_orders DESC;

-- 6. Average number of products per order
SELECT AVG(num_products) AS avg_products_per_order
FROM (
    SELECT order_id, COUNT(*) AS num_products
    FROM user_orders
    GROUP BY order_id
) AS product_counts;

-- 7. Product generating highest total revenue
SELECT p.name AS popular_product, SUM(p.price) AS total_revenue
FROM user_orders uo
JOIN products p ON uo.product_id = p.product_id
GROUP BY p.name
ORDER BY total_revenue DESC
LIMIT 1;

-- 8. Top products for male vs female
SELECT u.sex, p.name, COUNT(*) AS order_count
FROM user_orders uo
JOIN users u ON uo.users_user_id = u.user_id
JOIN products p ON uo.product_id = p.product_id
GROUP BY u.sex, p.name
ORDER BY u.sex, order_count DESC;

-- 9. Busiest day for orders
SELECT CAST(ca.time AS DATE) AS order_date, COUNT(*) AS total_orders
FROM courier_actions ca
GROUP BY order_date
ORDER BY total_orders DESC
LIMIT 1;

-- 10. Average delivery time per courier
SELECT ca.courier_id,
       AVG(TIMESTAMPDIFF(MINUTE, MIN(ca.time), MAX(ca.time))) AS avg_delivery_time_minutes
FROM courier_actions ca
GROUP BY ca.courier_id
ORDER BY avg_delivery_time_minutes ASC;
