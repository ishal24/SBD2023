-- Name : Muhammad Faishal Rizqy
-- NRP  : 5027221026

USE akademik;

-- Index

-- Basic Index
CREATE INDEX IX_StudentName ON student(name_student);

SELECT *
FROM student USE INDEX (IX_StudentName)
WHERE name_student = 'Kelly Mcdonald';

-- Composite Index
CREATE INDEX IX_task ON task(id_mk, id_dos);

SELECT *
FROM task USE INDEX (IX_task)
WHERE id_mk = 97 AND id_dos = 51;


-- View
CREATE VIEW TaskView AS
SELECT
    course.name_course AS CourseName,
    task.desc_task AS TaskDescription,
    lecturer.name_lecturer AS LecturerName
FROM 
    task
JOIN
    course ON task.id_mk = course.id
JOIN
    lecturer ON task.id_dos = lecturer.id;

SELECT * FROM TaskView


-- Stored Procedure
DELIMITER //

CREATE PROCEDURE GetMhsTaskScore(IN MhsID INT)
BEGIN
    SELECT SUM(score) AS TotalScore
    FROM task
    WHERE id_mhs = MhsID;
END;
//
DELIMITER ;

CALL GetMhsTaskScore(2) and GetMhsTaskScore(3)