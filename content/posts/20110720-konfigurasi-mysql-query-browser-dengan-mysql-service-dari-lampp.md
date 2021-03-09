---
title: "Konfigurasi MySQL Query Browser dengan MySQL Service dari LAMPP"
date: 2011-07-19T17:29:58+00:00
---
Bagi anda yang menggunakan MySQL yang di bundle di dalam lampp dan menggunakan MySQL Query Browser sebagai client mungkin akan mendapatkan sedikit masalah ketika program pertama kali dijalankan. Secara default MySQL Query Browser mencari MySQL Service pada /var/run/mysqld.sock, jika kita belum menginstall MySQL Server dari repositori,tentu saja akan menghasilkan error `Can't connect to local MySQL server through socket 'var/run/mysqld/mysqld.sock'`, solusinya ternyata mudah sekali, pertama-tama jangan lupa matikan service lamps kita dengan perintah :
<!--more-->
{{< highlight bash >}}
$sudo /opt/lampp/lampp stop
{{< /highlight >}}

Setelah itu kita buat direktori di tempat dimana Mysql Query Browser mencari mysql.sock.
{{< highlight bash >}}
$sudo mkdir /var/run/mysqld 
$cd /var/run/mysql
{{< /highlight >}}

Kalau langkah diatas sudah dilewati, sekarang tinggal mengcopy file mysql.sock dari `/opt/lampp/var/mysql/mysql.sock` secara softlink, perbedaan mencopy secara hardlink dan softlink adalah, Jika hardlink, apabila file parentnya di hapus, maka file hasil copy nya masih tetap bisa digunakan. Jika softlink (ln -s), apabila file masternya dihapus, maka file hasil copy nya tidak akan bisa dibaca lagi :
</p>
{{< highlight bash >}}
$sudo ln -s /opt/lampp/var/mysql/mysql.sock mysqld.sock
{{< /highlight >}}

Nah, sekarang nyalakan lagi service mysql nya dengan perintah :
{{< highlight bash >}}
$sudo opt/lampp/lampp start
{{< /highlight >}}

Coba sekarang masuk lagi menggunakan MySQL Query Browser anda, seharusnya sudah tidak ada masalah :)