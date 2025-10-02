-- Step 1: Create temporary table
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18, 2)
);

-- Step 2: Insert monthly aggregated data
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM
    Sales s
JOIN
    Products p ON s.ProductID = p.ProductID
WHERE
    YEAR(s.SaleDate) = YEAR(GETDATE())
    AND MONTH(s.SaleDate) = MONTH(GETDATE())
GROUP BY
    s.ProductID;

-- Step 3: Return result
SELECT * FROM #MonthlySales;


CREATE VIEW vw_ProductSalesSummary AS
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM
    Products p
LEFT JOIN
    Sales s ON p.ProductID = s.ProductID
GROUP BY


CREATE FUNCTION fn_GetTotalRevenueForProduct (
    @ProductID INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18, 2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;


CREATE FUNCTION fn_GetSalesByCategory (
    @Category VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        p.ProductName,
        ISNULL(SUM(s.Quantity), 0) AS TotalQuantity,
        ISNULL(SUM(s.Quantity * p.Price), 0) AS TotalRevenue
    FROM
        Products p
    LEFT JOIN
        Sales s ON p.ProductID = s.ProductID
    WHERE
        p.Category = @Category
    GROUP BY
        p.ProductName
);


CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1; -- Assume prime until proven otherwise

    -- Handle edge cases
    IF @Number IS NULL OR @Number < 2
        RETURN 'No';

    -- Check divisibility from 2 to sqrt(@Number)
    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END

    RETURN CASE WHEN @IsPrime = 1 THEN 'Yes' ELSE 'No' END;
END;


CREATE FUNCTION fn_GetNumbersBetween (
    @Start INT,
    @End INT
)
RETURNS @Numbers TABLE (
    Number INT
)
AS
BEGIN
    DECLARE @Current INT = @Start;

    WHILE @Current <= @End
    BEGIN
        INSERT INTO @Numbers (Number)
        VALUES (@Current);

        SET @Current = @Current + 1;
    END

    RETURN;
END;

-- Declare the Nth value (can also be passed as a variable or parameter in a procedure/function)
DECLARE @N INT = 2;

-- CTE with DENSE_RANK to rank distinct salaries
WITH SalaryRanks AS (
    SELECT DISTINCT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS Rank
    FROM Employee
)
SELECT salary AS NthHighestSalary
FROM SalaryRanks
WHERE Rank = @N;

SELECT TOP 1
    id,
    COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num DESC;


CREATE VIEW vw_CustomerOrderSummary AS
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name;


SELECT
    t1.RowNumber,
    COALESCE(t1.Workflow, t2.Workflow) AS Workflow
FROM
    YourTable t1
OUTER APPLY
(
    SELECT TOP 1 t3.Workflow
    FROM YourTable t3
    WHERE t3.RowNumber < t1.RowNumber
      AND t3.Workflow IS NOT NULL
      AND t3.Workflow <> ''
    ORDER BY t3.RowNumber DESC
) t2
ORDER BY
    t1.RowNumber;
