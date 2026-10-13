-- LAB SHEET 3: SQL FUNCTIONS (PURE MySQL)
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
    Salary DECIMAL(10,2),
    Joining_Date DATE
);

-- Sample data (ignore duplicate-key errors if you already inserted these IDs)
INSERT IGNORE INTO Student VALUES
(101, 'Aman Sharma', 20, 'BCA', 'Meerut'),
(102, 'Riya Verma', 21, 'BBA', 'Delhi'),
(103, 'Karan Singh', 22, 'MCA', 'Noida'),
(104, 'Neha Gupta', 19, 'BCom', 'Meerut');
INSERT IGNORE INTO Employee VALUES
(201, 'Suresh Kumar', 'IT', 45500.75, '2022-05-10'),
(202, 'Priya Singh', 'HR', 38200.50, '2021-08-15'),
(203, 'Mohit Jain', 'IT', 52000.25, '2023-01-20');

-- A. Number functions
-- 1. ABS()
SELECT ABS(-25) AS Absolute_Value;
-- 2. ROUND()
SELECT ROUND(123.4567, 2) AS Rounded_Value;
-- 3. CEIL() and FLOOR()
SELECT CEIL(12.3) AS Ceiling_Value, FLOOR(12.8) AS Floor_Value;
-- 4. MOD()
SELECT MOD(17, 5) AS Remainder;
-- 5. Rounded employee salaries
SELECT Emp_Name, Salary, ROUND(Salary) AS Rounded_Salary FROM Employee;

-- B. Aggregate functions
-- 6. Count students
SELECT COUNT(*) AS Total_Students FROM Student;
-- 7. Sum of employee salaries
SELECT SUM(Salary) AS Total_Salary FROM Employee;
-- 8. Average salary
SELECT AVG(Salary) AS Average_Salary FROM Employee;
-- 9. Highest salary
SELECT MAX(Salary) AS Highest_Salary FROM Employee;
-- 10. Lowest salary
SELECT MIN(Salary) AS Lowest_Salary FROM Employee;

-- C. Character functions
-- 11. UPPER()
SELECT Name, UPPER(Name) AS Upper_Name FROM Student;
-- 12. LOWER()
SELECT Name, LOWER(Name) AS Lower_Name FROM Student;
-- 13. LENGTH() returns byte length in MySQL
SELECT Name, LENGTH(Name) AS Name_Length FROM Student;
-- 14. CONCAT() using first and last names
SELECT CONCAT('Rahul', ' ', 'Gupta') AS Full_Name;
-- 15. SUBSTRING() / SUBSTR()
SELECT Name, SUBSTRING(Name, 1, 4) AS First_Four_Characters FROM Student;
SELECT SUBSTR(Name, 1, 3) AS First_Three_Characters FROM Student;

-- D. Conversion functions
-- 16. Convert a number to a string
SELECT CAST(12345 AS CHAR) AS Number_As_String;
-- 17. Convert a string to a number
SELECT CAST('456.78' AS DECIMAL(10,2)) AS String_As_Number;
-- 18. Format a date as day/month/year
SELECT DATE_FORMAT('2026-10-13', '%d/%m/%Y') AS Formatted_Date;
-- 19. CAST()
SELECT CAST('2026-10-13' AS DATE) AS Converted_Date;
-- 20. CONVERT() in MySQL
SELECT CONVERT('789', UNSIGNED) AS Converted_Integer;

-- E. Date functions
-- 21. Current date
SELECT CURDATE() AS Current_Date;
-- 22. Extract year, month, and day
SELECT YEAR('2026-10-13') AS Year_Value,
       MONTH('2026-10-13') AS Month_Value,
       DAY('2026-10-13') AS Day_Value;
-- 23. Difference between two dates, result in days
SELECT DATEDIFF('2026-10-13', '2026-10-01') AS Difference_In_Days;
-- 24. Add days to a date
SELECT DATE_ADD('2026-10-13', INTERVAL 10 DAY) AS Date_After_10_Days;
-- 25. Display employee joining dates in a required format
SELECT Emp_Name, DATE_FORMAT(Joining_Date, '%d-%m-%Y') AS Joining_Date_Formatted
FROM Employee;
