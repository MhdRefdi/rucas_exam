import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/text_scale_provider.dart';
import 'login.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  String _selectedLanguage = 'Bahasa Indonesia';

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text("Konfirmasi"),
            content: const Text("Apakah Anda yakin ingin keluar?"),
            actions: [
              TextButton(
                child: const Text("Batal"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Keluar"),
                onPressed: () async {
                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (_) => const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        ),
                  );

                  await Future.delayed(const Duration(seconds: 2));

                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                        settings: const RouteSettings(
                          arguments: 'Telah keluar dari akun',
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    final languages = ['Bahasa Indonesia', 'English', '日本語', 'Español'];

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pilih Bahasa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 16),
                ...languages.map(
                  (lang) => ListTile(
                    title: Text(
                      lang,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing:
                        _selectedLanguage == lang
                            ? const Icon(Icons.check, color: Colors.blue)
                            : null,
                    onTap: () {
                      setState(() => _selectedLanguage = lang);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _showTextSizeSelector(BuildContext context) {
    double tempScale =
        Provider.of<TextScaleProvider>(context, listen: false).scale;

    showDialog(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: const Text(
                    'Ukuran Teks',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'A',
                            style: TextStyle(fontSize: 16 * tempScale),
                          ),
                        ),
                      ),
                      Slider(
                        value: tempScale,
                        min: 0.8,
                        max: 1.5,
                        divisions: 7,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.grey.shade300,
                        label: tempScale.toStringAsFixed(2),
                        onChanged: (value) {
                          setDialogState(() => tempScale = value);
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.blue),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Provider.of<TextScaleProvider>(
                          context,
                          listen: false,
                        ).setScale(tempScale);
                        Navigator.pop(context);
                      },
                      child: const Text('Simpan'),
                    ),
                  ],
                ),
          ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: Theme.of(context).dividerColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textScale = Provider.of<TextScaleProvider>(context).scale;

    return Theme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF2196F3),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Pengaturan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: ListView(
              children: [
                _buildSectionHeader('APLIKASI', context),
                SwitchListTile(
                  secondary: Icon(
                    _darkMode ? Icons.dark_mode : Icons.light_mode,
                    color: _darkMode ? Colors.amber : Colors.amber[700],
                  ),
                  title: const Text('Mode Gelap'),
                  subtitle: Text(_darkMode ? 'Aktif' : 'Tidak aktif'),
                  value: _darkMode,
                  activeColor: Colors.blue,
                  onChanged: (value) => setState(() => _darkMode = value),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Bahasa'),
                  subtitle: Text(_selectedLanguage),
                  onTap: () => _showLanguageSelector(context),
                ),
                ListTile(
                  leading: const Icon(Icons.text_fields),
                  title: const Text('Ukuran Teks'),
                  subtitle: Text('Skala: ${textScale.toStringAsFixed(2)}x'),
                  onTap: () => _showTextSizeSelector(context),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications),
                  title: const Text('Notifikasi'),
                  subtitle: Text(_notifications ? 'Aktif' : 'Tidak aktif'),
                  value: _notifications,
                  activeColor: Colors.blue,
                  onChanged: (value) => setState(() => _notifications = value),
                ),
                _buildDivider(context),
                _buildSectionHeader('LAINNYA', context),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.red),
                  title: const Text(
                    'Keluar',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => _showLogoutConfirmation(context),
                ),
                const SizedBox(height: 32),
                const Center(
                  child: Text(
                    'Versi 1.0.0',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
