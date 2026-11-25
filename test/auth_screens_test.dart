import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespace_mobile/screens/auth_profile_page.dart';

void main() {
  testWidgets('AuthProfilePage renders profile, edit form validation, and help form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthProfilePage(),
      ),
    );

    expect(find.text('Profil & Akun'), findsOneWidget);
    expect(find.text('Azka Nur Jauhar'), findsOneWidget);
    expect(find.text('Trust Score & Reputasi'), findsOneWidget);
    expect(find.text('Civitas UI Terverifikasi'), findsOneWidget);

    // Uji navigasi ke form Edit Profil dan validasinya.
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit Profil Pengguna'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nomor Pokok Mahasiswa (NPM)'),
      'abc123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'URL Foto Profil (Opsional)'),
      'ftp://invalid-url',
    );
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('NPM hanya boleh memuat angka.'), findsOneWidget);
    expect(
      find.text('URL foto profil harus diawali dengan http:// atau https://.'),
      findsOneWidget,
    );

    // Perbaiki input agar valid lalu pastikan AlertDialog ringkasan muncul.
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, 350));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nomor Pokok Mahasiswa (NPM)'),
      '2506612410',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'URL Foto Profil (Opsional)'),
      'https://example.com/azka.png',
    );
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Profil berhasil disimpan!'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Uji navigasi ke form Bantuan Login & Kendala Akun.
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bantuan Login & Kendala Akun'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username atau Email Akun'),
      'azka.nur',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email Kontak Aktif'),
      'azka@ui.ac.id',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Detail Kendala'),
      'Lupa kata sandi akun lokal saat ingin masuk.',
    );

    await tester.ensureVisible(find.text('Kirim Permohonan'));
    await tester.tap(find.text('Kirim Permohonan'));
    await tester.pumpAndSettle();

    expect(find.text('Permohonan Bantuan Diterima'), findsOneWidget);
  });
}
