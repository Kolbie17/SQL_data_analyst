SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;


SELECT
    ProductName,
    SUM(Quantity) AS TotalQuantity,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS Rank
FROM ProductSales
GROUP BY ProductName
ORDER BY Rank;


SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS ranked_sales
WHERE rn = 1;


SELECT
    SaleID,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales
ORDER BY SaleDate;


SELECT
    SaleID,
    SaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales
ORDER BY SaleDate;



SELECT
    SaleID,
    SaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (ORDER BY SaleDate)
ORDER BY SaleDate;


SELECT
    SaleID,
    ProductName,
    SaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales
ORDER BY ProductName, SaleDate;


SELECT
    SaleID,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
    CASE
        WHEN SaleAmount = 0 THEN NULL
        ELSE (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount
    END AS PercentageChangeToNext
FROM ProductSales
ORDER BY SaleDate;


SELECT
    SaleID,
    ProductName,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSaleAmount,
    CASE
        WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) = 0 THEN NULL
        ELSE CAST(SaleAmount AS FLOAT) / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
    END AS RatioToPrev
FROM ProductSales
ORDER BY ProductName, SaleDate;


SELECT
    SaleID,
    ProductName,
    SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales
ORDER BY ProductName, SaleDate;


WITH RankedSales AS (
    SELECT
        *,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSaleAmount
    FROM ProductSales
)
SELECT
    SaleID,
    ProductName,
    SaleAmount
FROM RankedSales
WHERE SaleAmount > PrevSaleAmount
ORDER BY ProductName, SaleDate;


SELECT
    SaleID,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM ProductSales
ORDER BY SaleDate;


SELECT
    SaleID,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales
ORDER BY SaleDate;


SELECT
    SaleID,
    SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales
ORDER BY SaleDate;


SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
ORDER BY SalaryRank;



SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptSalaryRank
FROM Employees1
WHERE RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) <= 2
ORDER BY Department, DeptSalaryRank;

WITH DeptMinSalary AS (
    SELECT Department, MIN(Salary) AS MinSalary
    FROM Employees1
    GROUP BY Department
)
SELECT e.*
FROM Employees1 e
JOIN DeptMinSalary d ON e.Department = d.Department AND e.Salary = d.MinSalary
ORDER BY Department;


SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS UNBOUNDED PRECEDING) AS RunningTotalSalary
FROM Employees1
ORDER BY Department, HireDate;


SELECT DISTINCT
    Department,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees1
ORDER BY Department;


SELECT DISTINCT
    Department,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary
FROM Employees1
ORDER BY Department;

SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1
ORDER BY Department, Name;


SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY HireDate 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvg3
FROM Employees1
ORDER BY HireDate;

WITH Last3Hired AS (
    SELECT TOP 3 *
    FROM Employees1
    ORDER BY HireDate DESC
)
SELECT SUM(Salary) AS SumLast3Salaries
FROM Last3Hired;
