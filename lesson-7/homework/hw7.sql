Select min(price) as minprice
from Products;
SELECT MAX(Salary) AS MaxSalary
FROM Employees;
SELECT COUNT(*) AS TotalCustomers
FROM Customers;
SELECT COUNT(DISTINCT CategoryID) AS UniqueCategoryCount
FROM Products;
SELECT SUM(Amount) AS TotalSales
FROM Sales
WHERE ProductID = 7;
SELECT AVG(Age) AS AverageAge
FROM Employees;
SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;
SELECT CategoryID, 
       MIN(Price) AS MinPrice, 
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY CategoryID;
SELECT CustomerID, 
       SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID;
SELECT DeptID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID
HAVING COUNT(*) > 5;
SELECT p.CategoryID,
       SUM(s.Amount) AS TotalSales,
       AVG(s.Amount) AS AverageSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.CategoryID;

SELECT COUNT(*) AS HREmployeeCount
FROM Employees
WHERE Department = 'HR';
SELECT DeptID,
       MAX(Salary) AS HighestSalary,
       MIN(Salary) AS LowestSalary
FROM Employees
GROUP BY DeptID;

SELECT DeptID,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DeptID;
SELECT DeptID,
       AVG(Salary) AS AverageSalary,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID;
SELECT CategoryID,
       AVG(Price) AS AveragePrice
FROM Products
GROUP BY CategoryID
HAVING AVG(Price) > 400;
SELECT YEAR(SaleDate) AS SaleYear,
       SUM(Amount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;
SELECT DeptID
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 60000;
SELECT CategoryID,
       AVG(Price) AS AveragePrice
FROM Products
GROUP BY CategoryID
HAVING AVG(Price) > 150;
SELECT CustomerID,
       SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(Amount) > 1500;
SELECT DeptID,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 65000;











