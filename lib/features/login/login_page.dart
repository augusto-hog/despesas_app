import 'dart:developer';

import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/constants/routes.dart';
import 'package:despesas_app/common/widgets/custom_bottom_sheet.dart';
import 'package:despesas_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:despesas_app/common/widgets/custom_text_form_field.dart';
import 'package:despesas_app/common/widgets/multi_text_button.dart';
import 'package:despesas_app/common/widgets/password_form_field.dart';
import 'package:despesas_app/common/widgets/primary_button.dart';
import 'package:despesas_app/common/utils/validator.dart';
import 'package:despesas_app/features/login/login_controller.dart';
import 'package:despesas_app/services/mock_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:despesas_app/features/login/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = LoginController(MockAuthService());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is LoginStateLoading) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }

      if (_controller.state is LoginStateSuccess) {
        // Fecha o diálogo de loading, se estiver aberto
        Navigator.of(context, rootNavigator: true).pop();

        // Navega para a próxima página
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text("Cadastro realizado com sucesso!"),
              ),
            ),
          ),
        );
      }
      if (_controller.state is LoginStateError) {
        final error = _controller.state as LoginStateError;
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
            'Bem vindo de volta!',
            textAlign: TextAlign.center,
            style:
                AppTextStyles.mediumText28.copyWith(color: AppColors.greenTwo),
          ),
          SizedBox(
            width: 200, // Defina a largura desejada
            height: 200, // Defina a altura desejada
            child: Image.asset(
              'assets/images/login.png',
              fit: BoxFit
                  .contain, // Ajuste a forma como a imagem se adapta ao Container
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: "Seu Email",
                    hintText: "email@email.com",
                    validator: Validator.validateEmail,
                  ),
                  PasswordFormField(
                    controller: _passwordController,
                    labelText: "Sua senha",
                    hintText: "********",
                    helperText:
                        "Mínimo de 8 caracteres, 1 letra maiuscula, 1 número e 1 simbolo",
                    validator: Validator.validatePassword,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
                left: 32.0, right: 20.0, top: 16.0, bottom: 4.0),
            child: PrimaryButton(
              text: 'Login',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.login(
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
              Navigator.popAndPushNamed(context, NamedRoute.cadastro);
            },
            children: [
              Text(
                'Não tem conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Cadastre-se',
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
