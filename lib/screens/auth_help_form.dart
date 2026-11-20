import 'package:flutter/material.dart';

/// Halaman formulir permohonan bantuan login / kendala akun (Modul 1).
class AuthHelpFormPage extends StatefulWidget {
  const AuthHelpFormPage({super.key});

  @override
  State<AuthHelpFormPage> createState() => _AuthHelpFormPageState();
}

class _AuthHelpFormPageState extends State<AuthHelpFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _emailOrUsername = '';
  String _contactEmail = '';
  String _issueType = 'forgot_password';
  String _message = '';

  final Map<String, String> _issueTypes = const {
    'forgot_password': 'Lupa Password Akun Lokal',
    'account_locked': 'Akun Terkunci / Dinonaktifkan',
    'other': 'Kendala Login Lainnya',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan Login & Kendala Akun'),
        backgroundColor: const Color(0xFF216C4C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF6F7F1),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === Username atau Email Akun ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Contoh: azka.nur atau azka.nur@ui.ac.id',
                    labelText: 'Username atau Email Akun',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _emailOrUsername = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username atau email akun tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Email Kontak Aktif ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'nama@email.com',
                    labelText: 'Email Kontak Aktif',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _contactEmail = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    final String trimmed = value?.trim() ?? '';
                    if (trimmed.isEmpty) {
                      return 'Email kontak aktif tidak boleh kosong!';
                    }
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(trimmed)) {
                      return 'Masukkan format email kontak yang valid!';
                    }
                    return null;
                  },
                ),
              ),

              // === Jenis Kendala ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Jenis Kendala',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  initialValue: _issueType,
                  items: _issueTypes.entries
                      .map(
                        (entry) => DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _issueType = newValue;
                      });
                    }
                  },
                ),
              ),

              // === Detail Kendala ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        'Ceritakan kendala yang Anda alami saat mencoba masuk...',
                    labelText: 'Detail Kendala',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _message = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Detail kendala tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Kirim Permohonan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xFF216C4C),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String savedAccount = _emailOrUsername.trim();
                          final String savedContact = _contactEmail.trim();
                          final String savedIssueLabel =
                              _issueTypes[_issueType] ?? _issueType;
                          final String savedMessage = _message.trim();

                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text(
                                  'Permohonan Bantuan Diterima',
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Permohonan bantuan Anda telah diterima. Jika akun terdaftar, admin akan menghubungi email kontakmu.',
                                      ),
                                      const SizedBox(height: 12.0),
                                      Text('Akun: $savedAccount'),
                                      Text('Email Kontak: $savedContact'),
                                      Text('Jenis Kendala: $savedIssueLabel'),
                                      Text('Detail: $savedMessage'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                      _formKey.currentState!.reset();
                                      setState(() {
                                        _emailOrUsername = '';
                                        _contactEmail = '';
                                        _issueType = 'forgot_password';
                                        _message = '';
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Kirim Permohonan',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
