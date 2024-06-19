-- Create Database
CREATE DATABASE company;

-- Use Database
USE company;

-- Create Table - departments
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Create Table - employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Insert Data into departments
INSERT INTO departments (id, department_name) VALUES 
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

-- Insert Data into employees
INSERT INTO employees (id, first_name, last_name, email, hire_date, department_id) VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '2023-01-01', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2023-02-01', 2),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '2023-03-01', 3),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '2023-04-01', 2),
(5, 'Eve', 'Davis', 'eve.davis@example.com', '2023-05-01', 1);

-- Inner Join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- Left Outer Join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- Right Outer Join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- Full Outer Join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.id;

-- Self Join
SELECT a.first_name AS FirstName1, a.last_name AS LastName1,
       b.first_name AS FirstName2, b.last_name AS LastName2
FROM employees a, employees b
WHERE a.department_id = b.department_id AND a.id <> b.id;

-- Cross Join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
CROSS JOIN departments d;

-- Left Join with Null check
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.department_name IS NULL;

-- Right Join with Null check
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id
WHERE e.first_name IS NULL;

-- Join with Aggregation
SELECT d.department_name, COUNT(e.id) AS num_employees
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.department_name;

-- Join with Subquery
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'IT'
);

-- Complex Join with Multiple Conditions
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE e.hire_date > '2023-01-01' AND d.department_name = 'IT';
