import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/main.dart';
import 'package:sharespace_mobile/widgets/app_drawer.dart';

// Smoke test: aplikasi utuh bisa dibangun dan navigasi drawer berjalan.
// Tanpa server: binding flutter_test membalas setiap request HTTP dengan
// status 400, jadi katalog berakhir di state error, bukan menunggu jaringan.
void main() {
  testWidgets('ShareSpaceApp terbuka di Katalog dan drawer berpindah modul',
      (tester) async {
    await tester.pumpWidget(const ShareSpaceApp());

    // Halaman awal: Katalog Barang dengan indikator loading.
    expect(find.widgetWithText(AppBar, AppModule.items.title), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('Coba lagi'), findsOneWidget);

    // Pindah ke modul lain lewat drawer.
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppModule.loans.title));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, AppModule.loans.title), findsOneWidget);
    expect(find.textContaining('Segera hadir'), findsOneWidget);
  });
}
