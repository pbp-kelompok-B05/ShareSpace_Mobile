import 'package:flutter/material.dart';

/// Halaman sementara sampai modul akun siap disambungkan ke AppShell.
class AuthCheckpointScreen extends StatelessWidget {
  const AuthCheckpointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Masuk dan kelola akun ShareSpace.'),
          SizedBox(height: 8),
          Text('Login dan pengelolaan profil belum tersedia di aplikasi ini.'),
        ],
      ),
    );
  }
}
