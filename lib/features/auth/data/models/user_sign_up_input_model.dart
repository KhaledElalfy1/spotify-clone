class UserSignUpInputModel {
  final String name;
  final String email;
  final String password;

  UserSignUpInputModel({required this.name, required this.email, required this.password});

  toJson() {
    return {
      'username': name,
      'email': email,
      'password': password,
    };
  }

}
