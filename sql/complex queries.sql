-- Create Database
CREATE DATABASE company_normalized;

-- Use Database
USE company_normalized;

-- Create Table - departments
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100),
    department_location VARCHAR(100)
);

-- Create Table - employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2),
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (manager_id) REFERENCES employees(id)
);

-- Insert Data into departments
INSERT INTO departments (id, department_name, department_location) VALUES 
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'New York');

-- Insert Data into employees
INSERT INTO employees (id, first_name, last_name, email, hire_date, salary, department_id, manager_id) VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '2023-01-01', 60000, 1, NULL),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2023-02-01', 80000, 2, 1),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '2023-03-01', 75000, 3, 1),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '2023-04-01', 90000, 2, 1),
(5, 'Eve', 'Davis', 'eve.davis@example.com', '2023-05-01', 65000, 1, 2);

-- Subquery in SELECT statement to retrieve employee names along with their department names
SELECT e.first_name, e.last_name,
       (SELECT d.department_name FROM departments d WHERE d.id = e.department_id) AS department_name
FROM employees e;

-- Subquery in WHERE clause to retrieve employees who work in the 'IT' department
SELECT first_name, last_name
FROM employees
WHERE department_id = (SELECT id FROM departments WHERE department_name = 'IT');

-- Correlated Subquery to retrieve employees who earn more than the average salary of their department
SELECT e.first_name, e.last_name, e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- Subquery with EXISTS to retrieve departments that have at least one employee
SELECT department_name
FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.id);

-- Subquery with NOT EXISTS to retrieve departments that do not have any employees
SELECT department_name
FROM departments d
WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.id);

-- Subquery with IN to retrieve employees who work in 'HR' or 'Finance' departments
SELECT first_name, last_name
FROM employees
WHERE department_id IN (SELECT id FROM departments WHERE department_name IN ('HR', 'Finance'));

-- Subquery with JOIN to retrieve employees and their managers' names
SELECT e.first_name AS employee_name, e.last_name AS employee_last_name, 
       m.first_name AS manager_name, m.last_name AS manager_last_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- Subquery in HAVING clause to retrieve departments with more than the average number of employees
SELECT department_id, COUNT(*) AS num_employees
FROM employees
GROUP BY department_id
HAVING COUNT(*) > (SELECT AVG(emp_count) FROM (SELECT COUNT(*) AS emp_count FROM employees GROUP BY department_id) AS subquery);

-- Subquery in UPDATE statement to update salaries of employees who earn below the average salary
UPDATE employees
SET salary = salary * 1.10
WHERE salary < (SELECT AVG(salary) FROM employees);

-- Subquery in DELETE statement to delete employees who work in departments that are not 'IT'
DELETE FROM employees
WHERE department_id NOT IN (SELECT id FROM departments WHERE department_name = 'IT');

-- Subquery with MULTIPLE CONDITIONS to retrieve employees who have a higher salary than the average salary in their department and were hired before 2023
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = employees.department_id)
AND hire_date < '2023-01-01';

-- Subquery in FROM clause to retrieve the department with the highest average salary
SELECT department_name, avg_salary
FROM (
    SELECT d.department_name, AVG(e.salary) AS avg_salary
    FROM departments d
    JOIN employees e ON d.id = e.department_id
    GROUP BY d.department_name
) AS subquery
ORDER BY avg_salary DESC
LIMIT 1;
