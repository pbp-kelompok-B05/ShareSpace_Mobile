import 'package:flutter/material.dart';
import 'package:sharespace_mobile/screens/auth_help_form.dart';
import 'package:sharespace_mobile/screens/auth_profile_form.dart';

/// Halaman Profil & Akun (Modul 1: Autentikasi & Manajemen Akun).
class AuthProfilePage extends StatefulWidget {
  final bool showAppBar;

  const AuthProfilePage({super.key, this.showAppBar = true});

  @override
  State<AuthProfilePage> createState() => _AuthProfilePageState();
}

class _AuthProfilePageState extends State<AuthProfilePage> {
  String _fullName = 'Azka Nur Jauhar';
  final String _username = 'azka.nur';
  final String _email = 'azka.nur@ui.ac.id';
  String _npm = '2506612410';
  final String _authProvider = 'SSO UI';
  final bool _isVerified = true;
  String _phoneNumber = '081234567890';
  String _address = 'Kukusan Teknik, Beji, Depok';
  String _profilePictureUrl = '';

  String _getInitials(String name) {
    final List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return 'SS';
    }
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    return '${parts.first[0]}${parts[1][0]}'.toUpperCase();
  }

  Future<void> _openEditProfileForm() async {
    final Map<String, String>? updatedProfile =
        await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AuthProfileFormPage(
          initialFullName: _fullName,
          initialNpm: _npm,
          initialPhoneNumber: _phoneNumber,
          initialAddress: _address,
          initialProfilePictureUrl: _profilePictureUrl,
        ),
      ),
    );

    if (updatedProfile != null && mounted) {
      setState(() {
        _fullName = updatedProfile['full_name'] ?? _fullName;
        _npm = updatedProfile['npm'] ?? _npm;
        _phoneNumber = updatedProfile['phone_number'] ?? _phoneNumber;
        _address = updatedProfile['address'] ?? _address;
        _profilePictureUrl =
            updatedProfile['profile_picture_url'] ?? _profilePictureUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === Kartu Identitas Profil Pengguna ===
          Card(
            elevation: 2.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
              side: const BorderSide(color: Color(0xFFD9EEA9)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: const Color(0xFF216C4C),
                        child: Text(
                          _getInitials(_fullName),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _fullName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C3029),
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              '@$_username • $_email',
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Color(0xFF184C38),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 6.0,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD9EEA9),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        _isVerified
                                            ? Icons.verified
                                            : Icons.hourglass_empty,
                                        size: 15.0,
                                        color: const Color(0xFF184C38),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        _isVerified
                                            ? 'Civitas UI Terverifikasi'
                                            : 'Belum Terverifikasi',
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1C3029),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6F7F1),
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: const Color(0xFF216C4C),
                                    ),
                                  ),
                                  child: Text(
                                    'Autentikasi: $_authProvider',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF184C38),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24.0),
                  _ProfileDetailRow(
                    icon: Icons.badge_outlined,
                    label: 'NPM',
                    value: _npm.isEmpty ? '-' : _npm,
                  ),
                  const SizedBox(height: 10.0),
                  _ProfileDetailRow(
                    icon: Icons.phone_outlined,
                    label: 'Nomor Kontak',
                    value: _phoneNumber.isEmpty ? '-' : _phoneNumber,
                  ),
                  const SizedBox(height: 10.0),
                  _ProfileDetailRow(
                    icon: Icons.home_outlined,
                    label: 'Domisili / Kost',
                    value: _address.isEmpty ? '-' : _address,
                  ),
                  if (_profilePictureUrl.isNotEmpty) ...[
                    const SizedBox(height: 10.0),
                    _ProfileDetailRow(
                      icon: Icons.link_outlined,
                      label: 'URL Foto Profil',
                      value: _profilePictureUrl,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // === Kartu Ringkasan Trust Score & Reputasi Komunitas ===
          Card(
            elevation: 2.0,
            color: const Color(0xFF184C38),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trust Score & Reputasi',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Chip(
                        label: Text(
                          'Sangat terpercaya',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C3029),
                            fontSize: 12.0,
                          ),
                        ),
                        backgroundColor: Color(0xFFD9EEA9),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '92 / 100',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD9EEA9),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Pengguna memiliki reputasi luar biasa dan rekam jejak yang sangat terpercaya di komunitas ShareSpace.',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          const Row(
            children: [
              Expanded(
                child: _ReputationStatCard(
                  title: 'Rata-rata Rating',
                  content: '4,9 / 5,0',
                  icon: Icons.star_outline,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: _ReputationStatCard(
                  title: 'Total Ulasan',
                  content: '12 Ulasan',
                  icon: Icons.forum_outlined,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: _ReputationStatCard(
                  title: 'Pinjaman Selesai',
                  content: '18 Transaksi',
                  icon: Icons.check_circle_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // === Tombol Navigasi ke Form Edit Profil & Bantuan Login ===
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF216C4C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: _openEditProfileForm,
            icon: const Icon(Icons.edit_outlined),
            label: const Text(
              'Edit Profil Pengguna',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10.0),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF184C38),
              side: const BorderSide(color: Color(0xFF216C4C), width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthHelpFormPage(),
                ),
              );
            },
            icon: const Icon(Icons.help_outline),
            label: const Text(
              'Bantuan Login & Kendala Akun',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (!widget.showAppBar) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil & Akun',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF216C4C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF6F7F1),
      body: content,
    );
  }
}

class _ReputationStatCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _ReputationStatCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Color(0xFFD9EEA9)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        child: Column(
          children: [
            Icon(icon, size: 20.0, color: const Color(0xFF216C4C)),
            const SizedBox(height: 6.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF184C38),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C3029),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.0, color: const Color(0xFF216C4C)),
        const SizedBox(width: 10.0),
        SizedBox(
          width: 120.0,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF184C38),
              fontSize: 13.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1C3029),
              fontSize: 13.0,
            ),
          ),
        ),
      ],
    );
  }
}
