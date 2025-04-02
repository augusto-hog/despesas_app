
import '../../common/constants/constants.dart';
import '../../common/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 48.0,
            ),
            Expanded(
              child: Image.asset('assets/images/man.png'),
            ),
            Text(
              'Finanças em Ordem',
              style: AppTextStyles.mediumText36.copyWith(color: AppColors.greenTwo),
              textAlign: TextAlign.center,
            ),
            Text(
              'Vida mais Leve.',
              style: AppTextStyles.mediumText36.copyWith(color: AppColors.greenOne),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 20.0, top: 16.0, bottom: 4.0),
              child: PrimaryButton(
                key: Keys.onboardingGetStartedButton,
                text: 'Começar',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    NamedRoute.cadastro,
                  );
                },
              ),
            ),
            MultiTextButton(
              key: Keys.onboardingAlreadyHaveAccountButton,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NamedRoute.login,
                );
              },
              children: [
                Text(
                  'Já tem uma conta? ',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  'Faça Login',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.greenTwo,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
