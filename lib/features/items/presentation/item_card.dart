import 'package:flutter/material.dart';

import '../data/item.dart';

/// Ikon pengganti per kategori jika foto kosong atau gagal dimuat.
/// (Placeholder dari server berformat SVG sehingga tidak dipakai di Flutter.)
IconData categoryIcon(String category) => switch (category) {
      'electronics' => Icons.devices_other,
      'household' => Icons.handyman,
      'sports' => Icons.sports_soccer,
      'books' => Icons.menu_book,
      'hobby' => Icons.piano,
      'outdoor' => Icons.terrain,
      _ => Icons.inventory_2,
    };

/// Kartu satu barang pada daftar katalog.
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, this.onTap});

  final Item item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Thumbnail(item: item),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.categoryDisplay} · ${item.conditionDisplay}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Oleh ${item.owner.username}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _AvailabilityBadge(isAvailable: item.isAvailable),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.item});

  final Item item;

  static const double _size = 80;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = Container(
      width: _size,
      height: _size,
      color: scheme.secondary,
      child: Icon(categoryIcon(item.category), color: scheme.primary, size: 36),
    );
    return Semantics(
      label: 'Foto ${item.name}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: item.imageUrl.isEmpty
            ? placeholder
            : Image.network(
                item.imageUrl,
                width: _size,
                height: _size,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => placeholder,
                loadingBuilder: (context, child, progress) =>
                    progress == null ? child : placeholder,
              ),
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  const _AvailabilityBadge({required this.isAvailable});

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Warna amber/on-amber mengikuti badge "Sedang Dipinjam" di web.
    final background =
        isAvailable ? scheme.secondary : const Color(0xFFF2B632);
    final foreground = isAvailable ? scheme.onSecondary : const Color(0xFF3B2A04);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isAvailable ? 'Tersedia' : 'Sedang Dipinjam',
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
