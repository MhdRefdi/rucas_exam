import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/user_provider.dart';
import 'package:rucas_exam_project/screens/setting_screen.dart';
import 'package:rucas_exam_project/widgets/profil/profile_item.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  // Show options for changing or deleting the profile picture
  void _showPhotoOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Opsi Foto Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Ubah Foto Profil'),
                onTap: () {
                  Navigator.pop(context);
                  // _pickImage(); // Uncomment to enable picking image from gallery
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Hapus Foto Profil'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _imageFile = null; // Clear the image from state
                  });
                  context.read<UserProvider>().updateUserPartial(
                    imageUrl: 'assets/images/profil.jpg', // Reset to default image
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Handle menu item selection
  void _handleMenuSelection(String value) {
    if (value == 'edit') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EditProfileScreen()),
      );
    } else if (value == 'activity' || value == 'settings' || value == 'help') {
      if (value == 'settings') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SettingsScreen(),
          ), // Navigate to settings
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuSelection,
            itemBuilder:
                (context) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit Profil')),
                  PopupMenuItem(value: 'settings', child: Text('Pengaturan')),
                ],
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue,
              padding: const EdgeInsets.only(top: 24, bottom: 32),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showPhotoOptions,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              _imageFile != null
                                  ? FileImage(_imageFile!) as ImageProvider
                                  : (user.imageUrl != null &&
                                          user.imageUrl!.isNotEmpty
                                      ? (user.imageUrl!.startsWith('assets/')
                                          ? AssetImage(user.imageUrl!)
                                          : FileImage(File(user.imageUrl!)))
                                      : const AssetImage('assets/images/profil.jpg')),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.edit, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ProfileItem(
              icon: Icons.phone,
              title: 'Nomor Telepon',
              value: user.phone,
              showDivider: false,
            ),
            ProfileItem(
              icon: Icons.location_on,
              title: 'Alamat',
              value: user.location ?? 'Belum ditambahkan',
              showDivider: false,
            ),
            ProfileItem(
              icon: Icons.cake,
              title: 'Tanggal Lahir',
              value: user.bio ?? 'Belum ditambahkan',
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
