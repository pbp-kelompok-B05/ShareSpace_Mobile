import 'package:flutter/material.dart';

/// Modul aplikasi pada navigasi. Urutan mengikuti pembagian modul kelompok.
enum AppModule {
  auth('Autentikasi & Akun', Icons.person_outline),
  items('Katalog Barang', Icons.storefront_outlined),
  loans('Transaksi Peminjaman', Icons.swap_horiz),
  cod('Lokasi COD & Jadwal', Icons.place_outlined),
  reviews('Review & Laporan', Icons.star_outline);

  const AppModule(this.title, this.icon);

  final String title;
  final IconData icon;
}

/// Drawer navigasi antarmodul.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.selected, required this.onSelect});

  final AppModule selected;
  final ValueChanged<AppModule> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: scheme.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ShareSpace',
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pinjam barang, kurangi limbah.',
                  style: TextStyle(color: scheme.onPrimary),
                ),
              ],
            ),
          ),
          for (final module in AppModule.values)
            ListTile(
              leading: Icon(module.icon),
              title: Text(module.title),
              selected: module == selected,
              onTap: () {
                Navigator.pop(context); // tutup drawer
                onSelect(module);
              },
            ),
        ],
      ),
    );
  }
}
