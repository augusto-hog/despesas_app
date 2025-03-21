import 'package:despesas_app/features/cadastro/sign_up_controller.dart';
import 'package:despesas_app/features/home/home_controller.dart';
import 'package:despesas_app/features/login/login_controller.dart';
import 'package:despesas_app/features/splash/splash_controller.dart';
import 'package:despesas_app/repositories/transaction_repository.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:despesas_app/services/firebase_auth_service.dart';
import 'package:despesas_app/services/graphql_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  // Registra AuthService
  locator.registerFactory<AuthService>(() => FirebaseAuthService());

  // Registra SecureStorage
  locator.registerLazySingleton<SecureStorage>(() => const SecureStorage());

  // Registra GraphQLService e espera a inicialização
  final graphQLService = GraphQLService(authService: locator.get<AuthService>());
  await graphQLService.init();  // Espera a inicialização do GraphQL
  locator.registerLazySingleton<GraphQLService>(() => graphQLService);

  // Registra os controladores, após GraphQLService ser inicializado
  locator.registerLazySingleton<HomeController>(
      () => HomeController(locator.get<TransactionRepository>()));

  locator.registerFactory<SplashController>(
      () => SplashController(locator.get<SecureStorage>()));

  locator.registerFactory<LoginController>(
      () => LoginController(locator.get<AuthService>()));

  locator.registerFactory<SignUpController>(() => SignUpController(
      authService: locator.get<AuthService>(),
      secureStorage: locator.get<SecureStorage>(),
      graphQLService: locator.get<GraphQLService>()));

  // Registra TransactionRepository
  locator.registerFactory<TransactionRepository>(
      () => TransactionRepositoryImpl(locator.get<GraphQLService>()));
}
