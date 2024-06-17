-- SQL Operators Examples

-- Arithmetic Operators

-- 1. Addition (+)
SELECT 10 + 5 AS AdditionResult;

-- 2. Subtraction (-)
SELECT 10 - 5 AS SubtractionResult;

-- 3. Multiplication (*)
SELECT 10 * 5 AS MultiplicationResult;

-- 4. Division (/)
SELECT 10 / 5 AS DivisionResult;

-- 5. Modulus (%)
SELECT 10 % 3 AS ModulusResult;

-- Comparison Operators

-- 6. Equal to (=)
SELECT *
FROM employees
WHERE department_id = 1;

-- 7. Not equal to (<>)
SELECT *
FROM employees
WHERE department_id <> 1;

-- 8. Greater than (>)
SELECT *
FROM employees
WHERE hire_date > '2023-01-01';

-- 9. Less than (<)
SELECT *
FROM employees
WHERE hire_date < '2023-01-01';

-- 10. Greater than or equal to (>=)
SELECT *
FROM employees
WHERE hire_date >= '2023-01-01';

-- 11. Less than or equal to (<=)
SELECT *
FROM employees
WHERE hire_date <= '2023-01-01';

-- Logical Operators

-- 12. AND
SELECT *
FROM employees
WHERE department_id = 1 AND hire_date > '2023-01-01';

-- 13. OR
SELECT *
FROM employees
WHERE department_id = 1 OR hire_date > '2023-01-01';

-- 14. NOT
SELECT *
FROM employees
WHERE NOT department_id = 1;

-- 15. BETWEEN
SELECT *
FROM employees
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';

-- 16. IN
SELECT *
FROM employees
WHERE department_id IN (1, 2, 3);

-- 17. LIKE
SELECT *
FROM employees
WHERE email LIKE '%@example.com';

-- 18. IS NULL
SELECT *
FROM employees
WHERE phone_number IS NULL;

-- 19. IS NOT NULL
SELECT *
FROM employees
WHERE phone_number IS NOT NULL;

-- 20. EXISTS
SELECT *
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM departments d
    WHERE e.department_id = d.id
);
