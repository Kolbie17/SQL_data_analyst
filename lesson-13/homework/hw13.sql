SELECT CONCAT(emp_id, '-', first_name, ' ', last_name) AS employee_info
FROM employees;

UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999')
WHERE phone_number LIKE '%124%';

SELECT 
    first_name AS "First Name",
    LENGTH(first_name) AS "Name Length"
FROM 
    employees
WHERE 
    UPPER(SUBSTR(first_name, 1, 1)) IN ('A', 'J', 'M')
ORDER BY 
    first_name;

SELECT 
    manager_id,
    SUM(salary) AS total_salary
FROM 
    employees
GROUP BY 
    manager_id;

SELECT 
    year,
    GREATEST(Max1, Max2, Max3) AS highest_value
FROM 
    TestMax;

SELECT * 
FROM cinema
WHERE id % 2 = 1
  AND description != 'boring';

SELECT *
FROM SingleOrder
ORDER BY (CASE WHEN Id = 0 THEN 1 ELSE 0 END) * 1000000 + Id;

SELECT COALESCE(col1, col2, col3, col4) AS first_non_null_value
FROM person;

SELECT
  PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS Firstname,
  CASE 
    WHEN LEN(PARSENAME(REPLACE(FullName, ' ', '.'), 2)) > 0 
    THEN PARSENAME(REPLACE(FullName, ' ', '.'), 2) 
    ELSE NULL 
  END AS Middlename,
  PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS Lastname
FROM Students;

SELECT *
FROM Orders
WHERE delivery_state = 'Texas'
  AND customer_id IN (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE delivery_state = 'California'
  );

SELECT group_column, GROUP_CONCAT(value_column) AS concatenated_values
FROM DMLTable
GROUP BY group_column;

SELECT *
FROM employees
WHERE (
    LENGTH(CONCAT(first_name, last_name)) - LENGTH(REPLACE(CONCAT(first_name, last_name), 'a', ''))
) >= 3;

SELECT 
    department_id,
    COUNT(*) AS total_employees,
    ROUND(
        100.0 * SUM(CASE WHEN hire_date <= DATE_SUB(CURDATE(), INTERVAL 3 YEAR) THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS percentage_more_than_3_years
FROM employees
GROUP BY department_id;


WITH RankedExperience AS (
    SELECT
        Spaceman_ID,
        job_description,
        experience,
        ROW_NUMBER() OVER (PARTITION BY job_description ORDER BY experience DESC) AS rn_most,
        ROW_NUMBER() OVER (PARTITION BY job_description ORDER BY experience ASC) AS rn_least
    FROM Personal
)

SELECT
    job_description,
    MAX(CASE WHEN rn_most = 1 THEN Spaceman_ID END) AS Most_Experienced_Spaceman_ID,
    MAX(CASE WHEN rn_least = 1 THEN Spaceman_ID END) AS Least_Experienced_Spaceman_ID
FROM RankedExperience
GROUP BY job_description;



