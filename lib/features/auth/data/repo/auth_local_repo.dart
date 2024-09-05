import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repo.g.dart';
@Riverpod(keepAlive: true)
AuthLocalRepo authLocalRepo(AuthLocalRepoRef ref) {
  return AuthLocalRepo();
}




class AuthLocalRepo {
 late SharedPreferences _sharedPreferences;

 Future<void> init() async {
   _sharedPreferences = await SharedPreferences.getInstance();
 }
  void setToken({required String? token}){
    if(token != null){
      _sharedPreferences.setString('x-auth-token', token);
    }
  }

  String? getToken(){
    return _sharedPreferences.getString('x-auth-token');
  }
}
