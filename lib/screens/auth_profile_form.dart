import 'package:flutter/material.dart';

/// Halaman formulir untuk mengubah data profil pengguna ShareSpace (Modul 1).
class AuthProfileFormPage extends StatefulWidget {
  final String initialFullName;
  final String initialNpm;
  final String initialPhoneNumber;
  final String initialAddress;
  final String initialProfilePictureUrl;

  const AuthProfileFormPage({
    super.key,
    this.initialFullName = '',
    this.initialNpm = '',
    this.initialPhoneNumber = '',
    this.initialAddress = '',
    this.initialProfilePictureUrl = '',
  });

  @override
  State<AuthProfileFormPage> createState() => _AuthProfileFormPageState();
}

class _AuthProfileFormPageState extends State<AuthProfileFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _fullName;
  late String _npm;
  late String _phoneNumber;
  late String _address;
  late String _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _fullName = widget.initialFullName;
    _npm = widget.initialNpm;
    _phoneNumber = widget.initialPhoneNumber;
    _address = widget.initialAddress;
    _profilePictureUrl = widget.initialProfilePictureUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil Pengguna'),
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
              // === Penanda Simulasi Lokal Checkpoint 1 ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9EEA9),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFF216C4C)),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18.0,
                        color: Color(0xFF184C38),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'Simulasi lokal (Checkpoint 1): penyimpanan profil belum tersambung ke backend DRF.',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1C3029),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // === Nama Lengkap ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _fullName,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama lengkap Anda',
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _fullName = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama lengkap tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === NPM ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _npm,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 2506612410',
                    labelText: 'Nomor Pokok Mahasiswa (NPM)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _npm = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    final String trimmed = value?.trim() ?? '';
                    if (trimmed.isEmpty) {
                      return 'NPM tidak boleh kosong!';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(trimmed)) {
                      return 'NPM hanya boleh memuat angka.';
                    }
                    return null;
                  },
                ),
              ),

              // === Nomor Telepon ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _phoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 081234567890',
                    labelText: 'Nomor Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _phoneNumber = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    final String trimmed = value?.trim() ?? '';
                    if (trimmed.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong!';
                    }
                    if (!RegExp(r'^[0-9+\-\s()]+$').hasMatch(trimmed)) {
                      return 'Nomor telepon hanya boleh memuat angka dan karakter pemisah (+, -, spasi, tanda kurung).';
                    }
                    return null;
                  },
                ),
              ),

              // === Domisili / Alamat Kost ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _address,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Kukusan Teknik, Beji, Depok',
                    labelText: 'Domisili / Alamat Kost',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _address = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Domisili atau alamat kost tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === URL Foto Profil ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _profilePictureUrl,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: 'https://example.com/foto-profil.jpg',
                    labelText: 'URL Foto Profil (Opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _profilePictureUrl = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    final String trimmed = value?.trim() ?? '';
                    if (trimmed.isNotEmpty &&
                        !(trimmed.startsWith('http://') ||
                            trimmed.startsWith('https://'))) {
                      return 'URL foto profil harus diawali dengan http:// atau https://.';
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
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
                          final String savedName = _fullName.trim();
                          final String savedNpm = _npm.trim();
                          final String savedPhone = _phoneNumber.trim();
                          final String savedAddress = _address.trim();
                          final String savedPhotoUrl = _profilePictureUrl.trim();

                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Profil berhasil disimpan!'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Catatan: penyimpanan ini masih berupa simulasi lokal sampai tersambung ke backend.',
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text('Nama Lengkap: $savedName'),
                                      Text('NPM: $savedNpm'),
                                      Text('Nomor Telepon: $savedPhone'),
                                      Text('Domisili / Kost: $savedAddress'),
                                      Text(
                                        'URL Foto Profil: ${savedPhotoUrl.isEmpty ? '-' : savedPhotoUrl}',
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                      if (Navigator.canPop(context)) {
                                        Navigator.pop(context, <String, String>{
                                          'full_name': savedName,
                                          'npm': savedNpm,
                                          'phone_number': savedPhone,
                                          'address': savedAddress,
                                          'profile_picture_url': savedPhotoUrl,
                                        });
                                      } else {
                                        _formKey.currentState!.reset();
                                        setState(() {
                                          _fullName = widget.initialFullName;
                                          _npm = widget.initialNpm;
                                          _phoneNumber =
                                              widget.initialPhoneNumber;
                                          _address = widget.initialAddress;
                                          _profilePictureUrl =
                                              widget.initialProfilePictureUrl;
                                        });
                                      }
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
                          'Simpan',
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
