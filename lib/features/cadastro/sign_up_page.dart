import 'dart:developer';

import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/widgets/custom_text_form_field.dart';
import 'package:despesas_app/common/widgets/multi_text_button.dart';
import 'package:despesas_app/common/widgets/password_form_field.dart';
import 'package:despesas_app/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(
            'Finanças em Ordem',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText28
                .copyWith(color: AppColors.greenlightTwo),
          ),
          Text(
            'Vida mais Leve.',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText28
                .copyWith(color: AppColors.greenlightOne),
          ),
          SizedBox(
            width: 250, // Defina a largura desejada
            height: 250, // Defina a altura desejada
            child: Image.asset(
              'assets/images/form.png',
              fit: BoxFit
                  .contain, // Ajuste a forma como a imagem se adapta ao Container
            ),
          ),
          const Form(
              child: Column(
            children: [
              CustomTextFormField(
                labelText: "seu nome",
                hintText: "Digite seu nome",
              ),
              CustomTextFormField(
                labelText: "seu Email",
                hintText: "email@email.com",
              ),
              PasswordFormField(
                labelText: "escolha sua senha",
                hintText: "********",
              ),
              PasswordFormField(
                labelText: "Confirme sua senha",
                hintText: "********",
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(
                left: 32.0, right: 20.0, top: 16.0, bottom: 4.0),
            child: PrimaryButton(
              text: 'Cadastre-se',
              onPressed: () {
                log('Clicou em "Cadastre-se"');
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
                  color: AppColors.greenlightTwo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
