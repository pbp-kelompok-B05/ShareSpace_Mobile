/// Konfigurasi API terpusat. Jangan menulis base URL di tempat lain.
class ApiConfig {
  const ApiConfig._();

  /// Base URL backend Django. Default: emulator Android -> mesin host.
  /// Ganti saat build, mis. URL PWS:
  /// `flutter run --dart-define=API_BASE_URL=https://<host-pws>/<path>`
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  /// Batas waktu tiap request ke web service.
  static const Duration timeout = Duration(seconds: 15);

  /// Endpoint Modul 2 (app `items` di Django).
  static const String itemsPath = '/api/v1/items/';
}
