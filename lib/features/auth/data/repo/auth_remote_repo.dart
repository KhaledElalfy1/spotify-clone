import 'dart:convert';

import 'package:client/core/failure/failure.dart';
import 'package:client/core/helpers/server_constant.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/data/models/user_sign_in_input_model.dart';
import 'package:client/features/auth/data/models/user_sign_up_input_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_remote_repo.g.dart';

@riverpod
AuthRemoteRepo authRemoteRepo(AuthRemoteRepoRef ref) {
  return AuthRemoteRepo();
}

class AuthRemoteRepo {
  Future<Either<AppFailure, UserModel>> signup(
      {required UserSignUpInputModel userSignUpInputModel}) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.baseUrl}/auth/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userSignUpInputModel.toJson()),
      );
      final responseBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return left(AppFailure(message: responseBodyMap['details']));
      }
      // log("the response is ${response.body} and the status code is ${response.statusCode}");
      return right(UserModel.fromMap(
          responseBodyMap)); // UserModel.fromMap(responseBodyMap)
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> signin(
      {required UserSignInInputModel userSignInInputModel}) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.baseUrl}/auth/signin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userSignInInputModel.toJson()),
      );
      // log("the response is ${response.body} and the status code is ${response.statusCode}");
      final responseBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return left(AppFailure(message: responseBodyMap['details']));
      }
      return right(
        UserModel.fromMap(responseBodyMap['user']).copyWith(
          token: responseBodyMap['token'],
        ),
      );
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData(
      {required String token}) async {
    try {
      final response = await http.get(
          Uri.parse(
            '${ServerConstant.baseUrl}/auth/',
          ),
          headers: {
            'Content-Type': 'application/json',
            'x-auth-token': token,
          });
      final responseBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return left(AppFailure(message: responseBodyMap['details']));
      }
      return right(
        UserModel.fromMap(responseBodyMap).copyWith(
          token: token,
        ),
      );
    } catch (e) {
      return left(
        AppFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
/*

Noor Elalfy
noor@gmail.com
noor1234

*/