import 'package:despesas_app/common/constants/routes.dart';
import 'package:despesas_app/features/cadastro/sign_up_page.dart';
import 'package:despesas_app/features/home/home_page_view.dart';
import 'package:despesas_app/features/login/login_page.dart';
import 'package:despesas_app/features/onboarding/onboarding_page.dart';
import 'package:despesas_app/features/profile/profile_page.dart';
import 'package:despesas_app/features/splash/splash_page.dart';
import 'package:despesas_app/features/stats/stats_page.dart';
import 'package:despesas_app/features/wallet/wallet_page.dart';
import 'package:flutter/material.dart';
import 'common/models/transaction_model.dart';
import 'common/themes/default_theme.dart';
import 'features/transactions/transaction_page.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme().defaultTheme,
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
