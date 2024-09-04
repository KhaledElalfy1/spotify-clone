
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier{
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel user){
    state = user;
  }
}