SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);

SELECT e.*
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.department_name = 'Sales';

SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT p.*
FROM products p
JOIN (
    SELECT category_id, MAX(price) AS max_price
    FROM products
    GROUP BY category_id
) AS max_prices
ON p.category_id = max_prices.category_id AND p.price = max_prices.max_price;

SELECT e.*
FROM employees e
JOIN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
) AS top_department
ON e.department_id = top_department.department_id;

SELECT *
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
SELECT s.student_id, s.name, g.course_id, g.grade
FROM grades g
JOIN (
    SELECT course_id, MAX(grade) AS max_grade
    FROM grades
    GROUP BY course_id
) AS max_grades
  ON g.course_id = max_grades.course_id AND g.grade = max_grades.max_grade
JOIN students s ON g.student_id = s.student_id;

WITH RankedProducts AS (
    SELECT
        id,
        product_name,
        price,
        category_id,
        DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS price_rank
    FROM products
)
SELECT id, product_name, price, category_id
FROM RankedProducts
WHERE price_rank = 3;

SELECT *
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary) FROM employees
)
AND e.salary < (
    SELECT MAX(salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

