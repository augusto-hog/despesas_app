import 'package:despesas_app/common/constants/routes.dart';
import 'package:despesas_app/features/cadastro/sign_up_page.dart';
import 'package:despesas_app/features/home/home_page.dart';
import 'package:despesas_app/features/login/login_page.dart';
import 'package:despesas_app/features/onboarding/onboarding_page.dart';
import 'package:despesas_app/features/splash/splash_page.dart';
//import 'package:despesas_app/features/onboarding/onboarding_page.dart';
//import 'package:despesas_app/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: defaultTheme,
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial: (context) => const OnboardingPage(),
        NamedRoute.splash: (context) => const SplashPage(),
        NamedRoute.cadastro: (context) => const SignUpPage(),
        NamedRoute.login: (context) => const LoginPage(),
        NamedRoute.home: (context) => const HomePage(),
      },
    );
  }
}
