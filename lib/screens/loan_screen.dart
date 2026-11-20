import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LoanScreen()));

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi Peminjaman')),
      body: ListView(
        children: const [
          _LoanRole(
            title: 'Sebagai peminjam',
            icon: Icons.person_outline,
            steps: [
              'Ajukan peminjaman dengan memilih barang dan tanggal peminjaman.',
              'Pantau status pengajuan. Selama masih menunggu, pengajuan dapat diubah atau dibatalkan.',
              'Setelah selesai menggunakan barang, ajukan pengembalian kepada pemilik.',
            ],
          ),
          _LoanRole(
            title: 'Sebagai pemilik barang',
            icon: Icons.inventory_2_outlined,
            steps: [
              'Tinjau pengajuan untuk barang milikmu, lalu setujui atau tolak.',
              'Setelah barang diserahkan, tandai barang sebagai dipinjam.',
              'Konfirmasi pengembalian setelah barang diterima kembali.',
            ],
          ),
        ],
      ),
    );
  }
}

class _LoanRole extends StatelessWidget {
  const _LoanRole({required this.title, required this.icon, required this.steps});

  final String title;
  final IconData icon;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final step in steps)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(step),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
