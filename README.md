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

#### Modul 3 — Transaksi Peminjaman (`/api/loans/`)

| Method | Endpoint | Akses | Deskripsi |
| --- | --- | --- | --- |
| `GET`, `HEAD` | `/api/loans/?role=borrower` | Pengguna login (`IsAuthenticated`) | Daftar pengajuan milik pengguna sebagai peminjam, mendukung filter `status` dan paginasi `page`. |
| `GET`, `HEAD` | `/api/loans/?role=lender` | Pengguna login (`IsAuthenticated`) | Daftar pengajuan untuk barang milik pengguna, mendukung filter `status` dan paginasi `page`. |
| `POST` | `/api/loans/` | Pengguna login dengan reCAPTCHA valid | Mengajukan peminjaman dengan `item`, `start_date`, `due_date`, dan `notes` opsional. |
| `GET`, `HEAD` | `/api/loans/<uuid:pk>/` | Peminjam atau pemilik barang terkait | Mengambil detail transaksi, status, dan daftar tindakan yang dapat dilakukan pengguna. |
| `PATCH` | `/api/loans/<uuid:pk>/` | Peminjam terkait | Memperbarui tanggal atau catatan pengajuan yang masih berstatus `pending`. |
| `POST` | `/api/loans/<uuid:pk>/cancel/` | Peminjam terkait | Membatalkan pengajuan yang masih berstatus `pending`. |
| `POST` | `/api/loans/<uuid:pk>/approve/` | Pemilik barang terkait | Menyetujui pengajuan, membuat barang tidak tersedia, dan menolak pengajuan pending lainnya untuk barang tersebut. |
| `POST` | `/api/loans/<uuid:pk>/reject/` | Pemilik barang terkait | Menolak pengajuan yang masih berstatus `pending`. |
| `POST` | `/api/loans/<uuid:pk>/mark-borrowed/` | Pemilik barang terkait | Mencatat penyerahan barang dengan mengubah status `approved` menjadi `borrowed`. |
| `POST` | `/api/loans/<uuid:pk>/request-return/` | Peminjam terkait | Mengajukan pengembalian barang pada transaksi berstatus `borrowed`. |
| `POST` | `/api/loans/<uuid:pk>/complete/` | Pemilik barang terkait | Mengonfirmasi pengembalian, menyelesaikan transaksi, dan membuat barang tersedia kembali jika belum dihapus. |

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
