---
title: "Backup dan Restore database MySQL"
date: 2012-03-06T04:48:47+00:00
---
Dalam membuat dan merawat database terkadang kita harus melakukan backup secara berkala agar kita bisa siap pada saat terjadi hal-hal yang tidak diinginkan terjadi pada database. Blog saya pun di backup secara berkala oleh hosting tempat saya menyimpan data. Hal ini penting, salah satunya ketika saya memindahkan url blog, saya harus membackup database dan blog saya terlebih dahulu untuk kemudian dipindahkan direktorinya.
<!--more-->
Cara membackup database cukup mudah, pertama-tama masuk ke command prompt terlebih dahulu (dalam hal ini saya menggunakan OS Windows), jangan lupa, untuk melakukan command-command dibawah, kamu tidak perlu masuk MySQL sebagai admin, cukup lakukan diluar. Ketikan perintah seperti dibawah ini :

```bash
mysqldump -u root -p db_dummy table1 table2 > backup\_partial.sql
```

"db\_dummy" diatas adalah nama database. Sedangkan table1 dan table2 adalah nama tabel di dalam database. backup_partial.sql adalah nama file backup yang ingin kita buat. Command diatas digunakan jika kita ingin membackup database hanya pada database tertentu saja, lalu bagaimana caranya jika kita ingin membackup seluruh database? mudah, kita hanya mengubah sedikit command diatas seperti ini :

```bash
mysqldump -u root -p db_dummy > backup.sql
```
dengan perintah diatas, MySQL akan melakukan dump pada seluruh database db_dummy, ketika tombol enter ditekan, MySQL akan meminta password admin, lalu file backup akan terbuat otomatis pada direktori dimana anda berada,
Lalu bagaimana caranya melakukan restore database? sama seperti command diatas, tapi ada sedikit beberapa perbedaan, buka command prompt, dan arahkan direktori dimana file backup kamu berada, lalu masukan command seperti dibawah ini :

```bash
mysql -u root -p db_dummy < backup.sql
```
perbedaan ada di tanda panah ">" dan "<", untuk melakukan command diatas juga tidak perlu masuk ke MySQL sebagai admin, cukup lakukan dari luar.