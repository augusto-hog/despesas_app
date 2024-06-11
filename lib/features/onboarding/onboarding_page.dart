import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: AppColors.iceWhite,
                child: Image.asset('assets/images/man.png'),
              ),
            ),
            Text(
              'Finanças em Ordem',
              style: AppTextStyles.mediumText26
                  .copyWith(color: AppColors.greenlightTwo),
              textAlign: TextAlign.center,
            ),
            Text(
              'Vida mais Leve.',
              style: AppTextStyles.mediumText26
                  .copyWith(color: AppColors.greenlightOne),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
              child: PrimaryButton(
                text: 'Começar',
                onPressed: () {},
              ),
            ),
            Text(
              'Já tem uma conta? Faça login',
              style: AppTextStyles.smallText.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
    );
  }
}
