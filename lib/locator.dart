import 'package:despesas_app/features/cadastro/sign_up_controller.dart';
import 'package:despesas_app/features/home/home_controller.dart';
import 'package:despesas_app/features/home/widgets/balance_card/balance_card_widget_controller.dart';
import 'package:despesas_app/features/login/login_controller.dart';
import 'package:despesas_app/features/splash/splash_controller.dart';
import 'package:despesas_app/repositories/transaction_repository.dart';
import 'features/transactions/transaction_controller.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:despesas_app/services/firebase_auth_service.dart';
import 'package:despesas_app/services/graphql_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  locator.registerFactory<AuthService>(() => FirebaseAuthService());

  locator.registerLazySingleton<GraphQLService>(() => GraphQLService(authService: locator.get<AuthService>()));

  locator.registerLazySingleton<SecureStorage>(() => const SecureStorage());

  locator.registerLazySingleton<HomeController>(() => HomeController(locator.get<TransactionRepository>()));

  locator.registerLazySingleton<BalanceCardWidgetController>(() => BalanceCardWidgetController(transactionRepository: locator.get<TransactionRepository>()));

  locator.registerFactory<SplashController>(() => SplashController(secureStorage: locator.get<SecureStorage>(), graphQLService: locator.get<GraphQLService>()));

  locator.registerFactory<LoginController>(
      () => LoginController(authService: locator.get<AuthService>(), secureStorage: locator.get<SecureStorage>(), graphQLService: locator.get<GraphQLService>()));

  locator.registerFactory<SignUpController>(
      () => SignUpController(authService: locator.get<AuthService>(), secureStorage: locator.get<SecureStorage>(), graphQLService: locator.get<GraphQLService>()));

  locator.registerFactory<TransactionRepository>(() => TransactionRepositoryImpl(locator.get<GraphQLService>()));

  locator.registerFactory<TransactionController>(
    () => TransactionController(
      repository: locator.get<TransactionRepository>(),
      storage: const SecureStorage(),
    ),
  );
}
