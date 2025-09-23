-- Get all distinct Distributors and Regions
WITH Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
DistributorRegion AS (
    -- Cross join to get all combinations
    SELECT d.Distributor, r.Region
    FROM Distributors d
    CROSS JOIN Regions r
)
SELECT 
    dr.Region,
    dr.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM 
    DistributorRegion dr
    LEFT JOIN #RegionSales rs
        ON rs.Distributor = dr.Distributor
        AND rs.Region = dr.Region
ORDER BY
    dr.Region,
    dr.Distributor;




SELECT m.name
FROM Employee e
JOIN Employee m ON e.managerId = m.id
GROUP BY m.id, m.name
HAVING COUNT(*) >= 5;

SELECT
    p.product_name,
    SUM(o.unit) AS unit
FROM
    Orders o
JOIN
    Products p ON o.product_id = p.product_id
WHERE
    o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY
    p.product_name
HAVING
    SUM(o.unit) >= 100
ORDER BY
    p.product_name;


WITH VendorTotals AS (
    SELECT
        CustomerID,
        Vendor,
        SUM([Count]) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID, Vendor
),
RankedVendors AS (
    SELECT
        CustomerID,
        Vendor,
        TotalOrders,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY TotalOrders DESC) AS rn
    FROM VendorTotals
)
SELECT
    CustomerID,
    Vendor
FROM RankedVendors
WHERE rn = 1;


DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;  -- Assume prime until proven otherwise

IF @Check_Prime < 2
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i <= SQRT(CONVERT(FLOAT, @Check_Prime))
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';


WITH DeviceLocationCounts AS (
    SELECT
        Device_id,
        Locations,
        COUNT(*) AS signals_at_location
    FROM Device
    GROUP BY Device_id, Locations
),
MaxLocation AS (
    SELECT
        Device_id,
        Locations AS max_signal_location,
        signals_at_location,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY signals_at_location DESC) AS rn
    FROM DeviceLocationCounts
),
DeviceSummary AS (
    SELECT
        Device_id,
        COUNT(DISTINCT Locations) AS no_of_location,
        SUM(signals_at_location) AS no_of_signals
    FROM Device
    GROUP BY Device_id
)
SELECT
    ds.Device_id,
    ds.no_of_location,
    ml.max_signal_location,
    ds.no_of_signals
FROM DeviceSummary ds
JOIN MaxLocation ml ON ds.Device_id = ml.Device_id AND ml.rn = 1
ORDER BY ds.Device_id;


SELECT 
    EmpID,
    EmpName,
    Salary
FROM 
    Employee e
WHERE 
    Salary > (
        SELECT AVG(Salary)
        FROM Employee
        WHERE DeptID = e.DeptID
    )
ORDER BY EmpID;

-- Get total count of winning numbers
DECLARE @TotalWinningNumbers INT = (SELECT COUNT(*) FROM Numbers);

WITH TicketMatches AS (
    SELECT
        t.TicketID,
        COUNT(DISTINCT t.Number) AS MatchingNumbers
    FROM Tickets t
    JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
)

SELECT
    SUM(
        CASE
            WHEN MatchingNumbers = @TotalWinningNumbers THEN 100
            WHEN MatchingNumbers > 0 THEN 10
            ELSE 0
        END
    ) AS TotalWinnings
FROM TicketMatches;
