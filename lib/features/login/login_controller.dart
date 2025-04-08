import 'login_state.dart';
import '../../services/services.dart';
import 'package:flutter/foundation.dart';

class LoginController extends ChangeNotifier {
  LoginState _state = LoginStateInitial();

  LoginController({
    required AuthService authService,
    required SecureStorageService secureStorageService,
  })  : _secureStorageService = secureStorageService,
        _authService = authService;

  final AuthService _authService;
  final SecureStorageService _secureStorageService;

  LoginState get state => _state;

  void _changeState(LoginState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> login({required email, required password}) async {
    _changeState(LoginStateLoading());

    try {
      final result = await _authService.signIn(email: email, password: password);
      result.fold(
        (error) {
          _changeState(LoginStateError(error.message));
        },
        (data) async {
          await _secureStorageService.write(
            key: "CURRENT_USER",
            value: data.toJson(),
          );

          _changeState(LoginStateSuccess());
        },
      );
    } catch (e) {
      _changeState(LoginStateError('Erro inesperado durante o login.'));
    }
  }
}
