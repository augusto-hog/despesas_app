import 'package:despesas_app/features/cadastro/sign_up_state.dart';
import '../../services/services.dart';
import 'package:flutter/foundation.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required this.authService,
    required this.secureStorageService,
  });

  final AuthService authService;
  final SecureStorageService secureStorageService;

  SignUpState _state = SignUpStateInitial();

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
    _changeState(SignUpStateLoading());

    final result = await authService.signUp(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (error) => _changeState(SignUpStateError(error.message)),
      (data) async {
        await secureStorageService.write(
          key: "CURRENT_USER",
          value: data.toJson(),
        );

        _changeState(SignUpStateSuccess());
      },
    );
  }
}
