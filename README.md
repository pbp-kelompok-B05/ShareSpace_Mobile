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

#### Modul COD

Aplikasi ShareSpace Mobile menggunakan REST API berbasis Django REST Framework (DRF) yang disediakan oleh backend ShareSpace. Berikut daftar endpoint untuk modul COD yang tersedia di branch `feature/cod-api` (repo Django).

**Base URL:**
```text
/api/cod/
```

Path di atas digabung dengan base URL PWS, atau `http://10.0.2.2:8000` jika aplikasi dijalankan di emulator Android.

**Daftar Endpoint:**

| Method | Endpoint | Deskripsi | Catatan |
|---|---|---|---|
| GET | `/locations/` | Mengambil daftar lokasi COD | |
| POST | `/locations/` | Menambahkan lokasi COD | |
| GET | `/locations/<uuid:pk>/` | Mengambil detail lokasi COD | 404 jika tidak ditemukan |
| PUT/PATCH | `/locations/<uuid:pk>/` | Memperbarui lokasi COD | Hanya pembuat atau staff |
| DELETE | `/locations/<uuid:pk>/` | Menghapus lokasi COD | Hapus permanen, hanya pembuat atau staff. 409 jika masih dipakai jadwal COD |
| GET | `/loans/<uuid:loan_id>/schedules/` | Mengambil jadwal COD berdasarkan transaksi peminjaman | Hanya borrower, pemilik barang, atau superuser (selain itu 404) |
| POST | `/loans/<uuid:loan_id>/schedules/` | Menambahkan jadwal COD | Hanya jika status pinjaman `pending`, `approved`, atau `borrowed` (selain itu 400) |
| GET | `/schedules/<uuid:pk>/` | Mengambil detail jadwal COD | Hanya borrower, pemilik barang, atau superuser (selain itu 404) |
| PUT/PATCH | `/schedules/<uuid:pk>/` | Memperbarui jadwal COD | Hanya jika status pinjaman `pending`, `approved`, atau `borrowed` (selain itu 400) |
| DELETE | `/schedules/<uuid:pk>/` | Menghapus jadwal COD | Hanya jika status pinjaman `pending` atau `approved` (selain itu 400) |
| GET | `/places/` | Mencari tempat berdasarkan kata kunci, kategori, dan lokasi | Respons dipaginasi, input tidak valid mengembalikan 400 |

**Query Parameters untuk Places:**

| Parameter | Deskripsi |
|---|---|
| `keyword` | Kata kunci pencarian tempat (mencocokkan nama atau alamat) |
| `kind` | Kategori tempat. `kind=all` berarti tanpa filter |
| `latitude` | Latitude lokasi pencarian (-90 sampai 90). Harus dikirim bersama `longitude` |
| `longitude` | Longitude lokasi pencarian (-180 sampai 180). Harus dikirim bersama `latitude` |
| `radius` | Radius pencarian dalam meter (1-50000, default 1000). Hanya berlaku jika koordinat dikirim |
| `page` | Nomor halaman hasil |
| `page_size` | Jumlah data per halaman (default 20, maksimum 100) |

Jika koordinat dikirim, hasil diurutkan berdasarkan jarak terdekat. Jika tidak, hasil diurutkan berdasarkan nama.

**Format Respons Places:**

Respons dipaginasi (`CODPlacesPagination`), bukan array polos.

```json
{
  "count": 0,
  "next": null,
  "previous": null,
  "results": []
}
```

**Authentication:** Seluruh endpoint memerlukan autentikasi pengguna (`IsAuthenticated`). Aplikasi menggunakan session cookie, dan request tulis (POST/PUT/PATCH/DELETE) wajib menyertakan header `X-CSRFToken`.

**Kode Error:**

| Kode | Keterangan |
|---|---|
| 400 | Input tidak valid (parameter Places, atau status pinjaman tidak memenuhi syarat) |
| 403 | Tidak terautentikasi atau tidak memiliki izin |
| 404 | Resource tidak ditemukan atau tidak dapat diakses pengguna |
| 409 | Lokasi COD tidak dapat dihapus karena masih dipakai jadwal COD |

**Catatan:** Endpoint di atas tersedia di branch `dev` dan dapat diintegrasikan dengan aplikasi mobile setelah branch tersebut di-merge ke main dan di-deploy ke PWS. Penggunaan endpoint oleh aplikasi Flutter mengikuti kebutuhan masing-masing fitur.

#### Modul 1: Autentikasi & Manajemen Akun (`/api/v1/auth/`)

| Method | Endpoint | Akses | Deskripsi |
| --- | --- | --- | --- |
| `GET`, `HEAD` | `/api/v1/auth/profiles/` | Publik (read-only) | Daftar profil publik pengguna aktif (mendukung `?q=`, tanpa data kontak/alamat privat). |
| `GET`, `HEAD`, `PUT`, `PATCH` | `/api/v1/auth/profiles/me/` | Pengguna login (`IsAuthenticated`) | Mengambil dan memperbarui profil milik pengguna sendiri beserta ringkasan reputasi & Trust Score. |
| `GET`, `HEAD` | `/api/v1/auth/profiles/<str:username>/` | Publik (read-only) | Detail profil publik pengguna berdasarkan `username` beserta ringkasan reputasi. |
| `POST` | `/api/v1/auth/help-requests/` | Tamu belum login | Mengirim permohonan bantuan login / kendala akun dengan respons netral anti-enumeration. |
| `GET`, `POST` | `/api-auth/login/` | Publik | Route login sesi bawaan *Browsable API* DRF (bukan endpoint JSON untuk Flutter). |
| `GET`, `POST` | `/api-auth/logout/` | Pengguna login | Route logout sesi bawaan *Browsable API* DRF (bukan endpoint JSON untuk Flutter). |

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
