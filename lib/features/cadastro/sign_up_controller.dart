import 'package:despesas_app/features/cadastro/sign_up_state.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _service;

  SignUpController(this._service);

  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners(); // Notifica os listeners sobre a mudança de estado
  }

  Future<void> signUp({
    required name,
    required email,
    required password,
  }) async {
    _changeState(SignUpLoadingState());

    try {
      await _service.signUp(
        name: name,
        email: email,
        password: password,
      );

      _changeState(SignUpSuccessState());
    } catch (e) {
      _changeState(SignUpErrorState(e.toString()));
    }
  }
}
