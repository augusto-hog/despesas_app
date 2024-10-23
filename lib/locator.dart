import 'package:despesas_app/features/cadastro/sign_up_controller.dart';
import 'package:despesas_app/features/login/login_controller.dart';
import 'package:despesas_app/features/splash/splash_controller.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:despesas_app/services/firebase_auth_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  locator.registerFactory<SplashController>(
      () => SplashController(const SecureStorageService()));

  locator.registerFactory<LoginController>(
      () => LoginController(locator.get<AuthService>()));

  locator.registerFactory<SignUpController>(() => SignUpController(
        locator.get<AuthService>(),
        const SecureStorageService(),
      ));
}
