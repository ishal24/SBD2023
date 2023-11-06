-- Name : Muhammad Faishal Rizqy
-- NRP  : 5027221026

USE akademik;

-- nomor 1
SELECT
    task.desc_task AS DeskripsiTugas,
    course.name_course AS NamaMataKuliah,
    lecturer.name_lecturer AS NamaDosen,
    COUNT(student.id) AS JumlahMahasiswa
FROM
    task
LEFT JOIN course ON task.id_mk = course.id
LEFT JOIN lecturer ON task.id_dos = lecturer.id
LEFT JOIN student ON task.id_mhs = student.id
GROUP BY task.desc_task
ORDER BY JumlahMahasiswa DESC;


-- nomor 2
SELECT
    course.name_course AS NamaMataKuliah,
    COUNT(task.id) AS JumlahTugas
FROM
    course
LEFT JOIN task ON course.id = task.id_mk
GROUP BY course.name_course
ORDER BY JumlahTugas DESC
LIMIT 1;

SELECT
    lecturer.name_lecturer AS NamaDosen,
    COUNT(task.id) AS JumlahTugas
FROM
    lecturer
LEFT JOIN task ON lecturer.id = task.id_dos
GROUP BY lecturer.name_lecturer
ORDER BY JumlahTugas DESC
LIMIT 2;


-- nomor 3
SELECT
    task.desc_task AS DeskripsiTugas,
    course.name_course AS NamaMataKuliah,
    lecturer.name_lecturer AS NamaDosen,
    task.score AS NilaiTugas
FROM
    task
LEFT JOIN course ON task.id_mk = course.id
LEFT JOIN lecturer ON task.id_dos = lecturer.id
WHERE task.score BETWEEN 70 AND 80
ORDER BY task.score ASC;


-- nomor 4
SELECT
    student.name_student AS NamaMahasiswa,
    student.nrp AS NRP,
	task.desc_task AS DeskripsiTugas,
    task.score AS Nilai
FROM
    task
LEFT JOIN student ON task.id_mhs = student.id
WHERE
    task.desc_task LIKE '%car%'
    AND task.score < (
        SELECT AVG(score) 
        FROM task 
        WHERE desc_task LIKE '%car%'
    );


-- nomor 5
SELECT
    task.desc_task AS DeskripsiTugas,
    course.name_course AS NamaMataKuliah,
    lecturer.name_lecturer AS NamaDosen,
    ROUND(AVG(task.score)) AS RataRataNilai
FROM
    task
LEFT JOIN course ON task.id_mk = course.id
LEFT JOIN lecturer ON task.id_dos = lecturer.id
GROUP BY task.desc_task
HAVING AVG(task.score) < (SELECT AVG(score) FROM task)
ORDER BY task.score;