WITH Numbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM Numbers
    WHERE Number < 1000
)
SELECT Number
FROM Numbers
OPTION (MAXRECURSION 1000);

SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    T.TotalSales
FROM Employees E
JOIN (
    SELECT 
        EmployeeID, 
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS T ON E.EmployeeID = T.EmployeeID
ORDER BY T.TotalSales DESC;

WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT AverageSalary
FROM AvgSalaryCTE;

SELECT 
    P.ProductID,
    P.ProductName,
    T.MaxSaleAmount
FROM Products P
JOIN (
    SELECT 
        ProductID,
        MAX(SalesAmount) AS MaxSaleAmount
    FROM Sales
    GROUP BY ProductID
) AS T ON P.ProductID = T.ProductID
ORDER BY T.MaxSaleAmount DESC;


WITH DoubledNumbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number * 2
    FROM DoubledNumbers
    WHERE Number * 2 < 1000000
)
SELECT Number
FROM DoubledNumbers;

WITH SalesCountCTE AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    SC.SaleCount
FROM SalesCountCTE SC
JOIN Employees E ON SC.EmployeeID = E.EmployeeID
WHERE SC.SaleCount > 5
ORDER BY SC.SaleCount DESC;

WITH SalesOver500 AS (
    SELECT 
        ProductID,
        SalesAmount
    FROM Sales
    WHERE SalesAmount > 500
)
SELECT 
    P.ProductID,
    P.ProductName,
    S.SalesAmount
FROM SalesOver500 S
JOIN Products P ON S.ProductID = P.ProductID
ORDER BY S.SalesAmount DESC;

WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    E.Salary
FROM Employees E
CROSS JOIN AvgSalaryCTE A
WHERE E.Salary > A.AverageSalary
ORDER BY E.Salary DESC;


SELECT TOP 5
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    S.OrderCount
FROM Employees E
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) AS S ON E.EmployeeID = S.EmployeeID
ORDER BY S.OrderCount DESC;

SELECT
    P.CategoryID,
    P.CategoryName,
    COALESCE(S.TotalSales, 0) AS TotalSales
FROM Products P
LEFT JOIN (
    SELECT
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) S ON P.ProductID = S.ProductID
ORDER BY TotalSales DESC;


WITH FactorialCTE AS (
    -- Anchor member: factorial of 0 is 1
    SELECT 0 AS Number, 1 AS Factorial
    UNION ALL
    -- Recursive member: factorial of n is n * factorial of (n-1)
    SELECT n.Number + 1, (n.Number + 1) * f.Factorial
    FROM Numbers1 n
    JOIN FactorialCTE f ON n.Number = f.Number + 1
)
SELECT n.Number, f.Factorial
FROM Numbers

WITH RecursiveCTE AS (
    -- Anchor member: Start with the first character
    SELECT 1 AS Position, SUBSTRING('abcdef', 1, 1) AS Character
    UNION ALL
    -- Recursive member: Extract the next character
    SELECT Position + 1, SUBSTRING('abcdef', Position + 1, 1)
    FROM RecursiveCTE
    WHERE Position < LEN('abcdef')
)
SELECT Position, Character
FROM RecursiveCTE
ORDER BY Position;

WITH MonthlySales AS (
    SELECT
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
SalesWithPrevious AS (
    SELECT
        SaleYear,
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth) AS PreviousMonthSales
    FROM MonthlySales
)
SELECT
    SaleYear,
    SaleMonth,
    TotalSales,
    PreviousMonthSales,
    CASE
        WHEN PreviousMonthSales IS NULL THEN NULL
        ELSE TotalSales - PreviousMonthSales
    END AS SalesDifference
FROM SalesWithPrevious
ORDER BY SaleYear, SaleMonth;


SELECT e.EmployeeID, e.FirstName, e.LastName, e.DepartmentID
FROM Employees e
JOIN (
    SELECT s.EmployeeID, 
           YEAR(s.SaleDate) AS SaleYear, 
           DATEPART(QUARTER, s.SaleDate) AS SaleQuarter,
           SUM(s.SalesAmount) AS TotalSales
    FROM Sales s
    GROUP BY s.EmployeeID, YEAR(s.SaleDate), DATEPART(QUARTER, s.SaleDate)
    HAVING SUM(s.SalesAmount) > 45000
) AS QuarterlySales
ON e.EmployeeID = QuarterlySales.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.DepartmentID
HAVING COUNT(DISTINCT QuarterlySales.SaleQuarter) = 4;


WITH Fibonacci AS (
    -- Anchor member: defines the starting point
    SELECT 1 AS Position, 0 AS FibValue, 1 AS NextFibValue
    UNION ALL
    -- Recursive member: calculates the next Fibonacci number
    SELECT Position + 1, NextFibValue, FibValue + NextFibValue
    FROM Fibonacci
    WHERE Position < 15  -- Adjust the number to generate more or fewer Fibonacci numbers
)
SELECT Position, FibValue
FROM Fibonacci
OPTION (MAXRECURSION 0);  -- Removes the default recursion limit


SELECT *
FROM FindSameCharacters
WHERE Vals LIKE REPLICATE(LEFT(Vals, 1), LEN(Vals))
  AND LEN(Vals) > 1;


