SELECT
  Id,
  Dt,
  RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthExtracted
FROM Dates;

-- Get unique Ids
SELECT DISTINCT Id
FROM MyTabel;

-- Sum of max Vals per (Id, rID)
SELECT 
    Id,
    SUM(MaxVals) AS SumOfMaxVals
FROM (
    SELECT 
        Id, 
        rID,
        MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxValsPerGroup
GROUP BY Id;

SELECT Id, Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;



SELECT t.ID, t.Item, t.Vals
FROM TestMaximum t
INNER JOIN (
    SELECT ID, MAX(Vals) AS MaxVals
    FROM TestMaximum
    GROUP BY ID
) maxVals ON t.ID = maxVals.ID AND t.Vals = maxVals.MaxVals;



SELECT 
    Id,
    SUM(MaxVals) AS SumOfMaxVals
FROM (
    SELECT 
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS MaxValsPerGroup
GROUP BY Id;




SELECT
  Id,
  a,
  b,
  CASE 
    WHEN a - b = 0 THEN ''  -- Replace zero difference with blank
    ELSE CAST(a - b AS VARCHAR(20))  -- Show difference as string
  END AS Difference
FROM TheZeroPuzzle;



SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;



SELECT AVG(UnitPrice) AS AverageUnitPrice
FROM Sales;


SELECT COUNT(*) AS TotalTransactions
FROM Sales;




SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;



SELECT Category, COUNT(*) AS NumberOfProductsSold
FROM Sales
GROUP BY Category;


SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;



SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;



SELECT 
    SaleDate,
    Product,
    QuantitySold,
    UnitPrice,
    QuantitySold * UnitPrice AS Revenue,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotalRevenue
FROM Sales
ORDER BY SaleDate;





WITH CategoryRevenue AS (
    SELECT Category, SUM(QuantitySold * UnitPrice) AS Revenue
    FROM Sales
    GROUP BY Category
),
TotalRevenue AS (
    SELECT SUM(QuantitySold * UnitPrice) AS Total FROM Sales
)
SELECT 
    cr.Category,
    cr.Revenue,
    ROUND((cr.Revenue * 100.0) / tr.Total, 2) AS PercentageContribution
FROM CategoryRevenue cr
CROSS JOIN TotalRevenue tr;



SELECT 
    s.SaleID,
    s.Product,
    s.Category,
    s.QuantitySold,
    s.UnitPrice,
    s.SaleDate,
    s.Region AS SaleRegion,
    c.CustomerName,
    c.Region AS CustomerRegion
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;




SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Region,
    c.JoinDate
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL;



SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName;




SELECT TOP 1
    c.CustomerID,
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRevenue DESC;



SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(s.SaleID) AS TotalSalesTransactions
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName;



SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;




SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;




SELECT p.ProductName, p.Category, p.SellingPrice
FROM Products p
JOIN (
    SELECT Category, AVG(SellingPrice) AS AvgSellingPrice
    FROM Products
    GROUP BY Category
) avgCat ON p.Category = avgCat.Category
WHERE p.SellingPrice > avgCat.AvgSellingPrice;


