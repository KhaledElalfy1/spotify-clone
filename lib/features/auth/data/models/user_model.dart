

import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String id;
  final String token;

  
  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.token,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? id,
    String? token,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'id': id,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ??'',
      email: map['email'] ??'',
      id: map['id'] ??'',
      token: map['token'] ??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, id: $id, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.email == email &&
      other.id == id &&
      other.token == token;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      email.hashCode ^
      id.hashCode ^
      token.hashCode;
  }
}
