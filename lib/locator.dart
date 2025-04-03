import 'package:despesas_app/common/features/balance/balance.dart';
import 'package:despesas_app/services/sync_service/sync_controller.dart';
import 'package:get_it/get_it.dart';

import 'common/features/transaction/transaction.dart';
import 'features/home/home_controller.dart';
import 'features/login/login_controller.dart';
import 'features/cadastro/sign_up_controller.dart';
import 'features/splash/splash_controller.dart';
import 'features/wallet/wallet_controller.dart';
import 'repositories/repositories.dart';
import 'services/services.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerFactory<AuthService>(() => FirebaseAuthService());

  locator.registerSingletonAsync<GraphQLService>(
    () async => GraphQLService(
      authService: locator.get<AuthService>(),
    ).init(),
  );

  locator.registerSingletonAsync<DatabaseService>(
    () async => DatabaseService().init(),
  );

  locator.registerFactory<SyncService>(
    () => SyncService(
      connectionService: const ConnectionService(),
      databaseService: locator.get<DatabaseService>(),
      graphQLService: locator.get<GraphQLService>(),
      secureStorageService: const SecureStorageService(),
    ),
  );

  locator.registerFactory<TransactionRepository>(
    () => TransactionRepositoryImpl(
      databaseService: locator.get<DatabaseService>(),
      syncService: locator.get<SyncService>(),
    ),
  );

  locator.registerFactory<SplashController>(
    () => SplashController(
      secureStorageService: const SecureStorageService(),
    ),
  );

  locator.registerFactory<LoginController>(
    () => LoginController(
      authService: locator.get<AuthService>(),
      secureStorageService: const SecureStorageService(),
    ),
  );

  locator.registerFactory<SignUpController>(() =>
      SignUpController(authService: locator.get<AuthService>(), secureStorageService: const SecureStorageService()));

  locator.registerLazySingleton<HomeController>(
    () => HomeController(
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );

  locator.registerLazySingleton<WalletController>(
    () => WalletController(
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );

  locator.registerLazySingleton<BalanceController>(
    () => BalanceController(
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );

  locator.registerLazySingleton<TransactionController>(
    () => TransactionController(
      transactionRepository: locator.get<TransactionRepository>(),
      secureStorageService: const SecureStorageService(),
    ),
  );

  locator.registerFactory<SyncController>(
    () => SyncController(
      syncService: locator.get<SyncService>(),
    ),
  );
}
