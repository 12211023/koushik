-- Create Database
CREATE DATABASE extended_company_management;

-- Use Database
USE extended_company_management;

-- Create Table - departments
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);

-- Create Table - employees
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Insert Data into departments
INSERT INTO departments (department_name) VALUES 
('HR'),
('IT'),
('Finance');

-- Insert Data into employees
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id) VALUES 
('John', 'Doe', 'john.doe@example.com', '2023-01-01', 60000, 1),
('Jane', 'Smith', 'jane.smith@example.com', '2023-02-01', 80000, 2),
('Alice', 'Johnson', 'alice.johnson@example.com', '2023-03-01', 75000, 3),
('Bob', 'Brown', 'bob.brown@example.com', '2023-04-01', 90000, 2),
('Eve', 'Davis', 'eve.davis@example.com', '2023-05-01', 65000, 1);

-- More Transaction Control Language (TCL) Examples

-- Start a transaction and perform multiple operations
START TRANSACTION;

-- Insert a new employee
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id) 
VALUES ('Sara', 'Connor', 'sara.connor@example.com', '2024-06-17', 70000, 1);

-- Update salary of an existing employee
UPDATE employees SET salary = 85000 WHERE id = 4;

-- Commit the transaction
COMMIT;

-- Start a transaction and perform an operation with a rollback
START TRANSACTION;

-- Insert a new department
INSERT INTO departments (department_name) VALUES ('Marketing');

-- Rollback the transaction
ROLLBACK;

-- Verify the department insertion was rolled back
SELECT * FROM departments;

-- More Trigger Examples

-- Create a Trigger to log deletions from employees table
CREATE TABLE employee_deletions (
    deletion_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    deletion_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_deletions (employee_id, first_name, last_name)
    VALUES (OLD.id, OLD.first_name, OLD.last_name);
END //
DELIMITER ;

-- Delete an employee to trigger the trigger
DELETE FROM employees WHERE id = 1;

-- Verify the employee deletions log
SELECT * FROM employee_deletions;

-- More View Examples

-- Create a view for high salary employees
CREATE VIEW high_salary_employees AS
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 75000;

-- Select from the high salary employees view
SELECT * FROM high_salary_employees;

-- Create a view to show employees with their department names
CREATE VIEW employees_with_departments AS
SELECT e.id, e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- Select from the employees with departments view
SELECT * FROM employees_with_departments;

-- Create a view for recent hires
CREATE VIEW recent_hires AS
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > '2023-12-31';

-- Select from the recent hires view
SELECT * FROM recent_hires;

-- Transaction Control with multiple operations

-- Start a transaction
START TRANSACTION;

-- Insert a new employee
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id) 
VALUES ('Tom', 'Hanks', 'tom.hanks@example.com', '2024-07-01', 95000, 2);

-- Update department name
UPDATE departments SET department_name = 'Information Technology' WHERE id = 2;

-- Commit the transaction
COMMIT;

-- Start a transaction and perform multiple operations with rollback
START TRANSACTION;

-- Insert a new employee
INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id) 
VALUES ('Emma', 'Watson', 'emma.watson@example.com', '2024-08-01', 90000, 3);

-- Update employee salary
UPDATE employees SET salary = 95000 WHERE id = 5;

-- Rollback the transaction
ROLLBACK;

-- Verify the rollback
SELECT * FROM employees;

-- Complex Trigger Example to prevent salary decrease

DELIMITER //
CREATE TRIGGER prevent_salary_decrease
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < OLD.salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be decreased';
    END IF;
END //
DELIMITER ;

-- Try to update salary with a decrease (will trigger an error)
UPDATE employees SET salary = 60000 WHERE id = 2;

-- Verify no salary decrease occurred
SELECT * FROM employees;

-- More View with Calculations

-- Create a view for average salary by department
CREATE VIEW average_salary_by_department AS
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.id = e.department_id
GROUP BY d.department_name;

-- Select from the average salary by department view
SELECT * FROM average_salary_by_department;

-- Create a view for employee hire years
CREATE VIEW employee_hire_years AS
SELECT first_name, last_name, YEAR(hire_date) AS hire_year
FROM employees;

-- Select from the employee hire years view
SELECT * FROM employee_hire_years;
