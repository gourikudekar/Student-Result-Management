create database project;
use project;

CREATE TABLE Students (
  StudentID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  RollNumber VARCHAR(20) NOT NULL UNIQUE,
  DateOfBirth DATE,
  EnrollmentYr YEAR NOT NULL
);

CREATE TABLE Courses (
  CourseID INT AUTO_INCREMENT PRIMARY KEY,
  CourseCode VARCHAR(10) NOT NULL UNIQUE,
  CourseName VARCHAR(100) NOT NULL,
  Credits TINYINT UNSIGNED NOT NULL
);

CREATE TABLE Semesters (
  SemesterID INT AUTO_INCREMENT PRIMARY KEY,
  Term ENUM('Spring','Summer','Fall') NOT NULL,
  AcadYear VARCHAR(9) NOT NULL,
  UNIQUE(Term, AcadYear)
);

CREATE TABLE Grades (
  GradeID INT AUTO_INCREMENT PRIMARY KEY,
  StudentID INT NOT NULL,
  CourseID INT NOT NULL,
  SemesterID INT NOT NULL,
  Marks TINYINT NOT NULL CHECK (Marks BETWEEN 0 AND 100),
  Grade CHAR(2) NOT NULL,
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (SemesterID) REFERENCES Semesters(SemesterID) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO Students (Name, RollNumber, DateOfBirth, EnrollmentYr) VALUES
('Aanya Sharma', 'CS2024001', '2003-05-12', 2024),
('Rohan Mehta', 'CS2024002', '2003-08-23', 2024),
('Priya Deshpande', 'CS2024003', '2002-11-05', 2024),
('Vikram Patil', 'CS2024004', '2003-02-17', 2024),
('Anjali Nair', 'CS2024005', '2003-07-30', 2024),
('Siddharth Gupta', 'CS2024006', '2002-12-10', 2024),
('Kavya Rao', 'CS2024007', '2003-04-21', 2024),
('Arjun Khanna', 'CS2024008', '2003-09-14', 2024),
('Isha Kapoor', 'CS2024009', '2002-10-02', 2024),
('Devansh Jain', 'CS2024010', '2003-01-29', 2024),
('Maya Singh', 'CS2024011', '2003-03-03', 2024),
('Tarun Verma', 'CS2024012', '2002-06-11', 2024),
('Pallavi Kulkarni', 'CS2024013', '2003-12-25', 2024),
('Nikhil Menon', 'CS2024014', '2002-09-09', 2024),
('Sneha Reddy', 'CS2024015', '2003-11-18', 2024),
('Rohit Joshi', 'CS2024016', '2002-08-01', 2024),
('Tanvi Kulkarni', 'CS2024017', '2003-06-07', 2024),
('Karan Rao', 'CS2024018', '2003-02-02', 2024),
('Meera Iyer', 'CS2024019', '2002-07-15', 2024),
('Arpita Banerjee', 'CS2024020', '2003-10-27', 2024);

INSERT INTO Courses (CourseCode, CourseName, Credits) VALUES
('CS101', 'Programming Fundamentals', 4),
('CS102', 'Data Structures', 3),
('CS103', 'Database Systems', 3),
('CS104', 'Operating Systems', 3),
('CS105', 'Computer Networks', 3),
('MA101', 'Calculus I', 4),
('MA102', 'Linear Algebra', 3),
('ST101', 'Probability & Statistics', 3),
('EN101', 'Technical Communication', 2),
('CS201', 'Object Oriented Programming', 4),
('CS202', 'Web Technologies', 3),
('CS203', 'Software Engineering', 3),
('CS204', 'Mobile App Development', 3),
('CS205', 'Machine Learning', 4),
('CS206', 'Cyber Security', 3),
('MA201', 'Discrete Mathematics', 3),
('CS207', 'Artificial Intelligence', 3),
('CS208', 'Cloud Computing', 3),
('CS209', 'Big Data Analytics', 3),
('CS210', 'DevOps Fundamentals', 3);

INSERT INTO Semesters (Term, AcadYear) VALUES
('Fall', '2023-24'),
('Spring', '2023-24'),
('Summer', '2023-24'),
('Fall', '2024-25'),
('Spring', '2024-25'),
('Summer', '2024-25'),
('Fall', '2025-26'),
('Spring', '2025-26'),
('Summer', '2025-26'),
('Fall', '2026-27'),
('Spring', '2026-27'),
('Summer', '2026-27'),
('Fall', '2027-28'),
('Spring', '2027-28'),
('Summer', '2027-28'),
('Fall', '2028-29'),
('Spring', '2028-29'),
('Summer', '2028-29'),
('Fall', '2029-30'),
('Spring', '2029-30');

INSERT INTO Grades (StudentID, CourseID, SemesterID, Marks, Grade) VALUES
(1, 1, 1, 95, 'A+'),
(1, 3, 1, 88, 'A'),
(2, 2, 1, 76, 'B+'),
(2, 5, 1, 65, 'B'),
(3, 1, 1, 59, 'C'),
(3, 4, 1, 45, 'F'),
(4, 6, 1, 82, 'A'),
(4, 10, 1, 91, 'A+'),
(5, 7, 1, 73, 'B+'),
(5, 9, 1, 68, 'B'),
(6, 2, 1, 54, 'C'),
(6, 8, 1, 47, 'F'),
(7, 3, 1, 89, 'A'),
(7, 5, 1, 79, 'B+'),
(8, 10, 2, 94, 'A+'),
(8, 4, 2, 81, 'A'),
(9, 1, 2, 69, 'B'),
(9, 6, 2, 58, 'C'),
(10, 2, 2, 62, 'B'),
(10, 9, 2, 50, 'C');

SELECT 
  s.StudentID, s.Name,
  ROUND(SUM(
    CASE g.Grade
      WHEN 'A+' THEN 10
      WHEN 'A' THEN 9
      WHEN 'B+' THEN 8
      WHEN 'B' THEN 7
      WHEN 'C' THEN 6
      ELSE 0
    END * c.Credits) / SUM(c.Credits), 2) AS GPA
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
GROUP BY s.StudentID;

SELECT 
  s.StudentID, s.Name, se.Term, se.AcadYear,
  ROUND(SUM(
    CASE g.Grade
      WHEN 'A+' THEN 10 WHEN 'A' THEN 9 WHEN 'B+' THEN 8
      WHEN 'B' THEN 7 WHEN 'C' THEN 6 ELSE 0
    END * c.Credits) / SUM(c.Credits), 2) AS GPA
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
JOIN Semesters se ON g.SemesterID = se.SemesterID
GROUP BY s.StudentID, g.SemesterID;

SELECT 
  ROUND(AVG(
    CASE g.Grade
      WHEN 'A+' THEN 10 WHEN 'A' THEN 9 WHEN 'B+' THEN 8
      WHEN 'B' THEN 7 WHEN 'C' THEN 6 ELSE 0
    END), 2) AS Avg_Grade_Point
FROM Grades g
JOIN Semesters se ON g.SemesterID = se.SemesterID
WHERE se.Term = 'Fall' AND se.AcadYear = '2023-24';

SELECT 
  s.Name,
  ROUND(SUM(
    CASE g.Grade
      WHEN 'A+' THEN 10 WHEN 'A' THEN 9 WHEN 'B+' THEN 8
      WHEN 'B' THEN 7 WHEN 'C' THEN 6 ELSE 0
    END * c.Credits) / SUM(c.Credits), 2) AS GPA
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
JOIN Semesters se ON g.SemesterID = se.SemesterID
WHERE se.Term = 'Fall' AND se.AcadYear = '2023-24'
GROUP BY s.StudentID
HAVING GPA >= 9;

SELECT s.Name,
  ROUND(SUM(
    CASE g.Grade
      WHEN 'A+' THEN 10 WHEN 'A' THEN 9 WHEN 'B+' THEN 8
      WHEN 'B' THEN 7 WHEN 'C' THEN 6 ELSE 0
    END * c.Credits) / SUM(c.Credits), 2) AS GPA
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
GROUP BY s.StudentID
ORDER BY GPA DESC
LIMIT 5;

SELECT se.Term, se.AcadYear,
  COUNT(CASE WHEN g.Grade <> 'F' THEN 1 END) AS Passed,
  COUNT(CASE WHEN g.Grade = 'F' THEN 1 END) AS Failed
FROM Grades g
JOIN Semesters se ON g.SemesterID = se.SemesterID
GROUP BY g.SemesterID;

SELECT DISTINCT s.Name
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
WHERE g.Grade = 'F';

SELECT c.CourseName, COUNT(*) AS FailCount
FROM Grades g
JOIN Courses c ON g.CourseID = c.CourseID
WHERE g.Grade = 'F'
GROUP BY g.CourseID
ORDER BY FailCount DESC;

SELECT s.Name,
  COUNT(CASE WHEN g.Grade = 'F' THEN 1 END) AS FailedSubjects,
  COUNT(CASE WHEN g.Grade <> 'F' THEN 1 END) AS PassedSubjects
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
GROUP BY g.StudentID;

SELECT c.CourseName,
  ROUND(100.0 * SUM(CASE WHEN g.Grade <> 'F' THEN 1 ELSE 0 END) / COUNT(*), 2) AS PassPercentage
FROM Grades g
JOIN Courses c ON g.CourseID = c.CourseID
GROUP BY g.CourseID;

CREATE TABLE GPA_Calculation (
  StudentID INT,
  SemesterID INT,
  GPA DECIMAL(4,2),
  PRIMARY KEY (StudentID, SemesterID)
);

DELIMITER //
CREATE TRIGGER trg_calc_gpa
AFTER INSERT ON Grades
FOR EACH ROW
BEGIN
  DECLARE gpa DECIMAL(4,2);

  SELECT ROUND(SUM(
    CASE Grade
      WHEN 'A+' THEN 10 WHEN 'A' THEN 9 WHEN 'B+' THEN 8
      WHEN 'B' THEN 7 WHEN 'C' THEN 6 ELSE 0
    END * c.Credits) / SUM(c.Credits), 2)
  INTO gpa
  FROM Grades g
  JOIN Courses c ON g.CourseID = c.CourseID
  WHERE g.StudentID = NEW.StudentID AND g.SemesterID = NEW.SemesterID;

  INSERT INTO GPA_Calculation (StudentID, SemesterID, GPA)
  VALUES (NEW.StudentID, NEW.SemesterID, gpa)
  ON DUPLICATE KEY UPDATE GPA = gpa;
END;
//
DELIMITER ;

SELECT s.StudentID, s.Name, se.Term, se.AcadYear,
  COUNT(g.Grade) AS Subjects,
  COUNT(CASE WHEN g.Grade = 'F' THEN 1 END) AS Failures
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Semesters se ON g.SemesterID = se.SemesterID
GROUP BY s.StudentID, g.SemesterID;

SELECT se.Term, se.AcadYear, COUNT(DISTINCT g.StudentID) AS TotalStudents
FROM Grades g
JOIN Semesters se ON g.SemesterID = se.SemesterID
GROUP BY g.SemesterID;

SELECT se.Term, se.AcadYear, c.CourseName,
  ROUND(AVG(g.Marks), 2) AS AvgMarks
FROM Grades g
JOIN Courses c ON g.CourseID = c.CourseID
JOIN Semesters se ON g.SemesterID = se.SemesterID
GROUP BY g.SemesterID, g.CourseID;

SELECT s.Name
FROM Students s
WHERE NOT EXISTS (
  SELECT 1 FROM Grades g
  JOIN Semesters se ON g.SemesterID = se.SemesterID
  WHERE g.StudentID = s.StudentID AND g.Grade = 'F'
  AND se.Term = 'Fall' AND se.AcadYear = '2023-24'
);

WITH GPA_Calc AS (
  SELECT 
    s.StudentID, 
    s.Name,
    ROUND(SUM(
      CASE g.Grade
        WHEN 'A+' THEN 10 
        WHEN 'A'  THEN 9 
        WHEN 'B+' THEN 8
        WHEN 'B'  THEN 7 
        WHEN 'C'  THEN 6 
        ELSE 0
      END * c.Credits) / SUM(c.Credits), 2) AS GPA
  FROM Grades g
  JOIN Students s ON g.StudentID = s.StudentID
  JOIN Courses c ON g.CourseID = c.CourseID
  GROUP BY s.StudentID
)
SELECT 
  StudentID, Name, GPA,
  DENSE_RANK() OVER (ORDER BY GPA DESC) AS `Rank`
FROM GPA_Calc;

WITH Ranked AS (
  SELECT s.StudentID, s.Name, se.Term, se.AcadYear,
    ROUND(SUM(
      CASE g.Grade
        WHEN 'A+' THEN 10 WHEN 'A' THEN 9 WHEN 'B+' THEN 8
        WHEN 'B' THEN 7 WHEN 'C' THEN 6 ELSE 0
      END * c.Credits) / SUM(c.Credits), 2) AS GPA,
    RANK() OVER (PARTITION BY se.SemesterID ORDER BY 
      SUM(
        CASE g.Grade
          WHEN 'A+' THEN 10 WHEN 'A' THEN 9 WHEN 'B+' THEN 8
          WHEN 'B' THEN 7 WHEN 'C' THEN 6 ELSE 0
        END * c.Credits
      ) / SUM(c.Credits) DESC) AS `Rank`
  FROM Grades g
  JOIN Students s ON g.StudentID = s.StudentID
  JOIN Courses c ON g.CourseID = c.CourseID
  JOIN Semesters se ON g.SemesterID = se.SemesterID
  GROUP BY s.StudentID, se.SemesterID
)
SELECT * FROM Ranked WHERE `Rank` <= 3;

SELECT s.Name, c.CourseName, g.Marks,
  RANK() OVER (PARTITION BY g.CourseID ORDER BY g.Marks DESC) AS `Rank`
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
WHERE c.CourseCode = 'CS101';




