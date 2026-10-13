-- LAB SHEET 1: DDL COMMANDS (PURE MySQL)
-- Run in MySQL Workbench. Statements are demonstrated in a safe sequence.
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- 1. Create Student table
CREATE TABLE IF NOT EXISTS Student (
    Student_ID INT,
    Name VARCHAR(100),
    Age INT,
    Course VARCHAR(100),
    City VARCHAR(100)
);

-- 2. Create Employee table
CREATE TABLE IF NOT EXISTS Employee (
    Emp_ID INT,
    Emp_Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10,2)
);

-- 3. Create Department table
CREATE TABLE IF NOT EXISTS Department (
    Dept_ID INT,
    Dept_Name VARCHAR(100),
    Location VARCHAR(100)
);

-- 4. Create Product table
CREATE TABLE IF NOT EXISTS Product (
    Product_ID INT,
    Product_Name VARCHAR(100),
    Price DECIMAL(10,2),
    Quantity INT
);

-- 5. Create Customer table
CREATE TABLE IF NOT EXISTS Customer (
    Customer_ID INT,
    Customer_Name VARCHAR(100),
    Email VARCHAR(150),
    Phone VARCHAR(20)
);

-- 6. Create Course table
CREATE TABLE IF NOT EXISTS Course (
    Course_ID INT,
    Course_Name VARCHAR(100),
    Duration VARCHAR(50),
    Fees DECIMAL(10,2)
);

-- 7. Create Faculty table
CREATE TABLE IF NOT EXISTS Faculty (
    Faculty_ID INT,
    Faculty_Name VARCHAR(100),
    Subject VARCHAR(100),
    Salary DECIMAL(10,2)
);

-- 8. Create Library table
CREATE TABLE IF NOT EXISTS Library (
    Book_ID INT,
    Book_Name VARCHAR(150),
    Author VARCHAR(100),
    Price DECIMAL(10,2)
);

-- 9. Department with Primary Key (separate example table)
CREATE TABLE IF NOT EXISTS Department_PK (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Location VARCHAR(100)
);

-- 10. Student with Primary Key and NOT NULL Name (separate example)
CREATE TABLE IF NOT EXISTS Student_Constraints (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Course VARCHAR(100),
    City VARCHAR(100)
);

-- 11. Employee with UNIQUE Email (separate example)
CREATE TABLE IF NOT EXISTS Employee_Unique (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Email VARCHAR(150) UNIQUE,
    Department VARCHAR(100),
    Salary DECIMAL(10,2)
);

-- 12. Product with CHECK Price > 0 (MySQL 8.0.16+ enforces CHECK)
CREATE TABLE IF NOT EXISTS Product_Check (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Price DECIMAL(10,2) CHECK (Price > 0),
    Quantity INT
);

-- 13. ALTER: add Email and Phone to Student
ALTER TABLE Student ADD COLUMN Email VARCHAR(150);
ALTER TABLE Student ADD COLUMN Phone VARCHAR(20);

-- 14. ALTER: modify Name size/type
ALTER TABLE Student MODIFY COLUMN Name VARCHAR(150);

-- 15. Add Salary to Employee
ALTER TABLE Employee ADD COLUMN IF NOT EXISTS Salary_Bonus DECIMAL(10,2);

-- 16. Rename Student table to Student_Details
-- This changes the table name; subsequent statements use Student_Details.
RENAME TABLE Student TO Student_Details;

-- 17. Rename City column to Address (MySQL 8.0+)
ALTER TABLE Student_Details RENAME COLUMN City TO Address;

-- 18. Drop Phone and Email columns (after demonstrating their creation)
ALTER TABLE Student_Details DROP COLUMN Phone;
ALTER TABLE Student_Details DROP COLUMN Email;

-- 19. TRUNCATE example: removes all rows but keeps the table structure.
-- Run after inserting any test rows if you want to observe the effect.
TRUNCATE TABLE Student_Details;

-- 20. DROP examples requested by the sheet.
-- These tables are dropped only at the end of this lab script.
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Customer;

-- 21. Complete Student table with PRIMARY KEY, NOT NULL, UNIQUE and CHECK
CREATE TABLE IF NOT EXISTS Student_Complete (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Age INT CHECK (Age >= 16),
    Course VARCHAR(100),
    City VARCHAR(100)
);

-- 22. Suitable ALTER and DROP demonstrations
ALTER TABLE Student_Complete ADD COLUMN Phone VARCHAR(20);
ALTER TABLE Student_Complete MODIFY COLUMN Name VARCHAR(150) NOT NULL;
ALTER TABLE Student_Complete DROP COLUMN Phone;

-- Note: Course and Customer are dropped above as requested. Recreate them in Lab 2
-- before inserting data. The original Student table is now Student_Details.
