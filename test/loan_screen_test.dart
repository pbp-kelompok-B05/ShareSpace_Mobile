import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/screens/loan_screen.dart' show LoanScreen;

void main() {
  const roles = {
    'Sebagai peminjam': 'Ajukan peminjaman dengan memilih barang dan tanggal peminjaman.',
    'Sebagai pemilik barang': 'Tinjau pengajuan untuk barang milikmu, lalu setujui atau tolak.',
  };

  for (final role in roles.entries) {
    testWidgets('Buka alur ${role.key} dan kembali ke modul', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoanScreen()));
      expect(find.widgetWithText(AppBar, 'Transaksi Peminjaman'), findsOneWidget);

      await tester.tap(find.text(role.key));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, role.key), findsOneWidget);
      expect(find.text(role.value), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Transaksi Peminjaman'), findsOneWidget);
    });
  }
}