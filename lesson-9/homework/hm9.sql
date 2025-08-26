SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;

SELECT d.DepartmentName, e.EmployeeName
FROM Departments d
CROSS JOIN Employees e;
SELECT s.SupplierName, p.ProductName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;

SELECT c.CustomerName, o.OrderID
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;
SELECT s.StudentName, c.CourseName
FROM Students s
CROSS JOIN Courses c;

SELECT p.ProductName, o.OrderID
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT s.StudentName, e.CourseID
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID;

SELECT o.OrderID, p.PaymentID
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID;

SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Price > 100;

SELECT 
    e.EmployeeName, 
    d.DepartmentName
FROM 
    Employees e
CROSS JOIN 
    Departments d
WHERE 
    e.DepartmentID <> d.DepartmentID;
SELECT 
    o.OrderID,
    o.ProductID,
    o.QuantityOrdered,
    p.StockQuantity
FROM 
    Orders o
JOIN 
    Products p ON o.ProductID = p.ProductID
WHERE 
    o.QuantityOrdered > p.StockQuantity;

SELECT
    c.CustomerName,
    s.ProductID,
    s.SaleAmount
FROM
    Customers c
JOIN
    Sales s ON c.CustomerID = s.CustomerID
WHERE
    s.SaleAmount >= 500;

SELECT
    s.StudentName,
    c.CourseName
FROM
    Students s
JOIN
    Enrollments e ON s.StudentID = e.StudentID
JOIN
    Courses c ON e.CourseID = c.CourseID;
SELECT
    p.ProductName,
    s.SupplierName
FROM
    Products p
JOIN
    Suppliers s ON p.SupplierID = s.SupplierID
WHERE
    s.SupplierName LIKE '%Tech%';

SELECT
    o.OrderID,
    o.TotalAmount,
    p.PaymentAmount
FROM
    Orders o
JOIN
    Payments p ON o.OrderID = p.OrderID
WHERE
    p.PaymentAmount < o.TotalAmount;

SELECT
    e.EmployeeName,
    d.DepartmentName
FROM
    Employees e
JOIN
    Departments d ON e.DepartmentID = d.DepartmentID;

SELECT
    p.ProductName,
    c.CategoryName
FROM
    Products p
JOIN
    Categories c ON p.CategoryID = c.CategoryID
WHERE
    c.CategoryName IN ('Electronics', 'Furniture');

SELECT
    s.*
FROM
    Sales s
JOIN
    Customers c ON s.CustomerID = c.CustomerID
WHERE
    c.Country = 'USA';

SELECT
    o.*
FROM
    Orders o
JOIN
    Customers c ON o.CustomerID = c.CustomerID
WHERE
    c.Country = 'Germany'
    AND o.OrderTotal > 100;

SELECT
    e1.EmployeeName AS Employee1,
    e2.EmployeeName AS Employee2,
    e1.DepartmentID AS Dept1,
    e2.DepartmentID AS Dept2
FROM
    Employees e1
JOIN
    Employees e2 ON e1.EmployeeID <> e2.EmployeeID
WHERE
    e1.DepartmentID <> e2.DepartmentID;
SELECT
    p.PaymentID,
    p.OrderID,
    p.PaidAmount,
    o.Quantity,
    pr.Price,
    (o.Quantity * pr.Price) AS ExpectedAmount
FROM
    Payments p
JOIN
    Orders o ON p.OrderID = o.OrderID
JOIN
    Products pr ON o.ProductID = pr.ProductID
WHERE
    p.PaidAmount <> (o.Quantity * pr.Price);
