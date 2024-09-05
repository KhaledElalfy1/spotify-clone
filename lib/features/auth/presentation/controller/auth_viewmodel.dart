import 'dart:developer';

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/data/models/user_sign_in_input_model.dart';
import 'package:client/features/auth/data/models/user_sign_up_input_model.dart';
import 'package:client/features/auth/data/repo/auth_local_repo.dart';
import 'package:client/features/auth/data/repo/auth_remote_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepo
      _authRemoteRepo; // not best practice to create instance of repo here

  late AuthLocalRepo _authLocalRepo;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepo = ref.watch(authRemoteRepoProvider);
    _authLocalRepo = ref.watch(authLocalRepoProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    // as it required user be signed in or up
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepo.init();
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
    log("the State of Sign up from AuthViewModel: $state");
  }

  Future<void> signInUser(
      {required String email, required String password}) async {
    // should be called even it's in main due to the race condition of provider
    await initSharedPreferences();

    state = const AsyncLoading();
    final res = await _authRemoteRepo.signin(
      userSignInInputModel:
          UserSignInInputModel(email: email, password: password),
    );
    res.fold((l) {
      state = AsyncError(l.message, StackTrace.current);
    }, (r) {
      state = AsyncData(r);
      _currentUserNotifier.addUser(r);
      _authLocalRepo.setToken(token: r.token);
    });

    log("the State of Sign In from AuthViewModel: $state");
  }

  Future<UserModel?> getUser() async {
    state = const AsyncLoading();
    late final UserModel? user;
    final token = _authLocalRepo.getToken();
    if (token != null) {
      final res = await _authRemoteRepo.getCurrentUserData(token: token);
      res.fold((l) {
        state = AsyncError(l.message, StackTrace.current);
      }, (r) {
        _currentUserNotifier.addUser(r);
        state = AsyncData(r);
        user = r;
      });
      log("the State of Get User from AuthViewModel: $state");

      return user;
    }
    return null;
  }
}
