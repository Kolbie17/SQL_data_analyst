SELECT 
    p.personId,
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM 
    Person p
LEFT JOIN 
    Address a ON p.personId = a.personId;



-- Create Person table
CREATE TABLE Person (
    personId int PRIMARY KEY,
    lastName varchar(255),
    firstName varchar(255)
);

-- Create Address table
CREATE TABLE Address (
    addressId int PRIMARY KEY,
    personId int,
    city varchar(255),
    state varchar(255)
);

-- Insert data into Person
TRUNCATE TABLE Person;
INSERT INTO Person (personId, lastName, firstName) VALUES (1, 'Wang', 'Allen');
INSERT INTO Person (personId, lastName, firstName) VALUES (2, 'Alice', 'Bob');

-- Insert data into Address
TRUNCATE TABLE Address;
INSERT INTO Address (addressId, personId, city, state) VALUES (1, 2, 'New York City', 'New York');
INSERT INTO Address (addressId, personId, city, state) VALUES (2, 3, 'Leetcode', 'California');

-- Query to get the result
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM 
    Person p
LEFT JOIN 
    Address a ON p.personId = a.personId;


-- Create Employee table
CREATE TABLE Employee (
    id int PRIMARY KEY,
    name varchar(255),
    salary int,
    managerId int
);

-- Insert data into Employee
TRUNCATE TABLE Employee;
INSERT INTO Employee (id, name, salary, managerId) VALUES (1, 'Joe', 70000, 3);
INSERT INTO Employee (id, name, salary, managerId) VALUES (2, 'Henry', 80000, 4);
INSERT INTO Employee (id, name, salary, managerId) VALUES (3, 'Sam', 60000, NULL);
INSERT INTO Employee (id, name, salary, managerId) VALUES (4, 'Max', 90000, NULL);

-- Query to find employees who earn more than their managers
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;

-- Create table if not exists (SQL Server doesn't support IF NOT EXISTS directly with CREATE TABLE, so use below for demo)
IF OBJECT_ID('dbo.Person', 'U') IS NULL
BEGIN
    CREATE TABLE Person (
        id int PRIMARY KEY,
        email varchar(255)
    );
END

-- Insert data
TRUNCATE TABLE Person;
INSERT INTO Person (id, email) VALUES (1, 'a@b.com');
INSERT INTO Person (id, email) VALUES (2, 'c@d.com');
INSERT INTO Person (id, email) VALUES (3, 'a@b.com');

-- Query to find duplicate emails
SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

DELETE p
FROM Person p
JOIN Person p2
  ON p.email = p2.email
 AND p.id > p2.id;

SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (
    SELECT DISTINCT b.ParentName
    FROM boys b
);

SELECT 
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS TotalSalesAmount,
    MIN(od.Quantity) AS LeastWeight
FROM 
    Sales.Orders o
JOIN 
    Sales.OrderDetails od ON o.OrderID = od.OrderID
WHERE 
    od.Quantity > 50
GROUP BY 
    o.CustomerID;

SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM 
    Cart1 c1
FULL OUTER JOIN 
    Cart2 c2 ON c1.Item = c2.Item
ORDER BY
    COALESCE(c1.Item, c2.Item);

SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;
