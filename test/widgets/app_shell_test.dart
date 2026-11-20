import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/widgets/app_drawer.dart';
import 'package:sharespace_mobile/widgets/coming_soon_page.dart';

void main() {
  testWidgets('drawer memuat kelima modul dan memanggil onSelect',
      (tester) async {
    AppModule? picked;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: AppDrawer(
          selected: AppModule.items,
          onSelect: (m) => picked = m,
        ),
        body: const SizedBox(),
      ),
    ));

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    for (final module in AppModule.values) {
      expect(find.text(module.title), findsOneWidget);
    }

    await tester.tap(find.text(AppModule.loans.title));
    await tester.pumpAndSettle();
    expect(picked, AppModule.loans);
  });

  testWidgets('ComingSoonPage menampilkan judul modul', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ComingSoonPage(title: 'Review & Laporan'),
    ));
    expect(find.textContaining('Review & Laporan'), findsOneWidget);
    expect(find.textContaining('Segera hadir'), findsOneWidget);
  });
}
