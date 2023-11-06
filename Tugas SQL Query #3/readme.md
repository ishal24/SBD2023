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
Pada soal ini, diminta untuk menampilkan tugas yang paling banyak dikerjakan oleh mahasiswa beserta nama mata kuliah dan dosennya. Disini saya mengambil deskripsi tugas dari ```task.desc_task```, nama mata kuliah dari ```course.name_course```, dan nama dosen dari ```lecturer.name_lecturer```. Saya juga menambahkan kolom JumlahMahasiswa untuk mengetahui berapa banyak mahasiswa yang mengambil tugas tersebut dengan ```COUNT(student.id)```.
Lalu saya menggunakan ```LEFT JOIN``` pada ```course.id```, ```lecturer.id```, dan ```student.id```, yang cocok dengan id yang ada di task. Kemudian saya menggunakan grouping dengan task.desc_tesk. Selanjutnya melakukan sorting berdasarkan JumlahMahasiswa.

![](img/Screenshot_1.png)
Dari gambar diatas, didapat 100 baris dengan Jumlah Mahasiswa terbanyak yang mengerjakan tugas adalah 1 dan semua baris menampilkan jumlah yang sama.


## 2. Tampilkan nama mata kuliah dan nama dosen yang memiliki paling banyak jenis tugas
Pada soal ini, diminta untuk menampilkan jenis tugas yang paling banyak oleh mata kuliah dan dosen.
- Menampilkan mata kuliah dengan jenis tugas terbanyak
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
Disini saya mengambil nama mata kuliah dari ```course.name_course``` dan jumlah tugas dengan menghitung menggunakan ```COUNT(task.id)```. Kemudian saya melakukan ```LEFT JOIN``` untuk mengambil id mata kuliah yang cocok dengan id pada course. Lalu saya melakukan grouping dengan ```course.name_course```. Lalu saya melakukan sorting berdasarkan jumlah tugas secara descending agar nilai terbesar berada di paling atas. Lalu yang terakhir melakukan ```LIMIT 1``` untuk membatasi hasil hanya satu baris.

![](img/Screenshot_2.1.png)
Pada gambar tersebut, terlihat bahwa hanya satu mata kuliah dengan jumlah tugas terbanyak sebanyak 7.

![](img/Screenshot_2.2.png)
Pada gambar tersebut, saya menghilangkan ```LIMIT 1``` pada query untuk menampilkan semuanya dan didapati bahwa hanya satu mata kuliah dengan posisi pertama yaitu Ruby On Rails. Itu mengapa saya melimit hasilnya hanya satu baris.

- Menampilkan dosen dengan jenis tugas terbanyak
```sql
SELECT
    lecturer.name_lecturer AS NamaDosen,
    COUNT(task.id) AS JumlahTugas
FROM
    lecturer
LEFT JOIN task ON lecturer.id = task.id_dos
GROUP BY lecturer.name_lecturer
ORDER BY JumlahTugas DESC
LIMIT 2;
```
Disini saya mengambil nama dosen dari ```lecturer.name_lecturer``` dan jumlah tugas dengan menghitung menggunakan ```COUNT(task.id)```. Kemudian saya melakukan ```LEFT JOIN``` untuk mengambil id dosen yang cocok dengan id pada course. Lalu saya melakukan grouping dengan ```lecturer.name_lecturer```. Lalu saya melakukan sorting berdasarkan jumlah tugas secara descending agar nilai terbesar berada di paling atas. Lalu yang terakhir melakukan ```LIMIT 2``` untuk membatasi hasil hanya dua baris.

![](img/Screenshot_2.3.png)
Pada gambar tersebut, terlihat bahwa ada dua nama dosen yang muncul dengan jumlah tugas sebanyak 4.

![](img/Screenshot_2.4.png)
Pada gambar tersebut, saya menghilangkan ```LIMIT 2``` pada query untuk menampilkan semuanya dan didapati bahwa ada dua dosen dengan posisi pertama yaitu Charlene Johnson dan Shirley Fleming. Itu mengapa saya melimit hasilnya menjadi dua baris.


