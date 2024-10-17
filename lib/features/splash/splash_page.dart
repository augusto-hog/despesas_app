

import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/constants/routes.dart';
import 'package:despesas_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:despesas_app/features/splash/splash_controller.dart';
import 'package:despesas_app/features/splash/splash_state.dart';
import 'package:despesas_app/locator.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashController = locator.get<SplashController>();
  @override
  void initState() {
    super.initState();
    _splashController.isUserLogged();
    _splashController.addListener(() {
      if (_splashController.state is SplashStateSuccess) {
        Navigator.pushReplacementNamed(context, NamedRoute.home);
      } else if (_splashController.state is SplashStateError) {
        Navigator.pushReplacementNamed(context, NamedRoute.initial);
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.greenOne,
              AppColors.greenTwo,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PoupeUp',
              style: AppTextStyles.bigText.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 20), // Adiciona um espaço vertical de 20 pixels
            const CustomCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
