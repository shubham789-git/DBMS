-- LAB SHEET 4: SQL OPERATORS (PURE MySQL)
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

CREATE TABLE IF NOT EXISTS Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Course VARCHAR(100),
    City VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10,2)
);
CREATE TABLE IF NOT EXISTS Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Price DECIMAL(10,2),
    Quantity INT
);

INSERT IGNORE INTO Student VALUES
(101, 'Aman', 20, 'BCA', 'Meerut'),
(102, 'Riya', 21, 'BBA', 'Delhi'),
(103, 'Karan', 22, 'MCA', 'Meerut'),
(104, 'Neha', 19, 'BCom', 'Noida'),
(105, 'Vikas', 23, 'BCA', 'Delhi');
INSERT IGNORE INTO Employee VALUES
(201, 'Suresh', 'IT', 45000),
(202, 'Priya', 'HR', 38000),
(203, 'Mohit', 'IT', 52000),
(204, 'Neelam', 'Finance', 41000);
INSERT IGNORE INTO Product VALUES
(301, 'Keyboard', 800, 5),
(302, 'Mouse', 400, 10),
(303, 'Monitor', 8500, 0);

-- Arithmetic operators
-- 1. Addition
SELECT 10 + 5 AS Addition;
-- 2. Subtraction
SELECT 10 - 5 AS Subtraction;
-- 3. Multiplication
SELECT 10 * 5 AS Multiplication;
-- 4. Division
SELECT 10 / 5 AS Division;
-- 5. Total amount = Price * Quantity
SELECT Product_Name, Price, Quantity, Price * Quantity AS Total_Amount FROM Product;

-- Logical operators
-- 6. AND
SELECT * FROM Student WHERE Course = 'BCA' AND City = 'Meerut';
-- 7. OR
SELECT * FROM Student WHERE City = 'Meerut' OR City = 'Delhi';
-- 8. NOT
SELECT * FROM Student WHERE NOT City = 'Delhi';
-- 9. Students in a course and city
SELECT * FROM Student WHERE Course = 'BCA' AND City = 'Delhi';
-- 10. Employees in either of two departments
SELECT * FROM Employee WHERE Department = 'IT' OR Department = 'HR';

-- Comparison operators
-- 11. =
SELECT * FROM Student WHERE City = 'Meerut';
-- 12. >
SELECT * FROM Employee WHERE Salary > 40000;
-- 13. <
SELECT * FROM Student WHERE Age < 21;
-- 14. >= and <=
SELECT * FROM Employee WHERE Salary >= 40000 AND Salary <= 50000;
-- 15. <> and !=
SELECT * FROM Student WHERE City <> 'Delhi';
SELECT * FROM Student WHERE City != 'Delhi';

-- Special operators
-- 16. BETWEEN
SELECT * FROM Employee WHERE Salary BETWEEN 40000 AND 50000;
-- 17. IN
SELECT * FROM Student WHERE City IN ('Meerut', 'Delhi');
-- 18. NOT IN
SELECT * FROM Student WHERE City NOT IN ('Meerut', 'Delhi');
-- 19. LIKE names beginning with a letter
SELECT * FROM Student WHERE Name LIKE 'A%';
-- 20. IS NULL and IS NOT NULL
SELECT * FROM Student WHERE Course IS NULL;
SELECT * FROM Student WHERE Course IS NOT NULL;

-- Set operations
-- 21. UNION removes duplicates
SELECT City AS Place FROM Student WHERE City = 'Meerut'
UNION
SELECT City AS Place FROM Student WHERE City = 'Delhi';
-- 22. UNION ALL keeps duplicates
SELECT City AS Place FROM Student WHERE City = 'Meerut'
UNION ALL
SELECT City AS Place FROM Student WHERE City = 'Delhi';

-- 23. MySQL versions before 8.0.31 do not support INTERSECT.
-- Compatible MySQL workaround for intersection:
SELECT DISTINCT s1.City
FROM Student s1
INNER JOIN Student s2 ON s1.City = s2.City
WHERE s1.City = 'Meerut' AND s2.City = 'Meerut';

-- 24. MySQL versions before 8.0.31 do not support EXCEPT.
-- MySQL workaround for A EXCEPT B:
SELECT DISTINCT s1.City
FROM Student s1
WHERE s1.City IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM Student s2
    WHERE s2.City = s1.City AND s2.City = 'Delhi'
);

-- 25. Multiple operators together: BCA students in Meerut/Delhi aged at least 20
-- with a calculated product total shown in the separate product query below.
SELECT Student_ID, Name, Course, City, Age
FROM Student
WHERE Course = 'BCA'
  AND Age >= 20
  AND City IN ('Meerut', 'Delhi')
  AND Name LIKE '%a%';

SELECT Product_Name, Price, Quantity, Price * Quantity AS Total_Amount
FROM Product
WHERE Price > 500 AND Quantity > 0;
