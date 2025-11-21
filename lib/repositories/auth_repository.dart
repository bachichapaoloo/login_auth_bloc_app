import 'package:hive/hive.dart';
import 'package:login_auth_bloc_app/core/hive_constants.dart';

class AuthRepository {
  Box get _authBox => Hive.box(kAuthBox);

  Future<void> login({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (username.isEmpty || password.isEmpty) {
      throw Exception('Username and password cannot be empty.');
    }

    await _authBox.put(kUserKey, username);
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _authBox.delete(kUserKey);
  }

  String? getCurrentUser() {
    return _authBox.get(kUserKey);
  }
}
