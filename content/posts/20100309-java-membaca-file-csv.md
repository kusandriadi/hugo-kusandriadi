---
title: '[Java] Membaca File CSV'
author: Kus Andriadi
type: post
date: 2010-03-09T14:15:47+00:00
url: /java-membaca-file-csv/
categories:
  - Activities

---
<p style="text-align: justify;">
  Jika saya kutip dari <a href="http://achmatim.net/2010/03/09/baca-tulis-file-csv-dengan-php/" target="_blank">achmatim.net</a>.
</p>

<blockquote style="text-align: justify;">
  <p style="text-align: justify;">
    <strong>CSV</strong> atau <strong>Comma-Separated Value</strong> merupakan suatu format penyajian data teks dimana setiap data (field) dipisahkan dengan suatu pemisah koma (,) dan setiap baris record dipisahkan dengan baris baru (line-break). Selain menggunakan pemisah (delimiter) koma terkadang jenis file CSV juga dapat dipisahkan dengan titik-koma ( ; ) atau karakter <tab>. Jenis file CSV sendiri, dapat dibaca oleh semua software pengolah data (spreadsheet) seperti Microsoft Excel dan OpenOffice Calc.
  </p>
</blockquote>

<p style="text-align: justify;">
  <!--more-->Pemisah atau delimiter biasanya ditandai dengan &#8221; , &#8221; tapi itu semua tergantung kebutuhan karena kita sendiri bisa menentukan pemisah seperti apa yang akan kita gunakan, di contoh program di bawah ini saya akan menggunakan &#8220;#&#8221; sebagai pemisah.
</p>

<p style="text-align: justify;">
  Seperti yang kita ketahui, ketika kita akan membeli kartu perdana telepon seluler, kita pasti disuruh mendaftar dengan format (saya ambil singkat saja) :
</p>

  * no.id#nama lengkap#pekerjaan#alamat

Untuk itu sebelum anda membuat source code untuk membaca format diatas, buatlah file bacaTeks.txt dengan notepad isinya :

> 32.000.92819#Kus Andriadi#Mahasiswa#Jl.Mangga No.1

Misal format diatas adalah format yang dibutuhkan, lalu bagaimana cara nya memasukan data tersebut ke database? yah, tentu saja format diatas tidak serta merta di input langsung ke database, tapi harus di pilah-pilah terlebih dahulu, ada banyak cara memisahkan String di java dengan delimiter tertentu, disini saya menggunakan class Scanner dari java.util, berikut source code nya :

[codesyntax lang=&#8221;java&#8221;]

<pre>import java.util.*;
import java.io.*;

public class ReadFile{

	private File file;

	private Scanner input;

	private String kodePen, nama, pekerjaan, alamat;

	public ReadFile(){
		try{
			file = new File("bacaTeks.txt");
			input = new Scanner(file);

			input.useDelimiter("#");
			while(input.hasNext()){
				kodePen = input.next();
				nama = input.next();
				pekerjaan = input.next();
				alamat = input.next();
				cetak(kodePen,nama,pekerjaan,alamat);
			}
			input.close();
		}catch(Exception e){
			System.out.println("ERROR : " + e.getMessage());
		}
	}

	private void cetak(String kodePen, String nama, String pekerjaan, String alamat){
		System.out.println("Kode Penduduk :   " + kodePen);
		System.out.println("Nama          :   " + nama);
		System.out.println("Pekerjaan     :   " + pekerjaan);
		System.out.println("alamat        :   " + alamat);
	}

	public static void main(String[] args){
		new ReadFile();
	}
}</pre>

[/codesyntax]

taruh sejajar program diatas dengan file bacaTeks.txt, output dari program diatas akan seperti ini :

[codesyntax lang=&#8221;text&#8221;]

Kode Penduduk : 32.000.92819  
Nama : Kus Andriadi  
Pekerjaan : Mahasiswa  
alamat :  Jl.Mangga No.1

[/codesyntax]

Tentunya output bisa disesuaikan sesuai kebutuhan, bisa langsung diinput ke query untuk segera di masukan kedalam database,dst. Semoga contoh sederhana ini bisa berguna 🙂