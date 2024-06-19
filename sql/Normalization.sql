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
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Insert Data into departments
INSERT INTO departments (id, department_name, department_location) VALUES 
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'New York');

-- Insert Data into employees
INSERT INTO employees (id, first_name, last_name, email, hire_date, department_id) VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '2023-01-01', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2023-02-01', 2),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '2023-03-01', 3),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '2023-04-01', 2),
(5, 'Eve', 'Davis', 'eve.davis@example.com', '2023-05-01', 1);

-- Select Data from employees with department details using Inner Join
SELECT e.first_name, e.last_name, e.email, e.hire_date, d.department_name, d.department_location
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- Select Data from employees with department details using Left Join
SELECT e.first_name, e.last_name, e.email, e.hire_date;

-- normalizing it, and adding various queries to demonstrate different aspects of the normalized structure. This script starts with creating the
-- database, tables, and inserting data, ensuring the database is normalized up to the Third Normal Form (3NF).

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
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Insert Data into departments
INSERT INTO departments (id, department_name, department_location) VALUES 
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'New York');

-- Insert Data into employees
INSERT INTO employees (id, first_name, last_name, email, hire_date, department_id) VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '2023-01-01', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2023-02-01', 2),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '2023-03-01', 3),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '2023-04-01', 2),
(5, 'Eve', 'Davis', 'eve.davis@example.com', '2023-05-01', 1);

-- Query to check the data in departments
SELECT * FROM departments;

-- Query to check the data in employees
SELECT * FROM employees;

-- Normalization to 1NF, 2NF, and 3NF
-- The current structure already satisfies 1NF, 2NF, and 3NF

-- 1NF: Each table cell should contain a single value, and each record should be unique.
-- 2NF: Remove subsets of data that apply to multiple rows of a table and place them in separate tables.
-- 3NF: Remove columns that are not dependent upon the primary key.

-- Aggregate Data Example 1: Count of employees per department
SELECT d.department_name, COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.department_name;

-- Aggregate Data Example 2: Average hire date per department
SELECT d.department_name, AVG(YEAR(hire_date)) AS avg_hire_year
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.department_name;

-- Aggregate Data Example 3: Maximum and minimum hire dates per department
SELECT d.department_name, MAX(e.hire_date) AS latest_hire, MIN(e.hire_date) AS earliest_hire
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.department_name;

-- Demonstrate data integrity with FK constraints: Insert a new employee with a valid department_id
INSERT INTO employees (id, first_name, last_name, email, hire_date, department_id) VALUES 
(6, 'Mark', 'Taylor', 'mark.taylor@example.com', '2024-01-01', 3);

-- Attempt to insert a new employee with an invalid department_id (should fail)
-- Uncomment the line below to test the constraint
-- INSERT INTO employees (id, first_name, last_name, email, hire_date, department_id) VALUES 
-- (7, 'Lucy', 'Williams', 'lucy.williams@example.com', '2024-02-01', 5);

-- Demonstrate update operation: Update department location
UPDATE departments
SET department_location = 'Los Angeles'
WHERE department_name = 'IT';

-- Demonstrate delete operation: Delete a department (should fail if there are employees)
-- Uncomment the line below to test the constraint
-- DELETE FROM departments WHERE id = 1;

-- To successfully delete a department, first delete employees in that department
DELETE FROM employees WHERE department_id = 1;
DELETE FROM departments WHERE id = 1;

-- Check remaining data in departments and employees
SELECT * FROM departments;
SELECT * FROM employees;
