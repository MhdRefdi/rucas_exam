import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/user_provider.dart';
import '../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String phone;
  late String location;
  late String bio;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().user;
    name = user.name;
    email = user.email;
    phone = user.phone;
    location = user.location ?? '';
    bio = user.bio ?? '';
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => AlertDialog(
              content: Row(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text('Menyimpan...'),
                ],
              ),
            ),
      );

      await Future.delayed(const Duration(seconds: 2));

      context.read<UserProvider>().updateUser(
        UserModel(
          name: name,
          email: email,
          phone: phone,
          location: location,
          bio: bio,
          imageUrl: context.read<UserProvider>().user.imageUrl,
        ),
      );

      Navigator.pop(context); // Tutup dialog loading

      setState(() {
        _isLoading = false;
      });

      // ✅ Tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil diubah'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context); // Kembali ke layar sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                onSaved: (val) => name = val!,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Nama tidak boleh kosong'
                            : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  suffixIcon: Icon(Icons.lock, color: Colors.grey),
                ),
                enabled: false,
                onSaved: (val) => email = val!,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Email tidak boleh kosong'
                            : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  suffixIcon: Icon(Icons.lock, color: Colors.grey),
                ),
                enabled: false,
                onSaved: (val) => phone = val!,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Nomor HP tidak boleh kosong'
                            : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: location,
                decoration: const InputDecoration(labelText: 'Alamat'),
                onSaved: (val) => location = val!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: bio,
                decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                onSaved: (val) => bio = val!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
