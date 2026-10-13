-- LAB SHEET 5: SQL JOINS (PURE MySQL)
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- Tables are designed to support all join exercises.
CREATE TABLE IF NOT EXISTS Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Location VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Duration VARCHAR(50),
    Fees DECIMAL(10,2)
);
CREATE TABLE IF NOT EXISTS Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Course_ID INT,
    Dept_ID INT NULL
);
CREATE TABLE IF NOT EXISTS Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),
    Manager_ID INT NULL
);

-- Sample data. INSERT IGNORE lets the script be rerun without duplicate-key errors.
INSERT IGNORE INTO Department VALUES
(1, 'Computer Science', 'Block A'),
(2, 'Management', 'Block B'),
(3, 'Commerce', 'Block C'),
(4, 'Physics', 'Block D');
INSERT IGNORE INTO Course VALUES
(501, 'BCA', '3 years', 60000),
(502, 'BBA', '3 years', 55000),
(503, 'MCA', '2 years', 90000),
(504, 'BCom', '3 years', 50000);
INSERT IGNORE INTO Student VALUES
(101, 'Aman', 20, 501, 1),
(102, 'Riya', 21, 502, 2),
(103, 'Karan', 22, 503, 1),
(104, 'Neha', 19, 504, 3),
(105, 'Vikas', 23, 501, NULL);
INSERT IGNORE INTO Employee VALUES
(201, 'Suresh', 1, 60000, NULL),
(202, 'Priya', 2, 45000, 201),
(203, 'Mohit', 1, 52000, 201),
(204, 'Neelam', 3, 41000, 202);

-- 1. INNER JOIN Student and Department
SELECT s.Student_ID, s.Name, d.Dept_Name
FROM Student s
INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 2. Student names with department names
SELECT s.Name AS Student_Name, d.Dept_Name
FROM Student s
INNER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 3. Employee names with department names
SELECT e.Emp_Name, d.Dept_Name
FROM Employee e
INNER JOIN Department d ON e.Department_ID = d.Dept_ID;

-- 4. Students with course details
SELECT s.Name, c.Course_Name, c.Duration, c.Fees
FROM Student s
INNER JOIN Course c ON s.Course_ID = c.Course_ID;

-- 5. Students in a particular department
SELECT s.Name, d.Dept_Name
FROM Student s
INNER JOIN Department d ON s.Dept_ID = d.Dept_ID
WHERE d.Dept_Name = 'Computer Science';

-- 6. LEFT OUTER JOIN Student and Department
SELECT s.Name, d.Dept_Name
FROM Student s
LEFT OUTER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 7. All students, including those without a department
SELECT s.Student_ID, s.Name, d.Dept_Name
FROM Student s
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 8. RIGHT OUTER JOIN Student and Department
SELECT s.Name, d.Dept_Name
FROM Student s
RIGHT OUTER JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 9. All departments, including departments with no students
SELECT d.Dept_ID, d.Dept_Name, s.Name
FROM Department d
LEFT JOIN Student s ON s.Dept_ID = d.Dept_ID;

-- 10. Students not assigned to a department
SELECT s.Student_ID, s.Name
FROM Student s
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID
WHERE d.Dept_ID IS NULL;

-- 11. Departments having no students
SELECT d.Dept_ID, d.Dept_Name
FROM Department d
LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
WHERE s.Student_ID IS NULL;

-- 12. FULL OUTER JOIN workaround in MySQL (LEFT JOIN UNION RIGHT-side unmatched rows)
SELECT s.Student_ID, s.Name, d.Dept_ID, d.Dept_Name
FROM Student s
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID
UNION
SELECT s.Student_ID, s.Name, d.Dept_ID, d.Dept_Name
FROM Student s
RIGHT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 13. CROSS JOIN Student and Course
SELECT s.Name, c.Course_Name
FROM Student s
CROSS JOIN Course c;

-- 14. Number of possible Student-Course combinations
SELECT COUNT(*) AS Possible_Combinations
FROM Student CROSS JOIN Course;

