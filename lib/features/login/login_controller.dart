import 'package:despesas_app/features/login/login_state.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:flutter/foundation.dart';


class LoginController extends ChangeNotifier {

final AuthService _service;

  LoginState _state = LoginStateInitial();

  LoginController(this._service);

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
      await _service.login(
        email: email,
        password: password,
      );

      _changeState(LoginStateSuccess());
    } catch (e) {
      _changeState(LoginStateError(e.toString()));
    }
  }

}