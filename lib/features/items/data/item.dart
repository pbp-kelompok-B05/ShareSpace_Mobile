/// Pemilik barang, sesuai objek `owner` pada serializer DRF.
class ItemOwner {
  const ItemOwner({required this.id, required this.username});

  final int id;
  final String username;

  factory ItemOwner.fromJson(Map<String, dynamic> json) => ItemOwner(
        id: json['id'] as int,
        username: json['username'] as String? ?? '',
      );
}

/// Barang pada katalog. Nama field mengikuti `ItemSerializer` (items/serializers.py).
class Item {
  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.categoryDisplay,
    required this.condition,
    required this.conditionDisplay,
    required this.imageUrl,
    required this.isAvailable,
    required this.isVerified,
    required this.owner,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String description;

  /// Nilai TextChoices backend (mis. `electronics`), dipakai untuk filter/kirim.
  final String category;

  /// Label tampilan dari server (mis. `Elektronik`).
  final String categoryDisplay;
  final String condition;
  final String conditionDisplay;

  /// URL foto dari pemilik; kosong jika tidak ada.
  final String imageUrl;
  final bool isAvailable;
  final bool isVerified;
  final ItemOwner owner;
  final DateTime? createdAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        category: json['category'] as String? ?? 'other',
        categoryDisplay: json['category_display'] as String? ?? '',
        condition: json['condition'] as String? ?? '',
        conditionDisplay: json['condition_display'] as String? ?? '',
        imageUrl: json['image_url'] as String? ?? '',
        isAvailable: json['is_available'] as bool? ?? false,
        isVerified: json['is_verified'] as bool? ?? false,
        owner: ItemOwner.fromJson(json['owner'] as Map<String, dynamic>),
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      );
}
