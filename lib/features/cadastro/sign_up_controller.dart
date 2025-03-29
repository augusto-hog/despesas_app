import 'package:despesas_app/features/cadastro/sign_up_state.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:despesas_app/services/graphql_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:flutter/foundation.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required this.authService,
    required this.secureStorageService,
  });

  final AuthService authService;
  final SecureStorageService secureStorageService;

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
      final user = await authService.signUp(
        name: name,
        email: email,
        password: password,
      );
      if (user.id != null) {
        await secureStorageService.write(
          key: "CURRENT_USER",
          value: user.toJson(),
        );

        _changeState(SignUpSuccessState());
      } else {
        throw Exception();
      }
    } catch (e) {
      _changeState(SignUpErrorState(e.toString()));
    }
  }
}
