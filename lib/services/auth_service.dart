import 'package:despesas_app/common/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password
  });
  
  Future<UserModel> login({
    required String email,
    required String password
  });

  Future<void> logout();

  Future<String> get userToken;
}
