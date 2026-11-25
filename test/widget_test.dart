import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/main.dart';
import 'package:sharespace_mobile/widgets/app_drawer.dart';

// Tanpa server: flutter_test membalas request HTTP dengan status 400.
void main() {
  testWidgets('ShareSpaceApp terbuka di Katalog', (tester) async {
    await tester.pumpWidget(const ShareSpaceApp());

    // Halaman awal: Katalog Barang dengan indikator loading.
    expect(find.widgetWithText(AppBar, AppModule.items.title), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('Coba lagi'), findsOneWidget);
  });
}
