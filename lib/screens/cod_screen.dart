import 'package:flutter/material.dart';

/// Halaman awal modul COD; belum memuat lokasi atau jadwal dari API.
class CodScreen extends StatelessWidget {
  const CodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Tentukan lokasi dan jadwal serah terima barang.'),
          SizedBox(height: 8),
          Text('Daftar lokasi COD dan jadwal belum tersedia di aplikasi ini.'),
        ],
      ),
    );
  }
}
