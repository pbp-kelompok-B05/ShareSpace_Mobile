# ShareSpace Mobile ♻️

**Proyek Akhir Semester Pemrograman Berbasis Platform — Kelompok B05**

**Tema:** Sustainable Living — Waste Management & Conscious Shopping

## Deskripsi Aplikasi

ShareSpace Mobile adalah versi Flutter dari ShareSpace Web, platform peminjaman barang berbasis komunitas untuk mahasiswa dan warga sekitar. Pengguna bisa meminjam barang yang hanya sesekali dibutuhkan, seperti kalkulator, raket, atau buku referensi, tanpa harus membeli baru. Tujuannya adalah menghemat biaya dan mengurangi limbah dengan memanfaatkan barang yang sudah ada.

## Anggota Kelompok

| Nama                     | NPM        |
| ------------------------ | ---------- |
| Muhammad Taufiq Ramadhan | 2506536143 |
| Azka Nur Jauhar          | 2506612410 |
| Fadhil Abdurrohman       | 2506656690 |
| Maximus Quinn Hertada    | 2506613552 |
| Matthew Raeann Alexandra | 2506544763 |

## Daftar Modul dan Pembagian Kerja

Pembagian modul mengikuti Proyek Tengah Semester. Tabel ini menjelaskan cakupan modul yang akan dibawa ke aplikasi mobile.

| No. | Modul                           | Penanggung Jawab         | Cakupan                                                                                      |
| --- | ------------------------------- | ------------------------ | -------------------------------------------------------------------------------------------- |
| 1   | Autentikasi & Manajemen Akun    | Azka Nur Jauhar          | Registrasi, masuk, keluar, dan pengelolaan profil pengguna.                                  |
| 2   | Katalog & Manajemen Barang      | Matthew Raeann Alexandra | Menelusuri katalog, melihat detail, dan mengelola barang yang dipinjamkan.                   |
| 3   | Transaksi Peminjaman            | Fadhil Abdurrohman       | Mengajukan dan menanggapi permintaan serta memantau status peminjaman hingga pengembalian.   |
| 4   | Lokasi COD & Jadwal Pengambilan | Muhammad Taufiq Ramadhan | Menentukan titik temu serta menjadwalkan pengambilan dan pengembalian barang.                |
| 5   | Review, Reputasi & Laporan      | Maximus Quinn Hertada    | Memberi ulasan setelah transaksi selesai, melihat reputasi pengguna, dan melaporkan masalah. |

## Peran Pengguna

- **Peminjam:** mencari barang, mengajukan peminjaman, dan mengikuti perkembangan transaksi.
- **Pemilik barang:** menawarkan dan mengelola barang serta menanggapi permintaan peminjaman.
- **Admin:** mengawasi aktivitas platform dan meninjau laporan pengguna.

Satu akun dapat berperan sebagai peminjam dan pemilik barang, tergantung transaksinya.

## Alur Integrasi Mobile dan Web

Aplikasi Flutter dirancang untuk memakai backend Django dari ShareSpace Web di PWS. Keduanya menggunakan basis data ShareSpace yang sama di server Django. Flutter tidak mengakses basis data secara langsung.

1. Flutter mengirim permintaan HTTPS ke endpoint modul di **Django REST Framework (DRF)** pada ShareSpace Web.
2. Backend memeriksa hak akses, memvalidasi data masukan, lalu membaca atau memperbarui data melalui model Django.
3. Backend mengirim respons JSON. Flutter mengolah respons untuk menampilkan data, memperbarui tampilan setelah perubahan, atau menampilkan pesan kesalahan.

### Daftar Endpoint DRF

Daftar URL dan metode HTTP per modul akan ditambahkan setelah endpoint tersedia dan diuji. Tautan PWS di bawah mengarah ke situs web ShareSpace, bukan ke daftar endpoint API.

#### Modul 1: Autentikasi & Manajemen Akun (`/api/v1/auth/`)

| Method | Endpoint | Akses | Deskripsi |
| --- | --- | --- | --- |
| `GET`, `HEAD` | `/api/v1/auth/profiles/` | Publik (read-only) | Daftar profil publik pengguna aktif (mendukung `?q=`, tanpa data kontak/alamat privat). |
| `GET`, `HEAD`, `PUT`, `PATCH` | `/api/v1/auth/profiles/me/` | Pengguna login (`IsAuthenticated`) | Mengambil dan memperbarui profil milik pengguna sendiri beserta ringkasan reputasi & Trust Score. |
| `GET`, `HEAD` | `/api/v1/auth/profiles/<str:username>/` | Publik (read-only) | Detail profil publik pengguna berdasarkan `username` beserta ringkasan reputasi. |
| `POST` | `/api/v1/auth/help-requests/` | Tamu belum login | Mengirim permohonan bantuan login / kendala akun dengan respons netral anti-enumeration. |
| `GET`, `POST` | `/api-auth/login/` | Publik | Route login sesi bawaan *Browsable API* DRF (bukan endpoint JSON untuk Flutter). |
| `POST` | `/api-auth/logout/` | Pengguna login | Route logout sesi bawaan *Browsable API* DRF (bukan endpoint JSON untuk Flutter). |

## Menjalankan Proyek Secara Lokal

Dengan Flutter SDK terpasang dan perangkat atau emulator terdeteksi, jalankan dari folder `sharespace_mobile` (PowerShell atau Git Bash):

```sh
flutter pub get
flutter run
```

## Tautan Penting

- [Repositori backend ShareSpace Web](https://github.com/pbp-kelompok-B05/ShareSpace)
- [Situs ShareSpace Web di PWS](https://pws.cs.ui.ac.id/maximus.quinn/sharespace)
- **Desain Figma mobile:** menyusul.
- **APK:** menyusul setelah rilis.

## Penggunaan AI
