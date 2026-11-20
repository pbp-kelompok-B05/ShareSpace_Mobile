import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sharespace_mobile/features/items/data/item_service.dart';
import 'package:sharespace_mobile/features/items/presentation/items_page.dart';

import 'item_test.dart' show sampleItemJson;

Widget _app(ItemService service) => MaterialApp(
      home: Scaffold(body: ItemsPage(service: service)),
    );

ItemService _service(MockClientHandler handler) =>
    ItemService(client: MockClient(handler), baseUrl: 'http://test.local');

http.Response _ok(Object body) => http.Response(
      jsonEncode(body),
      200,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

void main() {
  testWidgets('menampilkan loading lalu daftar barang', (tester) async {
    final completer = Completer<http.Response>();
    await tester.pumpWidget(_app(_service((_) => completer.future)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(_ok([
      sampleItemJson(id: 1),
      sampleItemJson(id: 2, isAvailable: false),
    ]));
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Tenda Dome'), findsNWidgets(2));
    expect(find.text('Tersedia'), findsOneWidget);
    expect(find.text('Sedang Dipinjam'), findsOneWidget);
  });

  testWidgets('menampilkan pesan dan tombol coba lagi saat error',
      (tester) async {
    var calls = 0;
    await tester.pumpWidget(_app(_service((_) async {
      calls++;
      if (calls == 1) return http.Response('', 500);
      return _ok([sampleItemJson()]);
    })));
    await tester.pumpAndSettle();

    expect(find.textContaining('gangguan pada server'), findsOneWidget);
    expect(find.text('Coba lagi'), findsOneWidget);

    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();

    expect(calls, 2);
    expect(find.text('Tenda Dome'), findsOneWidget);
  });

  testWidgets('menampilkan keadaan kosong', (tester) async {
    await tester.pumpWidget(_app(_service((_) async => _ok([]))));
    await tester.pumpAndSettle();

    expect(find.text('Belum ada barang di katalog.'), findsOneWidget);
  });

  testWidgets('gangguan jaringan menampilkan pesan koneksi', (tester) async {
    await tester.pumpWidget(_app(_service(
      (_) async => throw http.ClientException('putus'),
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('Tidak dapat terhubung'), findsOneWidget);
  });
}
