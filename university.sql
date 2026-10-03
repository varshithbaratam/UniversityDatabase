CREATE DATABASE UniversityDB;
USE UniversityDB;
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    Major VARCHAR(50)
);
DESC Students;
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT
);
CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15)
);
CREATE TABLE Course_Instructors (
    CourseID INT,
    InstructorID INT,
    PRIMARY KEY (CourseID, InstructorID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);
INSERT INTO Students VALUES
(101, 'Rahul', 'Computer Science'),
(102, 'Arjun', 'Artificial Intelligence'),
(103, 'Priya', 'Data Science'),
(104, 'Sneha', 'Computer Science'),
(105, 'Vikram', 'Information Technology');
SELECT * FROM Students;
INSERT INTO Courses VALUES
(201, 'Database Management Systems', 4),
(202, 'Operating Systems', 4),
(203, 'Artificial Intelligence', 3),
(204, 'Computer Networks', 3),
(205, 'Data Structures', 4);
SELECT * FROM Courses;
INSERT INTO Enrollments VALUES
(101, 201, '2026-07-01'),
(101, 205, '2026-07-02'),
(102, 201, '2026-07-01'),
(102, 203, '2026-07-03'),
(103, 201, '2026-07-01'),
(103, 204, '2026-07-04'),
(104, 202, '2026-07-02'),
(104, 205, '2026-07-05'),
(105, 203, '2026-07-03'),
(105, 204, '2026-07-04');
SELECT * FROM Enrollments;
INSERT INTO Instructors VALUES
(301, 'Dr. Ramesh', '9876543210'),
(302, 'Dr. Suresh', '9876543211'),
(303, 'Dr. Mahesh', '9876543212'),
(304, 'Dr. Kavya', '9876543213');
SELECT * FROM Instructors;
INSERT INTO Course_Instructors VALUES
(201, 301),
(202, 302),
(203, 303),
(204, 304),
(205, 301);
SELECT * FROM Course_Instructors;
SELECT
    s.StudentID,
    s.StudentName,
    s.Major,
    c.CourseID,
    c.CourseName,
    c.Credits
FROM Students s
JOIN Enrollments e
    ON s.StudentID = e.StudentID
JOIN Courses c
    ON e.CourseID = c.CourseID;
SELECT
    c.CourseName,
    i.InstructorName,
    i.Phone
FROM Courses c
JOIN Course_Instructors ci
    ON c.CourseID = ci.CourseID
JOIN Instructors i
    ON ci.InstructorID = i.InstructorID;
SELECT
    s.StudentName,
    c.CourseName,
    i.InstructorName
FROM Students s
JOIN Enrollments e
    ON s.StudentID = e.StudentID
JOIN Courses c
    ON e.CourseID = c.CourseID
JOIN Course_Instructors ci
    ON c.CourseID = ci.CourseID
JOIN Instructors i
    ON ci.InstructorID = i.InstructorID;
SELECT
    s.StudentName,
    COUNT(e.CourseID) AS NumberOfCourses
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.StudentName;
SELECT
    s.StudentName,
    s.Major
FROM Students s
WHERE s.StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID = 201
);
CREATE USER 'university_user'@'localhost'
IDENTIFIED BY 'University@123';
GRANT SELECT, INSERT, UPDATE
ON UniversityDB.*
TO 'university_user'@'localhost';
SHOW GRANTS FOR 'university_user'@'localhost';
REVOKE UPDATE
ON UniversityDB.*
FROM 'university_user'@'localhost';
SHOW GRANTS FOR 'university_user'@'localhost';
START TRANSACTION;
INSERT INTO Students
VALUES (106, 'Kiran', 'Cyber Security');
COMMIT;
SELECT * FROM Students;
START TRANSACTION;
INSERT INTO Students
VALUES (107, 'Anjali', 'Electronics');
SAVEPOINT student_savepoint;
INSERT INTO Students
VALUES (108, 'Varun', 'Mechanical');
ROLLBACK TO student_savepoint;
COMMIT;
SELECT * FROM Students;
START TRANSACTION;
UPDATE Students
SET Major = 'Artificial Intelligence'
WHERE StudentID = 101;
ROLLBACK;
SELECT * FROM Students
WHERE StudentID = 101;
