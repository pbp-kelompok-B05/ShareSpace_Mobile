import 'package:flutter/material.dart';

import '../features/items/presentation/items_page.dart';
import '../screens/auth_checkpoint_screen.dart';
import '../screens/cod_screen.dart';
import '../screens/loan_screen.dart';
import '../screens/review_screen.dart';
import 'app_drawer.dart';

/// Kerangka aplikasi: AppBar + drawer + halaman modul terpilih.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppModule _selected = AppModule.items;

  Widget _pageFor(AppModule module) => switch (module) {
    AppModule.auth => const AuthCheckpointScreen(),
    AppModule.items => const ItemsPage(),
    AppModule.loans => const LoanScreen(showAppBar: false),
    AppModule.cod => const CodScreen(),
    AppModule.reviews => const ReviewScreen(),
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
