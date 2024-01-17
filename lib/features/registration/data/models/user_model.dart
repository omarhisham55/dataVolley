import 'package:data_volley_match/features/registration/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
      );

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email};
  }
}
