CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Alice Johnson', 55000.00);
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (2, 'Bob Smith', 62000.50);
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
    (3, 'Charlie Lee', 48000.75),
    (4, 'Diana Green', 70000.00);
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;
DELETE FROM Employees
WHERE EmpID = 2;
DELETE FROM Employees WHERE EmpID = 1;
TRUNCATE TABLE Employees;
DROP TABLE Employees;
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
ALTER TABLE Employees
ADD Department VARCHAR(50);
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
TRUNCATE TABLE Employees;
DELETE FROM Employees;
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT *
FROM (VALUES
    (1, 'Human Resources'),
    (2, 'Finance'),
    (3, 'IT Support'),
    (4, 'Marketing'),
    (5, 'Sales')
) AS TempDept(DepartmentID, DepartmentName);
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;
TRUNCATE TABLE Employees;
DELETE FROM Employees;
ALTER TABLE Employees
DROP COLUMN Department;
EXEC sp_rename 'Employees', 'StaffMembers';
DROP TABLE Departments;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

