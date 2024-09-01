import 'dart:developer';

import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/data/models/user_sign_up_input_model.dart';
import 'package:client/features/auth/data/repo/auth_remote_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRemoteRepo _authRemoteRepo = AuthRemoteRepo();

  @override
  AsyncValue<UserModel>? build() {
    // as it required user be signed in or up
    return null;
  }

  Future<void> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    // the logic for signing up user from repository
    state = const AsyncLoading();
    final res = await _authRemoteRepo.signup(
      userSignUpInputModel: UserSignUpInputModel(
        name: username,
        email: email,
        password: password,
      ),
    );
    res.fold((l) {
      state = AsyncError(l.message, StackTrace.current);
    }, (r) {
      state = AsyncData(r);
    });
    log("the State from AuthViewModel: $state");
  }
}
