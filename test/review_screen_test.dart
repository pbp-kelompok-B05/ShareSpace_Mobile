import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/screens/review_screen.dart';

void main() {
  testWidgets('Halaman modul bisa dibuka dan dikunjungi dari menu', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => Navigator.of(context).push<void>(
                MaterialPageRoute<void>(builder: (_) => const ReviewScreen()),
              ),
              child: const Text('Buka modul'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Buka modul'));
    await tester.pumpAndSettle();

    expect(find.text('Review, Reputasi & Laporan'), findsOneWidget);
    expect(find.text('Modul ini sedang dikembangkan.'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Buka modul'), findsOneWidget);
  });
}
