-- Name : Muhammad Faishal Rizqy
-- NRP  : 5027221026

USE akademik;
-- Number 1
SELECT
    student.name_student AS StudentName,
    task.desc_task AS TaskDescription,
    course.name_course AS CourseName,
    lecturer.name_lecturer AS LecturerName
FROM
    task
NATURAL JOIN student
NATURAL JOIN course
NATURAL JOIN lecturer;

-- Number 2
SELECT
    student.name_student AS StudentName,
    task.desc_task AS TaskDescription,
    course.name_course AS CourseName,
    lecturer.name_lecturer AS LecturerName
FROM
    task
NATURAL JOIN student
NATURAL JOIN course
NATURAL JOIN lecturer
WHERE
    lecturer.name_lecturer LIKE 'H%';

-- Number 3
SELECT
    student.name_student AS StudentName,
    task.desc_task AS TaskDescription,
    course.name_course AS CourseName,
    lecturer.name_lecturer AS LecturerName,
    task.score AS TaskScore
FROM
    task
NATURAL JOIN student
NATURAL JOIN course
NATURAL JOIN lecturer
WHERE
    task.score >= 60 AND task.score <= 80
ORDER BY
    task.score ASC;

-- Number 4
SELECT
    student.name_student AS StudentName,
    student.nrp AS StudentNRP
FROM
    student
LEFT JOIN task ON student.id = task.id_mhs
WHERE
    task.id IS NULL;