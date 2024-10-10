import 'dart:developer';

import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/constants/routes.dart';
import 'package:despesas_app/common/widgets/multi_text_button.dart';
import 'package:despesas_app/common/widgets/primary_button.dart';
import 'package:despesas_app/features/cadastro/sign_up_page.dart';
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
              style: AppTextStyles.mediumText28
                  .copyWith(color: AppColors.greenTwo),
              textAlign: TextAlign.center,
            ),
            Text(
              'Vida mais Leve.',
              style: AppTextStyles.mediumText28
                  .copyWith(color: AppColors.greenOne),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32.0, right: 20.0, top: 16.0, bottom: 4.0),
              child: PrimaryButton(
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
              onPressed: () {
                log('Clicou em "Faça Login"');
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
