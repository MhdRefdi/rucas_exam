class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? imageUrl;
  final String? bio;
  final String? location;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.imageUrl,
    this.bio,
    this.location,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
    String? bio,
    String? location,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
    );
  }
}


// import '../models/user_model.dart';

// final dummyUser = UserModel(
//   name: 'Nurihsan',
//   email: 'nurihsan@mail.com',
//   phone: '+62 812-3456-7890',
//   imageUrl: 'assets/profil.jpg',
//   bio: '23 Agustus 2000',
//   location: 'Medan, Indonesia',
// );