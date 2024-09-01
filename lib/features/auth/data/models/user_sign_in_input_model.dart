class UserSignInInputModel {
  final String email;
  final String password;

  UserSignInInputModel({required this.email, required this.password});

  toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

}