SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND s2.SaleDate >= '2024-03-01'
      AND s2.SaleDate < '2024-04-01'
);

SELECT Product, TotalRevenue
FROM (
    SELECT Product, SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product
) AS ProductRevenue
WHERE TotalRevenue = (
    SELECT MAX(SUM(Quantity * Price))
    FROM #Sales
    GROUP BY Product
);

SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) AS SalesAmounts
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price)
    FROM #Sales
);



SELECT SaleMonth, SUM(TotalQuantity) AS MonthlyQuantity
FROM (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        Quantity AS TotalQuantity
    FROM #Sales
) AS MonthlyData
GROUP BY SaleMonth
ORDER BY SaleMonth;

SELECT DISTINCT c1.CustomerName
FROM #Sales c1
WHERE EXISTS (
    SELECT 1
    FROM #Sales c2
    WHERE c1.Product = c2.Product
      AND c1.CustomerName <> c2.CustomerName
);

SELECT 
    Name,
    Fruit,
    COUNT(*) AS FruitCount
FROM Fruits
GROUP BY Name, Fruit
ORDER BY Name, Fruit;


SELECT DISTINCT ParentId AS OlderPerson
FROM Family;


SELECT *
FROM #Orders o1
WHERE o1.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o2.CustomerID = o1.CustomerID
        AND o2.DeliveryState = 'CA'
);

UPDATE #residents
SET fullname = SUBSTRING(
    address,
    CHARINDEX('name=', address) + LEN('name='),
    CHARINDEX(' ', address + ' ', CHARINDEX('name=', address) + LEN('name=')) 
      - (CHARINDEX('name=', address) + LEN('name='))
)
WHERE (fullname IS NULL OR fullname = '')
  AND CHARINDEX('name=', address) > 0;


WITH RoutePaths AS
(
    -- Anchor member: start from Tashkent
    SELECT 
        CAST(DepartureCity + '->' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        ArrivalCity,
        Cost,
        RouteID,
        CAST(RouteID AS VARCHAR(MAX)) AS RouteIDs
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    
    UNION ALL
    
    -- Recursive member: join routes continuing from the last arrival city
    SELECT 
        CAST(rp.Route + '->' + r.ArrivalCity AS VARCHAR(MAX)) AS Route,
        r.ArrivalCity,
        rp.Cost + r.Cost,
        r.RouteID,
        CAST(rp.RouteIDs + ',' + CAST(r.RouteID AS VARCHAR) AS VARCHAR(MAX)) AS RouteIDs
    FROM RoutePaths rp
    INNER JOIN #Routes r ON rp.ArrivalCity = r.DepartureCity
    WHERE CHARINDEX(CAST(r.RouteID AS VARCHAR), rp.RouteIDs) = 0 -- prevent cycles
)

SELECT TOP 1 WITH TIES Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC;  -- This will return all paths with the lowest cost

-- For the most expensive route, you can do:

SELECT TOP 1 Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost DESC;

SELECT 
    ID,
    Vals,
    -- Count how many 'Product' appeared up to current row (including current row)
    COUNT(CASE WHEN Vals = 'Product' THEN 1 END) OVER (ORDER BY ID) AS ProductRank
FROM #RankingPuzzle
ORDER BY ID;


SELECT 
    EmployeeID,
    EmployeeName,
    Department,
    SalesAmount,
    SalesMonth,
    SalesYear
FROM (
    SELECT 
        *,
        AVG(SalesAmount) OVER (PARTITION BY Department) AS DeptAvgSales
    FROM #EmployeeSales
) AS Sub
WHERE SalesAmount > DeptAvgSales
ORDER BY Department, SalesAmount DESC;

SELECT DISTINCT es1.EmployeeID, es1.EmployeeName, es1.Department, es1.SalesAmount, es1.SalesMonth, es1.SalesYear
FROM #EmployeeSales es1
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales es2
    WHERE es2.SalesMonth = es1.SalesMonth
      AND es2.SalesYear = es1.SalesYear
    GROUP BY es2.SalesMonth, es2.SalesYear
    HAVING MAX(es2.SalesAmount) = es1.SalesAmount
);


WITH Months AS (
    SELECT DISTINCT SalesYear, SalesMonth
    FROM #EmployeeSales
)

SELECT DISTINCT es.EmployeeID, es.EmployeeName
FROM #EmployeeSales es
WHERE NOT EXISTS (
    SELECT 1
    FROM Months m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es2
        WHERE es2.EmployeeID = es.EmployeeID
          AND es2.SalesYear = m.SalesYear
          AND es2.SalesMonth = m.SalesMonth
    )
)
ORDER BY es.EmployeeID;

SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);


SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');


SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);


SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);

SELECT Name, ProductID
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);

SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(TotalQuantity) FROM (
        SELECT SUM(Quantity) AS TotalQuantity
        FROM Orders
        GROUP BY ProductID
    ) AS Sub
);

SELECT Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);


WITH TotalQuantities AS (
    SELECT 
        p.ProductID,
        p.Name,
        SUM(o.Quantity) AS TotalQuantity
    FROM Products p
    JOIN Orders o ON p.ProductID = o.ProductID
    GROUP BY p.ProductID, p.Name
)

SELECT ProductID, Name, TotalQuantity
FROM TotalQuantities
WHERE TotalQuantity = (SELECT MAX(TotalQuantity) FROM TotalQuantities);
