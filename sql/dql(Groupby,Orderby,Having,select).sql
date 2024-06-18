-- 1. Select all columns from the employees table
SELECT * FROM employees;

-- 2. Select specific columns from the orders table
SELECT order_id, customer_id, amount FROM orders;

-- 3. Select unique job titles from the employees table
SELECT DISTINCT job_title FROM employees;

-- 4. Select all columns from the products table where the price is greater than 50
SELECT * FROM products WHERE price > 50;

-- 5. Select customer names and order dates from the orders table for orders placed in 2023
SELECT customer_name, order_date
FROM orders
WHERE YEAR(order_date) = 2023;

-- 6. Group employees by department and count the number of employees in each department
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

-- 7. Group orders by customer and sum the total amount spent by each customer
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- 8. Group sales by product and calculate the average sale price for each product
SELECT product_id, AVG(price) AS average_price
FROM sales
GROUP BY product_id;

-- 9. Group students by class and find the highest grade in each class
SELECT class_id, MAX(grade) AS highest_grade
FROM students
GROUP BY class_id;

-- 10. Group purchases by month and sum the total amount spent in each month
SELECT MONTH(purchase_date) AS month, SUM(amount) AS total_spent
FROM purchases
GROUP BY MONTH(purchase_date);

-- 11. Order customers by the total amount they spent in descending order
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;

-- 12. Order products by the number of units sold in ascending order
SELECT product_id, SUM(units_sold) AS total_units_sold
FROM sales
GROUP BY product_id
ORDER BY total_units_sold ASC;

-- 13. Order employees by their average performance rating in descending order
SELECT employee_id, AVG(rating) AS average_rating
FROM performance_reviews
GROUP BY employee_id
ORDER BY average_rating DESC;

-- 14. Order students by their average grade in ascending order
SELECT student_id, AVG(grade) AS average_grade
FROM grades
GROUP BY student_id
ORDER BY average_grade ASC;

-- 15. Order products by their total revenue in descending order
SELECT product_id, SUM(price * units_sold) AS total_revenue
FROM sales
GROUP BY product_id
ORDER BY total_revenue DESC;

-- 16. Group sales by product and show only products with total revenue greater than 1000
SELECT product_id, SUM(price * units_sold) AS total_revenue
FROM sales
GROUP BY product_id
HAVING total_revenue > 1000;

-- 17. Group employees by department and show only departments with more than 10 employees
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING employee_count > 10;

-- 18. Group orders by customer and show only customers who spent more than 500
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > 500;

-- 19. Group students by class and show only classes with an average grade greater than 85
SELECT class_id, AVG(grade) AS average_grade
FROM students
GROUP BY class_id
HAVING average_grade > 85;

-- 20. Group purchases by month and show only months with total spending greater than 2000
SELECT MONTH(purchase_date) AS month, SUM(amount) AS total_spent
FROM purchases
GROUP BY MONTH(purchase_date)
HAVING total_spent > 2000;

-- 21. Select employee names and their departments
SELECT employee_name, department FROM employees;

-- 22. Select order IDs and order dates for orders where the amount is greater than 100
SELECT order_id, order_date FROM orders WHERE amount > 100;

-- 23. Select distinct categories from the products table
SELECT DISTINCT category FROM products;

-- 24. Select customer names and total amounts spent from orders, grouping by customer name
SELECT customer_name, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_name;

-- 25. Select product IDs and the total number of units sold, ordering by the total units sold
SELECT product_id, SUM(units_sold) AS total_units_sold
FROM sales
GROUP BY product_id
ORDER BY total_units_sold DESC;
