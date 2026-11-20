import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../config/api_config.dart';
import 'item.dart';

/// Kegagalan pemanggilan API dengan pesan yang siap ditampilkan.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

/// Filter katalog; nama parameter sama dengan `CatalogFilterForm` di Django.
class ItemFilter {
  const ItemFilter({
    this.query = '',
    this.category = '',
    this.condition = '',
    this.availableOnly = false,
    this.sort = 'newest',
  });

  final String query;
  final String category;
  final String condition;
  final bool availableOnly;
  final String sort;

  Map<String, String> toQuery() => {
        if (query.trim().isNotEmpty) 'q': query.trim(),
        if (category.isNotEmpty) 'category': category,
        if (condition.isNotEmpty) 'condition': condition,
        if (availableOnly) 'available': 'true',
        'sort': sort,
      };
}

/// Lapisan data Modul 2: memanggil endpoint DRF dan mengubah JSON jadi model.
class ItemService {
  ItemService({http.Client? client, String? baseUrl, Duration? timeout})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? ApiConfig.baseUrl,
        _timeout = timeout ?? ApiConfig.timeout;

  final http.Client _client;
  final String _baseUrl;
  final Duration _timeout;

  /// GET /api/v1/items/ (publik, respons berupa array JSON).
  Future<List<Item>> fetchItems([ItemFilter filter = const ItemFilter()]) async {
    final uri = Uri.parse('$_baseUrl${ApiConfig.itemsPath}')
        .replace(queryParameters: filter.toQuery());
    final http.Response response;
    try {
      response = await _client.get(uri, headers: {
        'Accept': 'application/json',
      }).timeout(_timeout);
    } on TimeoutException {
      throw const ApiException('Server terlalu lama merespons. Coba lagi.');
    } on SocketException {
      throw const ApiException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet.',
      );
    }

    if (response.statusCode != 200) {
      throw ApiException(
        _errorMessage(response),
        statusCode: response.statusCode,
      );
    }
    try {
      final data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      return data
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    } on Object {
      throw const ApiException('Respons server tidak dapat dibaca.');
    }
  }

  /// Ambil pesan dari `{"detail": "..."}`; jika tidak ada, pesan umum per status.
  String _errorMessage(http.Response response) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body is Map<String, dynamic> && body['detail'] is String) {
        return body['detail'] as String;
      }
    } on Object {
      // Body bukan JSON (mis. halaman error HTML); pakai pesan umum.
    }
    return switch (response.statusCode) {
      404 => 'Data tidak ditemukan.',
      429 => 'Terlalu banyak permintaan. Coba lagi sebentar lagi.',
      >= 500 => 'Terjadi gangguan pada server. Coba lagi nanti.',
      _ => 'Permintaan gagal (kode ${response.statusCode}).',
    };
  }

  void dispose() => _client.close();
}
