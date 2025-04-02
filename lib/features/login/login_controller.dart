import 'login_state.dart';
import '../../services/services.dart';
import 'package:flutter/foundation.dart';

class LoginController extends ChangeNotifier {
  LoginState _state = LoginStateInitial();

  LoginController({
    required this.authService,
    required this.secureStorageService,
    required this.syncService,
  });

  final AuthService authService;
  final SecureStorageService secureStorageService;
  final SyncService syncService;

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

    final result = await authService.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (error) => _changeState(LoginStateError(error.message)),
      (data) async {
        await secureStorageService.write(
          key: "CURRENT_USER",
          value: data.toJson(),
        );

        await syncService.syncFromServer();

        _changeState(LoginStateSuccess());
      },
    );
  }
}
