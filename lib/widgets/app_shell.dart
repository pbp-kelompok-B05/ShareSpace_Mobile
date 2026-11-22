import 'package:flutter/material.dart';

import '../features/items/presentation/items_page.dart';
import '../screens/review_screen.dart';
import 'app_drawer.dart';
import 'coming_soon_page.dart';

/// Kerangka aplikasi: AppBar + drawer + halaman modul terpilih.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppModule _selected = AppModule.items;

  // Tiap anggota mengganti ComingSoonPage dengan halaman modulnya.
  Widget _pageFor(AppModule module) => switch (module) {
    AppModule.items => const ItemsPage(),
    AppModule.reviews => const ReviewScreen(),
    _ => ComingSoonPage(title: module.title),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selected.title)),
      drawer: AppDrawer(
        selected: _selected,
        onSelect: (module) => setState(() => _selected = module),
      ),
      body: _pageFor(_selected),
    );
  }
}
