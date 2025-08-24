SELECT 
    Category,
    COUNT(*) AS TotalProducts
FROM 
    Products
GROUP BY 
    Category;

SELECT 
    AVG(Price) AS AveragePrice
FROM 
    Products
WHERE 
    Category = 'Electronics';
SELECT *
FROM Customers
WHERE City LIKE 'L%';
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';
SELECT *
FROM Customers
WHERE Country LIKE '%a';

SELECT MAX(Price) AS HighestPrice
FROM Products;

SELECT 
    ProductName,
    StockQuantity,
    CASE 
        WHEN StockQuantity < 30 THEN 'Low St
SELECT 
    Country,
    COUNT(*) AS TotalCustomers
FROM 
    Customers
GROUP BY 
    Country;

SELECT 
    MIN(Quantity) AS MinQuantity,
    MAX(Quantity) AS MaxQuantity
FROM 
    Orders;
SELECT DISTINCT o.CustomerID
FROM Orders o
LEFT JOIN Invoices i ON o.OrderID = i.OrderID
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
  AND i.InvoiceID IS NULL;

SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;


SELECT 
    YEAR(OrderDate) AS OrderYear,
    AVG(OrderAmount) AS AverageOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;

SELECT 
    ProductName,
    CASE
        WHEN Price < 100 THEN 'Low'
        WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
        ELSE 'High'
    END AS PriceGroup
FROM Products;

INSERT INTO population_each_year (district_id, district_name, [2012], [2013])
SELECT district_id, district_name, [2012], [2013]
FROM
(
    SELECT district_id, district_name, population, year
    FROM city_population
) AS SourceTable
PIVOT
(
    SUM(population)
    FOR year IN ([2012], [2013])
) AS PivotTable;

SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

  SELECT productname
FROM Products
WHERE productname LIKE '%oo%';

