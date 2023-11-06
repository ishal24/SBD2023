# Tugas SQL Query #3
Name    : Muhammad Faishal Rizqy

NRP     : 5027221026

## database
untuk latihan ini masih menggunakan database yang sama dengan database sebelumnya, atau jika ingin membuat database, bisa menggunakan query pada [createdb.sql](https://github.com/ishal24/SBD2023/blob/main/Tugas%20SQL%20Query%20%232/createdb.sql).

## 1. Tampilkan deskripsi tugas, nama mata kuliah, dan nama dosen dari tugas yang paling banyak dikerjakan oleh mahasiswa
```sql
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
```
Pada soal ini, diminta untuk menampilkan tugas yang paling banyak dikerjakan oleh mahasiswa beserta nama mata kuliah dan dosennya. Disini saya mengambil deskripsi tugas dari task.desc_task, nama mata kuliah dari course dari course.name_course, dan nama dosen dari lecturer.name_lecturer.

![](img/Screenshot_1.png)



## 2. Tampilkan nama mata kuliah dan nama dosen yang memiliki paling banyak jenis tugas

Menampilkan mata kuliah dengan jenis tugas terbanyak
```sql
SELECT
    course.name_course AS NamaMataKuliah,
    COUNT(task.id) AS JumlahTugas
FROM
    course
LEFT JOIN task ON course.id = task.id_mk
GROUP BY course.name_course
ORDER BY JumlahTugas DESC
LIMIT 1;
```

Menampilkan dosen dengan jenis tugas terbanyak
```sql
SELECT
    lecturer.name_lecturer AS NamaDosen,
    COUNT(task.id) AS JumlahTugas
FROM
    lecturer
LEFT JOIN task ON lecturer.id = task.id_dos
GROUP BY lecturer.name_lecturer
ORDER BY JumlahTugas DESC
LIMIT 1;

```


## 3. Tampilkan deskripsi tugas, nama mata kuliah, dan nama dosen dari tugas yang memiliki rata-rata nilai antara 70 sampai 80
```sql
SELECT
    task.desc_task AS DeskripsiTugas,
    course.name_course AS NamaMataKuliah,
    lecturer.name_lecturer AS NamaDosen,
    task.score AS NilaiTugas
FROM
    task
JOIN course ON task.id_mk = course.id
JOIN lecturer ON task.id_dos = lecturer.id
WHERE
    task.score BETWEEN 70 AND 80;
```


## 4. Tampilkan nama mahasiswa, NRP, dan nilai yang memiliki nilai dibawah rata-rata pada tugas yang memiliki kata 'car' di deskripsi
```sql
SELECT
    student.name_student AS NamaMahasiswa,
    student.nrp AS NRP,
	task.desc_task AS DeskripsiTugas,
    task.score AS Nilai
FROM
    task
JOIN student ON task.id_mhs = student.id
WHERE
    task.desc_task LIKE '%car%'
    AND task.score < (
        SELECT AVG(score) 
        FROM task 
        WHERE desc_task LIKE '%car%'
    );
```


## 5. Tampilkan deskripsi tugas, nama mata kuliah, dan nama dosen dari tugas yang memiliki nilai rata-rata dibawah rata-rata nilai semua tugas
```sql
SELECT
    task.desc_task AS DeskripsiTugas,
    course.name_course AS NamaMataKuliah,
    lecturer.name_lecturer AS NamaDosen,
    AVG(task.score) AS RataRataNilai
FROM
    task
JOIN course ON task.id_mk = course.id
JOIN lecturer ON task.id_dos = lecturer.id
GROUP BY task.desc_task, course.name_course, lecturer.name_lecturer
HAVING AVG(task.score) < (SELECT AVG(score) FROM task);
```

