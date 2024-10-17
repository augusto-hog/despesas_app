import 'dart:developer';

import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/constants/routes.dart';
import 'package:despesas_app/common/utils/uppercase_text_formatter.dart';
import 'package:despesas_app/common/widgets/custom_bottom_sheet.dart';
import 'package:despesas_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:despesas_app/common/widgets/custom_text_form_field.dart';
import 'package:despesas_app/common/widgets/multi_text_button.dart';
import 'package:despesas_app/common/widgets/password_form_field.dart';
import 'package:despesas_app/common/widgets/primary_button.dart';
import 'package:despesas_app/common/utils/validator.dart';
import 'package:despesas_app/features/cadastro/sign_up_controller.dart';
import 'package:despesas_app/features/cadastro/sign_up_state.dart';
import 'package:despesas_app/locator.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = locator.get<SignUpController>();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignUpLoadingState) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }

      if (_controller.state is SignUpSuccessState) {
        // Fecha o diálogo de loading, se estiver aberto
        Navigator.pop(context);
        Navigator.popAndPushNamed(
          context,
          NamedRoute.home,
        );
      }
      if (_controller.state is SignUpErrorState) {
        final error = _controller.state as SignUpErrorState;
        customModalBottomSheet(
          context: context,
          content: error.message,
          buttonText: "Tentar novamente", 
        );

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 40),
          Text(
            'Finanças em Ordem',
            textAlign: TextAlign.center,
            style:
                AppTextStyles.mediumText28.copyWith(color: AppColors.greenTwo),
          ),
          Text(
            'Vida mais Leve.',
            textAlign: TextAlign.center,
            style:
                AppTextStyles.mediumText28.copyWith(color: AppColors.greenOne),
          ),
          SizedBox(
            width: 200, // Defina a largura desejada
            height: 200, // Defina a altura desejada
            child: Image.asset(
              'assets/images/form.png',
              fit: BoxFit
                  .contain, // Ajuste a forma como a imagem se adapta ao Container
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: "seu nome",
                    hintText: "Digite seu nome",
                    inputFormatters: [
                      UpperCaseTextInputFormatter(),
                    ],
                    validator: Validator.validateName,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: "seu Email",
                    hintText: "email@email.com",
                    validator: Validator.validateEmail,
                  ),
                  PasswordFormField(
                    controller: _passwordController,
                    labelText: "escolha sua senha",
                    hintText: "********",
                    helperText:
                        "Mínimo de 8 caracteres, 1 letra maiuscula, 1 número e 1 simbolo",
                    validator: Validator.validatePassword,
                  ),
                  PasswordFormField(
                    labelText: "Confirme sua senha",
                    hintText: "********",
                    validator: (value) => Validator.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
                left: 32.0, right: 20.0, top: 16.0, bottom: 4.0),
            child: PrimaryButton(
              text: 'Cadastre-se',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.signUp(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log('Formulário inválido');
                }
              },
            ),
          ),
          MultiTextButton(
            onPressed: () {
              Navigator.popAndPushNamed(
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
        ],
      ),
    );
  }
}
