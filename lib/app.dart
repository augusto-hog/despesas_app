import 'package:flutter/material.dart';
import 'features/home/home.dart';
import 'features/onboarding/onboarding.dart';
import 'features/profile/profile.dart';
import 'features/login/login.dart';
import 'features/cadastro/sign_up.dart';
import 'features/splash/splash.dart';
import 'features/stats/stats.dart';
import 'features/transactions/transactions.dart';
import 'features/wallet/wallet.dart';
import 'common/constants/constants.dart';
import 'common/models/models.dart';
import 'common/themes/default_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'common/models/transaction_model.dart';
import 'features/transactions/transaction_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despesas App',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme().defaultTheme,
      locale: const Locale('pt', 'BR'), // Define o idioma padrão
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial: (context) => const OnboardingPage(),
        NamedRoute.splash: (context) => const SplashPage(),
        NamedRoute.cadastro: (context) => const SignUpPage(),
        NamedRoute.login: (context) => const LoginPage(),
        NamedRoute.home: (context) => const HomePageView(),
        NamedRoute.stats: (context) => const StatsPage(),
        NamedRoute.wallet: (context) => const WalletPage(),
        NamedRoute.profile: (context) => const ProfilePage(),
        NamedRoute.transaction: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return TransactionPage(
            transaction: args != null ? args as TransactionModel : null,
          );
        },
      },
    );
  }
}
