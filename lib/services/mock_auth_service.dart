import 'package:despesas_app/common/models/user_model.dart';
import 'package:despesas_app/services/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp({
    String? name, 
    required String email, 
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (password.startsWith('123')){
        throw Exception();
      }
      return UserModel(
        id: email.hashCode,
        name: name,
        email: email,
      );
    } catch (e) {
      if(password.startsWith('123')){
        throw 'Senha Insegura. Digite uma senha forte.';
      }
      throw 'Erro ao criar usuário. Tente novamente.';
    }
  }

}
