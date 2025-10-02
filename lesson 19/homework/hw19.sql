CREATE PROCEDURE dbo.usp_EmployeeBonus
AS
BEGIN
    -- Create temp table
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(101),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Insert data with BonusAmount calculation
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        (e.Salary * ISNULL(b.BonusPercentage, 0) / 100) AS BonusAmount
    FROM 
        Employees e
    LEFT JOIN 
        DepartmentBonus b ON e.Department = b.Department;

    -- Select all from temp table
    SELECT * FROM #EmployeeBonus;
END;
CREATE PROCEDURE dbo.usp_EmployeeBonus
AS
BEGIN
    -- Create temp table
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(101),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Insert data with BonusAmount calculation
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        (e.Salary * ISNULL(b.BonusPercentage, 0) / 100) AS BonusAmount
    FROM 
        Employees e
    LEFT JOIN 
        DepartmentBonus b ON e.Department = b.Department;

    -- Select all from temp table
    SELECT * FROM #EmployeeBonus;
END;


CREATE PROCEDURE dbo.usp_UpdateSalaryByDepartment
    @Department NVARCHAR(50),
    @IncreasePercentage DECIMAL(5,2)
AS
BEGIN
    -- Declare a table variable to hold the updated employee data
    DECLARE @UpdatedEmployees TABLE (
        EmployeeID INT,
        FullName NVARCHAR(101),
        Department NVARCHAR(50),
        OldSalary DECIMAL(10,2),
        NewSalary DECIMAL(10,2)
    );

    -- Update the salary and capture the updated data
    UPDATE e
    SET e.Salary = e.Salary * (1 + @IncreasePercentage / 100)
    OUTPUT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        deleted.Salary AS OldSalary,
        e.Salary AS NewSalary
    INTO @UpdatedEmployees
    FROM Employees e
    WHERE e.Department = @Department;

    -- Return the updated employee data
    SELECT * FROM @UpdatedEmployees;
END;

EXEC dbo.usp_UpdateSalaryByDepartment 
    @Department = 'Sales', 
    @IncreasePercentage = 10;

MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

-- When matched, update ProductName and Price
WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

-- When not matched by target, insert new products
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

-- When not matched by source, delete from target
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Output final state of Products_Current
SELECT * FROM Products_Current
ORDER BY ProductID;

SELECT
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN c.child_count = 0 THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM
    Tree t
LEFT JOIN
    (
        SELECT p_id, COUNT(*) AS child_count
        FROM Tree
        WHERE p_id IS NOT NULL
        GROUP BY p_id
    ) c ON t.id = c.p_id
ORDER BY t.id;


SELECT
    s.user_id,
    COALESCE(
        CAST(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) AS FLOAT) 
        / NULLIF(COUNT(c.action), 0), 
        0.0
    ) AS confirmation_rate
FROM
    Signups s
LEFT JOIN
    Confirmations c ON s.user_id = c.user_id
GROUP BY
    s.user_id
ORDER BY
    s.user_id;

SELECT id, name, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);


CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
