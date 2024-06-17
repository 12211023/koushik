-- Data Definition Language (DDL)

-- 1. Create Database
CREATE DATABASE mydatabase;

-- 2. Drop Database
DROP DATABASE mydatabase;

USE mydatabase;

-- 3. Create Table
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE
);

-- 4. Drop Table
DROP TABLE employees;

-- 5. Alter Table - Add Column
ALTER TABLE employees ADD COLUMN phone_number VARCHAR(15);

-- 6. Alter Table - Modify Column
ALTER TABLE employees MODIFY COLUMN email VARCHAR(150);

-- 7. Alter Table - Drop Column
ALTER TABLE employees DROP COLUMN phone_number;

-- 8. Create Index
CREATE INDEX idx_last_name ON employees (last_name);

-- 9. Drop Index
DROP INDEX idx_last_name ON employees;

-- 10. Create View
CREATE VIEW employee_emails AS
SELECT first_name, last_name, email
FROM employees;

-- 11. Create Table with Foreign Key
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- 12. Drop View
DROP VIEW employee_emails;

-- 13. Rename Table
ALTER TABLE employees RENAME TO staff;

-- 14. Add Primary Key Constraint
ALTER TABLE employees ADD PRIMARY KEY (id);

-- 15. Add Unique Constraint
ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);


-- Data Manipulation Language (DML)

-- 16. Insert Into Table
INSERT INTO employees (id, first_name, last_name, email, hire_date)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '2023-01-01');

-- 17. Update Table
UPDATE employees
SET email = 'john.doe@newexample.com'
WHERE id = 1;

-- 18. Delete From Table
DELETE FROM employees
WHERE id = 1;

-- 19. Select From Table
SELECT * FROM employees;

-- 20. Select with Join
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- 21. Insert Multiple Rows
INSERT INTO employees (id, first_name, last_name, email, hire_date, department_id)
VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '2023-01-01', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2023-02-01', 2);

-- 22. Update with Join
UPDATE employees e
SET e.department_id = d.id
FROM departments d
WHERE e.last_name = 'Doe' AND d.department_name = 'HR';

-- 23. Delete with Condition
DELETE FROM employees
WHERE hire_date < '2023-01-01';

-- 24. Select with Aggregation
SELECT department_id, COUNT(*) AS num_employees
FROM employees
GROUP BY department_id;

-- 25. Select with Subquery
SELECT first_name, last_name
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'HR'
);
