import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/features/items/data/item.dart';

/// Contoh JSON sesuai ItemSerializer di backend (hanya fixture test).
Map<String, dynamic> sampleItemJson({
  int id = 1,
  String imageUrl = '',
  bool isAvailable = true,
}) =>
    {
      'id': id,
      'name': 'Tenda Dome',
      'description': 'Tenda kapasitas empat orang, kondisi bagus.',
      'category': 'outdoor',
      'category_display': 'Outdoor & Camping',
      'condition': 'good',
      'condition_display': 'Baik',
      'image_url': imageUrl,
      'image': 'http://10.0.2.2:8000/static/items/img/placeholders/outdoor.svg',
      'is_available': isAvailable,
      'is_verified': true,
      'owner': {'id': 7, 'username': 'budi'},
      'created_at': '2026-11-01T08:30:00+00:00',
    };

void main() {
  group('Item.fromJson', () {
    test('memetakan semua field serializer', () {
      final item = Item.fromJson(sampleItemJson());

      expect(item.id, 1);
      expect(item.name, 'Tenda Dome');
      expect(item.category, 'outdoor');
      expect(item.categoryDisplay, 'Outdoor & Camping');
      expect(item.condition, 'good');
      expect(item.conditionDisplay, 'Baik');
      expect(item.isAvailable, isTrue);
      expect(item.isVerified, isTrue);
      expect(item.owner.id, 7);
      expect(item.owner.username, 'budi');
      expect(item.createdAt, DateTime.utc(2026, 11, 1, 8, 30));
    });

    test('image_url kosong menjadi string kosong', () {
      final item = Item.fromJson(sampleItemJson(imageUrl: ''));
      expect(item.imageUrl, isEmpty);
    });

    test('image_url null tidak membuat parsing gagal', () {
      final json = sampleItemJson()..['image_url'] = null;
      expect(Item.fromJson(json).imageUrl, isEmpty);
    });

    test('created_at tidak valid menjadi null', () {
      final json = sampleItemJson()..['created_at'] = 'bukan-tanggal';
      expect(Item.fromJson(json).createdAt, isNull);
    });
  });
}
