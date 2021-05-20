---
title: "Install dan konfigurasi JDK, Netbeans dan Eclipse di Linux Mint"
date: 2011-07-19T18:53:44+00:00

---
Bagi yang baru ingin memulai belajar programming menggunakan Java, atau bahkan sudah lama menggunakan Java tapi baru menggunakan Linux, atau bahkan belum pernah menggunakan Java dan belum pernah menggunakan Linux :D, di sini saya akan menulis tutorial singkat bagaimana menginstall dan mengkonfigurasi JDK, Netbeans dan Eclipse langkah demi langkah. Saya biasa menggunakan Eclipse untuk belajar Android Programming, dan Netbeans untuk Java Web, dll. Tapi tentu saja semua itu bukanlah paksaan, kamu bisa memilih IDE kesayangan masing-masing dalam membangun suatu aplikasi :)
<!--more-->
## 1. Install JDK
Download JDK <a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html">disini</a>.
<li style="text-align: justify;">
  Buka terminal, lalu pergi ke direktori tempat JDK yang sudah di download tadi berada, Misal berada di direktori /home/kusandriadi/data/app/ berarti ketikan
</li>

> $cd data/app

  * lalu ubah permission dari JDK tersebut, dengan perintah :

> $chmod +x nama_jdk.bin

  * Setelah itu, execute file bin tersebut dengan perintah :

> $./nama_jdk.bin

<li style="text-align: justify;">
  Menginstall JDK, tidak serta merta membuat Linux bisa membaca JDK tersebut, secara default dia hanya membaca OpenJDK, cara mengubahnya yaitu kamu bisa membuka file &#8220;# sudo gedit /etc/profile&#8221; dan &#8220;#sudo gedit /etc/bash.bashrc&#8221; lalu dibaris paling bawah menambahkan baris :
</li>

> JAVA\_HOME=/home/kusandriadi/data/app/jdk1.6.0\_25  
> export JAVA_HOME  
> PATH=$JAVA_HOME/bin:$PATH  
> export PATH

## 2. Install Netbeans

  * Download Netbeans [disini][1].

<li style="text-align: justify;">
  Buka terminal, lalu pergi ke direktori tempat Netbeans yang sudah di download tadi berada, Misal berada di direktori /home/kusandriadi/data/app/ berarti ketikan
</li>

> $cd data/app

  * lalu ubah permission dari Netbeans tersebut, dengan perintah :

> $chmod +x netbeans.sh

  * Setelah itu, execute file netbeans.sh tersebut dengan perintah :

> $ sh netbeans.sh

  * Setelah itu akan keluar wizard, dan kamu hanya perlu mengikuti urutannya seperti di windows 😀

## 3. Install Eclipse

<li style="text-align: justify;">
  Download Eclipse <a href="http://kambing.ui.ac.id">disini.</a> (Mirror Lokal biar cepet :D)
</li>
<li style="text-align: justify;">
  Klik Kanan, extract here, selesai&#8230;wkwkwkwkwk..
</li>
<li style="text-align: justify;">
  Kalau mau menambah menu Eclipse, tambahkan secara manual lewat Main Menu di Preference, lalu klik kanan &#8220;add to desktop&#8221; untuk menambahkan icon eclipse ke desktop
</li>

Sudah selesai? So, Give them the code 😀

Regards,

[<img loading="lazy" class="alignnone size-full wp-image-481" title="tandatangankecil" alt="" src="https://i2.wp.com/blog.kusandriadi.com/wp-content/uploads/2009/03/tandatangankecil.png?resize=195%2C53" width="195" height="53" data-recalc-dims="1" />][2]

 [1]: http://netbeans.org/downloads/
 [2]: https://i2.wp.com/blog.kusandriadi.com/wp-content/uploads/2009/03/tandatangankecil.png