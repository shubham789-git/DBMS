-- LAB SHEET 2: DML COMMANDS (PURE MySQL)
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- Create/recreate tables needed for this lab so the script can run independently.
CREATE TABLE IF NOT EXISTS Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Course VARCHAR(100),
    City VARCHAR(100),
    Email VARCHAR(150),
    Department VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10,2),
    Email VARCHAR(150)
);
CREATE TABLE IF NOT EXISTS Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Location VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Price DECIMAL(10,2),
    Quantity INT
);
CREATE TABLE IF NOT EXISTS Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Email VARCHAR(150),
    Phone VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Duration VARCHAR(50),
    Fees DECIMAL(10,2)
);

-- 1. Insert one student
INSERT INTO Student (Student_ID, Name, Age, Course, City, Email, Department)
VALUES (101, 'Aman', 20, 'BCA', 'Meerut', 'aman@example.com', 'Computer Science');

-- 2. Insert five records using separate INSERT statements
INSERT INTO Student VALUES (102, 'Riya', 21, 'BBA', 'Delhi', 'riya@example.com', 'Management');
INSERT INTO Student VALUES (103, 'Karan', 22, 'BCA', 'Meerut', 'karan@example.com', 'Computer Science');
INSERT INTO Student VALUES (104, 'Neha', 19, 'BCom', 'Noida', 'neha@example.com', 'Commerce');
INSERT INTO Student VALUES (105, 'Vikas', 23, 'MCA', 'Delhi', 'vikas@example.com', 'Computer Science');
INSERT INTO Student VALUES (106, 'Pooja', 20, 'BCA', 'Agra', 'pooja@example.com', 'Computer Science');

-- 3. Insert multiple students with one statement
INSERT INTO Student (Student_ID, Name, Age, Course, City, Email, Department)
VALUES
(107, 'Ishita', 20, 'BBA', 'Jaipur', 'ishita@example.com', 'Management'),
(108, 'Rahul', 21, 'MCA', 'Meerut', 'rahul@example.com', 'Computer Science');

-- 4. Insert Employee records
INSERT INTO Employee VALUES
(201, 'Suresh', 'IT', 45000, 'suresh@example.com'),
(202, 'Priya', 'HR', 38000, 'priya@example.com'),
(203, 'Mohit', 'IT', 52000, 'mohit@example.com');

-- 5. Insert Department records
INSERT INTO Department VALUES
(1, 'Computer Science', 'Block A'),
(2, 'Management', 'Block B'),
(3, 'Commerce', 'Block C');

-- 6. Insert Product records
INSERT INTO Product VALUES
(301, 'Keyboard', 800, 25),
(302, 'Mouse', 400, 40),
(303, 'Monitor', 8500, 0);

-- 7. Insert Customer records
INSERT INTO Customer VALUES
(401, 'Anil Kumar', 'anil@example.com', '9876543210'),
(402, 'Sunita Sharma', 'sunita@example.com', '9876501234');

-- 8. Insert Course records
INSERT INTO Course VALUES
(501, 'BCA', '3 years', 60000),
(502, 'BBA', '3 years', 55000),
(503, 'MCA', '2 years', 90000);

-- 9. Insert a record with all columns
INSERT INTO Student (Student_ID, Name, Age, Course, City, Email, Department)
VALUES (109, 'Deepak', 22, 'BCA', 'Lucknow', 'deepak@example.com', 'Computer Science');

-- 10. Insert selected columns only (other columns become NULL)
INSERT INTO Student (Student_ID, Name, Age)
VALUES (110, 'Simran', 20);

-- 11. Update city of a particular student
UPDATE Student SET City = 'Mumbai' WHERE Student_ID = 102;

-- 12. Update salary of a particular employee
UPDATE Employee SET Salary = 48000 WHERE Emp_ID = 201;

-- 13. Increase all employee salaries by 10%
UPDATE Employee SET Salary = Salary * 1.10;

-- 14. Increase all product prices by 5%
UPDATE Product SET Price = Price * 1.05;

-- 15. Change course of a particular student
UPDATE Student SET Course = 'MCA' WHERE Student_ID = 103;

-- 16. Update employee department
UPDATE Employee SET Department = 'Finance' WHERE Emp_ID = 202;

-- 17. Change all Meerut students to Delhi
UPDATE Student SET City = 'Delhi' WHERE City = 'Meerut';

-- 18. Update fees of a particular course
UPDATE Course SET Fees = 65000 WHERE Course_ID = 501;

-- 19. Update multiple columns of a student
UPDATE Student SET Age = 21, City = 'Noida' WHERE Student_ID = 104;

-- 20. Delete a particular student by ID
DELETE FROM Student WHERE Student_ID = 110;

-- 21. Delete students from a particular city
DELETE FROM Student WHERE City = 'Agra';

-- 22. Delete employees below a specified salary
DELETE FROM Employee WHERE Salary < 30000;

-- 23. Delete products with zero quantity
DELETE FROM Product WHERE Quantity = 0;

-- 24. Delete rows using multiple conditions (example: either low price OR zero quantity)
DELETE FROM Product WHERE Price < 500 OR Quantity = 0;

-- 25. Complete INSERT, UPDATE, DELETE sequence and display after each operation
INSERT INTO Student (Student_ID, Name, Age, Course, City)
VALUES (199, 'Test Student', 18, 'BCA', 'Meerut');
SELECT * FROM Student WHERE Student_ID = 199;

UPDATE Student SET City = 'Delhi', Age = 19 WHERE Student_ID = 199;
SELECT * FROM Student WHERE Student_ID = 199;

DELETE FROM Student WHERE Student_ID = 199;
SELECT * FROM Student WHERE Student_ID = 199;

-- View final tables
SELECT * FROM Student;
SELECT * FROM Employee;
SELECT * FROM Department;
SELECT * FROM Product;
SELECT * FROM Customer;
SELECT * FROM Course;
