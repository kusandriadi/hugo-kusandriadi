---
title: Implementasi Basis Data Tertanam H2 pada bahasa pemrograman Java
author: Kus Andriadi
type: post
date: 2010-06-01T18:11:38+00:00
url: /java-implementasi-embedded-database-dengan-h2/
categories:
  - Activities

---
<p style="text-align: justify;">
  Ada dua tipe Basis data yang sudah lumrah kita ketahui, yaitu Basis Data yang bisa berdiri sendiri (Standalone Database) dan tertanam di aplikasi (Embedded Database). Berdiri sendiri berarti Basis Data tersebut tidak menjadi satu dengan aplikasi, biasanya kita harus mengunduhnya secara terpisah. Sedangkan untuk Basis Data yang tertanam, biasanya dijadikan satu paket di aplikasi dan memiliki dua cara untuk menyimpan data, yaitu menggunakan file dan menggunakan memori. Menggunakan memori artinya data tersebut akan disimpan di dalam memori komputer, yang berarti datanya jadi bersifat sementara (volatile) atau akan hilang setelah komputer kehilangan daya (restart atau turn off). Kebalikannya, jika berbentuk file, berarti data tersebut bersifat non-volatile, karena akan disimpan di dalam cakram keras (Hard Disk Drive)
</p>

<p style="text-align: justify;">
  Ada beberapa basis Data tertanam yang bisa digunakan pada bahasa pemrograman Java, yaitu H2, Apache Derby, Berkley DB, dll. Pada artikel kali ini kita akan menggunakan H2.
</p>

<p style="text-align: justify;">
  <!--more-->Sebelumnya, kita bisa mengunduh Basis Data H2 
  
  <a href="http://www.h2database.com/html/download.html">di sini</a>, jika menggunakan Windows, kita bisa menggunakan Windows Installer, kalau bukan, kita bisa unduh yang Platform Independent. Jika sudah selesai, langsung saja di install di komputer kita, lalu coba jalankan dan masuk ke <a class="markup--anchor markup--p-anchor" href="http://localhost:8080/h2-console]%28http://localhost:8080/h2-console%29" target="_blank" rel="nofollow noopener noreferrer" data-href="http://localhost:8080/h2-console](http://localhost:8080/h2-console)">http://localhost:8080/h2-console</a>. Masukan data URL, username dan password sebagai berikut :
</p>

> URL : jdbc:h2:test
> 
> Username : sa
> 
> Password : <kosongkan>

<p style="text-align: justify;">
  Setelah cukup berkenalan dan berhasil masuk ke halaman h2-console, kita akan coba langsung membuat contoh aplikasi kecil yang tersambung ke basis data H2. Buatlah class Koneksi agar aplikasi kita bisa tersambung dengan H2.
</p>

<pre>package com.kusandriadi.koneksi;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import javax.swing.JOptionPane;

public class Koneksi {

    private String url = "jdbc:h2:./db/TestH2;IFEXISTS=TRUE";

    private String username = "root";

    private String password = "27111989";

    public Connection KoneksiDB(){
        try {
            Class.forName("org.h2.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            return con;
        }catch (ClassNotFoundException e) {
            JOptionPane.showMessageDialog(null, "ERROR : " + e.getMessage());
            return null;
        }catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "ERROR : " + e.getMessage());
            return null;
        }catch (Exception e) {
            JOptionPane.showMessageDialog(null, "ERROR : " + e.getMessage());
            return null;
        }
    }
}</pre>

<p style="text-align: justify;">
  Pada variable URL diatas, kita menggunakan ;IFEXISTS=TRUE agar H2 tidak membuat database baru secara otomatis. lalu URL ./db/TestH2 maksudnya adalah saya menaruh file TestH2.db pada folder db, yang mana folder tersebut saya tempatkan sejajar dengan folder src yang biasa ditemukan di Netbeans, Eclipse atau Intellij. Setelah itu, kita hanya perlu membuat kode untuk melakukan proses input.
</p>

<pre>try {
    Koneksi koneksi = new Koneksi();
    Connection con = koneksi.KoneksiDB();
    String sql = "insert into mahasiswa values ("+ txtNim.getText() +",'"+ txtNama.getText() +")";
    PreparedStatement preparedStatement = con.prepareStatement(sql);
    preparedStatement.executeUpdate();
    System.out.println("data berhasil disimpan");
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}</pre>

<p style="text-align: justify;">
  Pada contoh kali ini saya akan menyimpan data dengan bentuk berkas (file). Dengan begitu, kita bisa memindahkan aplikasi yang kita buat ke tempat lain tanpa harus mengkonfigurasi basis data lagi, karena sudah tersimpan di dalam file tersebut. Jika langkah-langkah di atas sudah diikuti dengan baik, kita hanya perlu menjalankan script untuk memasukan data di atas.
</p>

Sudah? Nah, sekarang silakan cek di h2 console, seharusnya data yang kita masukan sudah bisa dilihat di database TestH2 🙂

## Sumber :

  1. Wikipedia &#8211; http://en.wikipedia.org/wiki/Embedded_database
  2. H2 &#8211; http://www.h2database.com/