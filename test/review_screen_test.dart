import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/main.dart';
import 'package:sharespace_mobile/screens/review_screen.dart';
import 'package:sharespace_mobile/widgets/app_drawer.dart';

void main() {
  testWidgets('Drawer ShareSpace membuka modul Review tanpa AppBar ganda', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    Future<void> selectModule(AppModule module) async {
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      final entry = find.widgetWithText(ListTile, module.title);
      await tester.ensureVisible(entry);
      await tester.tap(entry);
      await tester.pumpAndSettle();
    }

    await tester.pumpWidget(const ShareSpaceApp());
    await tester.pumpAndSettle();
    await selectModule(AppModule.reviews);

    expect(find.byType(ReviewScreen), findsOneWidget);
    expect(find.text('Modul ini sedang dikembangkan.'), findsOneWidget);
    expect(
      find.widgetWithText(AppBar, AppModule.reviews.title),
      findsOneWidget,
    );
    expect(find.byType(AppBar), findsOneWidget);
    expect(tester.takeException(), isNull);

    await selectModule(AppModule.items);
    expect(find.byType(ReviewScreen), findsNothing);
    expect(find.widgetWithText(AppBar, AppModule.items.title), findsOneWidget);
  });
}