## 3. Tampilkan deskripsi tugas, nama mata kuliah, dan nama dosen dari tugas yang memiliki rata-rata nilai antara 70 sampai 80
```sql
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
```
Pada soal ini, diminta untuk menampilkan tugas memiliki nilai antara 70 sampai 80 beserta nama mata kuliah dan nama dosennya. Disini saya mengambil deskripsi tugas dari ```task.desc_task```, nama mata kuliah dari ```course.name_course```, nama dosen dari ```lecturer.name_lecturer```, dan nilai tugas dari ```task.score```. Lalu saya menggunakan ```LEFT JOIN``` pada ```course.id``` dan ```lecturer.id``` yang cocok dengan id yang ada di task. Kemudian saya memfilter hasilnya menggunakan ```WHERE task.score BETWEEN 70 AND 80``` dimana hanya akan menampilkan yang nilai scorenya antara 70 dan 80. Kemudian saya mensorting hasilnya berdasarkan nilai tugasnya.

![](img/Screenshot_3.png)
Dari gambar tersebut didapat bahwa ada sepuluh tugas dengan nilai diantara 70 dan 80.


## 4. Tampilkan nama mahasiswa, NRP, dan nilai yang memiliki nilai dibawah rata-rata pada tugas yang memiliki kata 'car' di deskripsi
```sql
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
```
Pada soal ini diminta untuk menampilkan nama mahasiswa beserta NRP nya yang memiliki nilai dibawah rata-rata pada tugas yang memiliki kata 'car' pada deskripsinya. Disini saya mengambil nama mahasiswa dari ```student.name_student```, NRP dari ```student.nrp```, deskripsi tugas dari ```task.desc_task```, dan nilai dari ```task.score```. Kemudian saya melakukan ```LEFT JOIN``` pada ```student.id``` yang cocok dengan id pada task. Lalu saya memfilter hasil menggunakan ```WHERE```. Dalam ```WHERE``` tersebut, saya menggunakan ```task.desc_task LIKE '%car%'``` untuk hanya menampilkan yang terdapat 'car' pada deskripsi tugas.  Kemudian menggunakan ```AND task.score < (SELECT AVG(score) FROM task WHERE desc_task LIKE '%car%')``` untuk hanya menampilkan hasil yang scorenya dibawah dari rata-rata score.

![](img/Screenshot_4.png)
Pada gambar diatas, dapat dilihat bahwa terdapat tiga mahasiswa yang memenuhi kriteria.


## 5. Tampilkan deskripsi tugas, nama mata kuliah, dan nama dosen dari tugas yang memiliki nilai rata-rata dibawah rata-rata nilai semua tugas
```sql
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
```
Pada soal ini, diminta untuk menampilkan tugas yang  memiliki nilai rata-rata dibawah rata-rata nilai semua tugas beserta nama mata kuliah dan dosennya. Disini saya mengambil deskripsi tugas dari ```task.desc_task```, nama mata kuliah dari ```course.name_course```, dan nama dosen dari ```lecturer.name_lecturer```. Saya juga menambahkan kolom RataRataNilai untuk mengetahui nilai dari tugas tersebut. Untuk rata rata nilainya, saya menggunakan ```AVG(task.score)``` untuk menghitungnya dan menggunakan ```ROUND()``` untuk membulatkan hasilnya. Lalu saya menggunakan ```LEFT JOIN``` pada ```course.id``` dan ```lecturer.id``` yang cocok dengan id yang ada di task. Kemudian saya menggunakan grouping dengan task.desc_tesk. Lalu saya menggunakan ```HAVING``` untuk memfilter hasil pada group. ```AVG(task.score) < (SELECT AVG(score) FROM task)``` pada ```HAVING``` artinya memvilter rata-rata task.score yang kurang dari rata-rata score.Terakhir, saya melakukan sorting berdasarkan rata-rata nilai. 

![](img/Screenshot_5.png)
Pada gambar tersebut, didapat bahwa ada 50 tugas yang memiliki nilai dibawah rata-rata.