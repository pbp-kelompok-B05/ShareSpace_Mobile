import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sharespace_mobile/features/items/data/item_service.dart';

import 'item_test.dart' show sampleItemJson;

http.Response _json(Object body, [int status = 200]) => http.Response(
      jsonEncode(body),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

ItemService _service(MockClientHandler handler) =>
    ItemService(client: MockClient(handler), baseUrl: 'http://test.local');

void main() {
  group('ItemService.fetchItems', () {
    test('memanggil endpoint daftar dan mengurai array JSON', () async {
      late Uri requested;
      final service = _service((request) async {
        requested = request.url;
        return _json([sampleItemJson(id: 1), sampleItemJson(id: 2)]);
      });

      final items = await service.fetchItems();

      expect(requested.path, '/api/v1/items/');
      expect(requested.queryParameters['sort'], 'newest');
      expect(items.map((e) => e.id), [1, 2]);
    });

    test('mengirim filter sebagai query parameter', () async {
      late Uri requested;
      final service = _service((request) async {
        requested = request.url;
        return _json([]);
      });

      await service.fetchItems(const ItemFilter(
        query: ' tenda ',
        category: 'outdoor',
        condition: 'good',
        availableOnly: true,
        sort: 'name',
      ));

      expect(requested.queryParameters, {
        'q': 'tenda',
        'category': 'outdoor',
        'condition': 'good',
        'available': 'true',
        'sort': 'name',
      });
    });

    test('daftar kosong menghasilkan list kosong', () async {
      final items = await _service((_) async => _json([])).fetchItems();
      expect(items, isEmpty);
    });

    test('memakai pesan detail dari server pada error', () async {
      final service =
          _service((_) async => _json({'detail': 'Tidak diizinkan.'}, 403));

      expect(
        service.fetchItems(),
        throwsA(isA<ApiException>()
            .having((e) => e.message, 'message', 'Tidak diizinkan.')
            .having((e) => e.statusCode, 'statusCode', 403)),
      );
    });

    test('pesan umum untuk 500 dengan body HTML', () async {
      final service =
          _service((_) async => http.Response('<html>error</html>', 500));

      expect(
        service.fetchItems(),
        throwsA(isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('gangguan pada server'),
        )),
      );
    });

    test('pesan untuk 429', () async {
      final service = _service((_) async => http.Response('', 429));

      expect(
        service.fetchItems(),
        throwsA(isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('Terlalu banyak permintaan'),
        )),
      );
    });

    test('gangguan jaringan menjadi ApiException', () async {
      final service =
          _service((_) async => throw http.ClientException('putus'));

      expect(
        service.fetchItems(),
        throwsA(isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('Tidak dapat terhubung'),
        )),
      );
    });

    test('body 200 yang bukan array menjadi ApiException', () async {
      final service = _service((_) async => _json({'foo': 'bar'}));

      expect(
        service.fetchItems(),
        throwsA(isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('tidak dapat dibaca'),
        )),
      );
    });

    test('timeout menjadi ApiException', () {
      final service = ItemService(
        client: MockClient((_) => Completer<http.Response>().future),
        baseUrl: 'http://test.local',
        timeout: const Duration(milliseconds: 20),
      );

      expect(
        service.fetchItems(),
        throwsA(isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('terlalu lama'),
        )),
      );
    });
  });
}
