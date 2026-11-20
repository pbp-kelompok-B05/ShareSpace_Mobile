import 'package:flutter/material.dart';

import '../data/item.dart';
import '../data/item_service.dart';
import 'item_card.dart';

/// Halaman Katalog (Modul 2): daftar barang dari web service Django.
///
/// StatefulWidget menyimpan `Future` hasil pemanggilan API; `FutureBuilder`
/// membangun ulang tampilan sesuai keadaan Future (loading, error, data).
class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, this.service});

  /// Dapat disuntikkan agar test memakai HTTP client palsu.
  final ItemService? service;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late final ItemService _service = widget.service ?? ItemService();
  late Future<List<Item>> _future = _service.fetchItems();

  @override
  void dispose() {
    // Hanya tutup client yang dibuat sendiri.
    if (widget.service == null) _service.dispose();
    super.dispose();
  }

  void _reload() {
    final next = _service.fetchItems();
    // Block body: callback setState tidak boleh mengembalikan Future.
    setState(() {
      _future = next;
    });
  }

  Future<void> _refresh() async {
    final next = _service.fetchItems();
    setState(() {
      _future = next;
    });
    try {
      await next;
    } on ApiException {
      // Error ditampilkan oleh FutureBuilder.
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          final error = snapshot.error;
          return _MessageView(
            icon: Icons.cloud_off,
            message: error is ApiException
                ? error.message
                : 'Terjadi kesalahan tak terduga.',
            actionLabel: 'Coba lagi',
            onAction: _reload,
          );
        }
        final items = snapshot.data ?? const <Item>[];
        if (items.isEmpty) {
          return _MessageView(
            icon: Icons.inventory_2_outlined,
            message: 'Belum ada barang di katalog.',
            actionLabel: 'Muat ulang',
            onAction: _reload,
          );
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => ItemCard(item: items[i]),
          ),
        );
      },
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.icon,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Scroll agar aman dari overflow di layar pendek atau saat font membesar.
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: scheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}
