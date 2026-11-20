import 'package:flutter/material.dart';

/// Halaman sementara untuk modul yang belum dikerjakan pemiliknya.
/// Ganti dengan halaman modul masing-masing di `AppShell`.
class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          '$title\nSegera hadir.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