-- 15. NATURAL JOIN: both tables must share a same-named column.
-- Student and Course share Course_ID? In this schema Student uses Course_ID, so use explicit join
-- below for comparison; create a small compatible example for NATURAL JOIN.
CREATE TABLE IF NOT EXISTS StudentCourse_Natural (
    Student_ID INT,
    Course_ID INT,
    Student_Name VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS Course_Natural (
    Course_ID INT,
    Course_Name VARCHAR(100)
);
INSERT IGNORE INTO StudentCourse_Natural VALUES
(101, 501, 'Aman'), (102, 502, 'Riya');
INSERT IGNORE INTO Course_Natural VALUES
(501, 'BCA'), (502, 'BBA'), (503, 'MCA');
SELECT * FROM StudentCourse_Natural NATURAL JOIN Course_Natural;

-- 16. Compare NATURAL JOIN and INNER JOIN
SELECT * FROM StudentCourse_Natural NATURAL JOIN Course_Natural;
SELECT sc.Student_ID, sc.Course_ID, sc.Student_Name, c.Course_Name
FROM StudentCourse_Natural sc
INNER JOIN Course_Natural c ON sc.Course_ID = c.Course_ID;

-- 17. SELF JOIN Employee to show employee-manager relationships
SELECT e.Emp_Name AS Employee, m.Emp_Name AS Manager
FROM Employee e
LEFT JOIN Employee m ON e.Manager_ID = m.Emp_ID;

-- 18. Employees along with their managers
SELECT e.Emp_ID, e.Emp_Name, m.Emp_Name AS Manager_Name
FROM Employee e
LEFT JOIN Employee m ON e.Manager_ID = m.Emp_ID;

-- 19. Join Student, Department and Course
SELECT s.Name, d.Dept_Name, c.Course_Name
FROM Student s
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID
LEFT JOIN Course c ON s.Course_ID = c.Course_ID;

-- 20. Student name, course name and department name
SELECT s.Name AS Student_Name, c.Course_Name, d.Dept_Name
FROM Student s
LEFT JOIN Course c ON s.Course_ID = c.Course_ID
LEFT JOIN Department d ON s.Dept_ID = d.Dept_ID;

-- 21. Employees earning more than the average salary of their department
SELECT e.Emp_Name, d.Dept_Name, e.Salary
FROM Employee e
JOIN Department d ON e.Department_ID = d.Dept_ID
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.Department_ID = e.Department_ID
);

-- 22. Department with the maximum number of students
SELECT d.Dept_ID, d.Dept_Name, COUNT(s.Student_ID) AS Student_Count
FROM Department d
LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
HAVING COUNT(s.Student_ID) = (
    SELECT MAX(dept_count)
    FROM (
        SELECT COUNT(*) AS dept_count
        FROM Student
        WHERE Dept_ID IS NOT NULL
        GROUP BY Dept_ID
    ) AS counts_by_department
);

-- 23. Departments and total number of students in each
SELECT d.Dept_ID, d.Dept_Name, COUNT(s.Student_ID) AS Total_Students
FROM Department d
LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
ORDER BY d.Dept_ID;

-- 24. Courses with number of enrolled students
SELECT c.Course_ID, c.Course_Name, COUNT(s.Student_ID) AS Enrolled_Students
FROM Course c
LEFT JOIN Student s ON c.Course_ID = s.Course_ID
GROUP BY c.Course_ID, c.Course_Name
ORDER BY c.Course_ID;

-- 25. Student-department-course report using INNER JOIN, LEFT JOIN, GROUP BY, aggregates
SELECT d.Dept_Name,
       c.Course_Name,
       COUNT(s.Student_ID) AS Total_Students,
       AVG(s.Age) AS Average_Student_Age
FROM Department d
LEFT JOIN Student s ON d.Dept_ID = s.Dept_ID
LEFT JOIN Course c ON s.Course_ID = c.Course_ID
GROUP BY d.Dept_ID, d.Dept_Name, c.Course_ID, c.Course_Name
ORDER BY d.Dept_Name, c.Course_Name;
