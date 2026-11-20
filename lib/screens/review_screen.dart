import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review, Reputasi & Laporan')),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Modul ini sedang dikembangkan.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
