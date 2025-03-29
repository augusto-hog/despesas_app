import 'package:despesas_app/features/login/login_state.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:flutter/foundation.dart';

class LoginController extends ChangeNotifier {
  LoginState _state = LoginStateInitial();

  LoginController({required this.authService, required this.secureStorageService});

  final AuthService authService;
  final SecureStorageService secureStorageService;

  LoginState get state => _state;

  void _changeState(LoginState newstate) {
    _state = newstate;
    notifyListeners();
  }

  Future<void> login({
    required email,
    required password,
  }) async {
    _changeState(LoginStateLoading());

    try {
      final user = await authService.login(
        email: email,
        password: password,
      );

      if (user.id != null) {
        await secureStorageService.write(key: "CURRENT_USER", value: user.toJson());

        _changeState(LoginStateSuccess());
      } else {
        throw Exception();
      }

      _changeState(LoginStateSuccess());
    } catch (e) {
      _changeState(LoginStateError(e.toString()));
    }
  }
}
