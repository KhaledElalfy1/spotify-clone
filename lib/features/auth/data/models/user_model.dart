
import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String id;

  UserModel({
    required this.username,
    required this.email,
    required this.id,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? id,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(username: $username, email: $email, id: $id)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username && other.email == email && other.id == id;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ id.hashCode;
}
