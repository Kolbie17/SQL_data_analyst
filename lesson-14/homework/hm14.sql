SELECT
    LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS Name,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns;


SELECT *
FROM TestPercent
WHERE value LIKE '%\%%' ESCAPE '\';

SELECT
    full_string,
    SUBSTRING_INDEX(full_string, '.', 1) AS part1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(full_string, '.', 2), '.', -1) AS part2,
    SUBSTRING_INDEX(full_string, '.', -1) AS part3
FROM Splitter;

SELECT REGEXP_REPLACE('1234ABC123456XYZ1234567890ADS', '[0-9]', 'X', 'g') AS replaced_string;

SELECT *
FROM testDots
WHERE LENGTH(Vals) - LENGTH(REPLACE(Vals, '.', '')) > 2;

SELECT 
    Str,
    LENGTH(Str) - LENGTH(REPLACE(Str, ' ', '')) AS SpaceCount
FROM CountSpaces;

SELECT e.EmployeeID, e.Salary AS EmployeeSalary, m.EmployeeID AS ManagerID, m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    HireDate,
    FLOOR(DATEDIFF(CURRENT_DATE, HireDate) / 365) AS YearsOfService
FROM Employees
WHERE 
    FLOOR(DATEDIFF(CURRENT_DATE, HireDate) / 365) > 10
    AND FLOOR(DATEDIFF(CURRENT_DATE, HireDate) / 365) < 15;


SELECT
    val,
    REGEXP_REPLACE(val, '[^0-9]', '') AS only_digits,
    REGEXP_REPLACE(val, '[0-9]', '') AS only_chars
FROM TestStrings;


SELECT w1.Id, w1.Date, w1.Temperature
FROM weather w1
JOIN weather w2 ON w1.Date = DATEADD(day, 1, w2.Date)
WHERE w1.Temperature > w2.Temperature;


SELECT PlayerID, MIN(LoginDate) AS FirstLoginDate
FROM Activity
GROUP BY PlayerID;

SELECT fruit_name
FROM fruits
ORDER BY id
LIMIT 1 OFFSET 2;

-- Create the table to hold characters
CREATE TABLE CharTable (
    CharPosition INT,
    CharValue CHAR(1)
);

-- Insert each character as a separate row
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < LEN('sdgfhsdgfhs@121313131')
)
INSERT INTO CharTable (CharPosition, CharValue)
SELECT n, SUBSTRING('sdgfhsdgfhs@121313131', n, 1)
FROM Numbers
OPTION (MAXRECURSION 0);


SELECT
    p1.id,
    CASE 
        WHEN p1.code = 0 THEN p2.code
        ELSE p1.code
    END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;


SELECT
    EmployeeID,
    FirstName,
    LastName,
    HIRE_DATE,
    CASE
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;


SELECT
    vals,
    STRING_AGG(
        CASE 
            WHEN LEN(val) >= 2 THEN 
                SUBSTRING(val, 2, 1) + SUBSTRING(val, 1, 1) + SUBSTRING(val, 3, LEN(val) - 2)
            ELSE val
        END, ',') AS swapped_vals
FROM (
    SELECT vals, value AS val
    FROM MultipleVals
    CROSS APPLY STRING_SPLIT(vals, ',')
) AS split_vals
GROUP BY vals;


