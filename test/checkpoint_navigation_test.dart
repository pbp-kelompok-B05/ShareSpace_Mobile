import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/features/items/presentation/items_page.dart';
import 'package:sharespace_mobile/main.dart';
import 'package:sharespace_mobile/screens/loan_screen.dart';
import 'package:sharespace_mobile/screens/review_screen.dart';
import 'package:sharespace_mobile/widgets/app_drawer.dart';

void main() {
  testWidgets('Kelima modul bisa dibuka dari drawer pada lebar 320 px', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ShareSpaceApp());
    await tester.pumpAndSettle();

    final pages = <AppModule, Finder>{
      AppModule.loans: find.byType(LoanScreen),
      AppModule.auth: find.text('Masuk dan kelola akun ShareSpace.'),
      AppModule.cod: find.text(
        'Tentukan lokasi dan jadwal serah terima barang.',
      ),
      AppModule.reviews: find.byType(ReviewScreen),
      AppModule.items: find.byType(ItemsPage),
    };
    expect(pages.keys, unorderedEquals(AppModule.values));

    for (final entry in pages.entries) {
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      final tile = find.widgetWithText(ListTile, entry.key.title);
      await tester.ensureVisible(tile);
      await tester.tap(tile);
      await tester.pumpAndSettle();

      expect(entry.value, findsOneWidget, reason: entry.key.title);
      expect(find.byType(AppBar), findsOneWidget, reason: entry.key.title);
      expect(find.widgetWithText(AppBar, entry.key.title), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });
}
