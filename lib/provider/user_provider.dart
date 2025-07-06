import 'package:flutter/material.dart';
import '../data/data_user.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = defaultUser;

  UserModel get user => _user;

  void updateUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }

  void updateUserPartial({
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
    String? bio,
    String? location,
  }) {
    _user = _user.copyWith(
      name: name,
      email: email,
      phone: phone,
      imageUrl: imageUrl ?? 'assets/profil.jpg', // Gambar default
      bio: bio,
      location: location,
    );
    notifyListeners();
  }
}
