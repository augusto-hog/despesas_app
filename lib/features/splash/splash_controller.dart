import 'package:despesas_app/features/splash/splash_state.dart';
import 'package:despesas_app/services/graphql_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:flutter/foundation.dart';

class SplashController extends ChangeNotifier {
  final SecureStorage secureStorage;
  final GraphQLService graphQLService;

  SplashController({required this.secureStorage, required this.graphQLService});

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  void _changeState(SplashState newstate) {
    _state = newstate;
    notifyListeners();
  }

  Future<void> isUserLogged() async {
    final result = await secureStorage.readOne(key: "CURRENT_USER");
    if (result != null) {
      await graphQLService.init();
      _changeState(SplashStateSuccess());
    } else {
      _changeState(SplashStateError());
    }
  }
}
