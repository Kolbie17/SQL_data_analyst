SELECT 
    e.EmployeeName,
    e.Salary,
    d.DepartmentName
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    e.Salary > 50000;
SELECT 
    c.FirstName,
    c.LastName,
    o.OrderDate
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    YEAR(o.OrderDate) = 2023;
SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM 
    Employees e
LEFT JOIN 
    Departments d ON e.DepartmenSELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM 
    Orders o
FULL OUTER JOIN 
    Payments p ON o.Order
tID = d.DepartmentID;

SELECT 
    s.SupplierName,
    p.ProductName
FROM 
    Suppliers s
LEFT JOIN 
    Products p ON s.SupplierID = p.SupplierID;


SELECT 
    e.EmployeeName,
    m.EmployeeName AS ManagerName
FROM 
    Employees e
LEFT JOIN 
    Employees m ON e.ManagerID = m.EmployeeI
SELECT 
    s.StudentName,
    c.CourseName
FROM 
    Enrollments e
JOIN 
    Students s ON e.StudentID = s.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID
WHERE 
    c.CourseName = 'Math 101';

SELECT 
    c.FirstName,
    c.LastName,
    o.Quantity
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.Quantity > 3;
SELECT 
    e.EmployeeName, 
    d.DepartmentName
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName = 'Human Resources';

SELECT 
    d.DepartmentName, 
    COUNT(e.EmployeeID) AS EmployeeCount
FROM 
    Departments d
JOIN 
    Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY 
    d.DepartmentName
HAVING 
    COUNT(e.EmployeeID) > 5;

SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;

SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID

SELECT 
    e1.EmployeeName AS Employee1, 
    e2.EmployeeName AS Employee2, 
    e1.ManagerID
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID
    AND e1.EmployeeID < e2.EmployeeID  -- to avoid duplicates and self-pairs
WHERE e1.ManagerID IS NOT NULL

SELECT 
    o.OrderID, 
    o.OrderDate, 
    c.FirstName, 
    c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022

SELECT 
    e.EmployeeName, 
    e.Salary, 
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' 
  AND e.Salary > 60000;

SELECT 
    o.OrderID, 
    o.OrderDate, 
    p.PaymentDate, 
    p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID;

SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

SELECT e.EmployeeName, e.Salary
FROM Employees e
JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) dept_avg ON e.DepartmentID = dept_avg.DepartmentID
WHERE e.Salary > dept_avg.AvgSalary;

SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE o.OrderDate < '2020-01-01' AND p.OrderID IS NULL;

SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;


