import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:despesas_app/services/sync_service/sync_controller.dart';

import '../../services/sync_service/sync_service.dart';
import '../../common/constants/constants.dart';
import '../../common/utils/utils.dart';
import '../../common/widgets/widgets.dart';
import '../../locator.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with CustomModalSheetMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInController = locator.get<LoginController>();
  final _syncController = locator.get<SyncController>();

  @override
  void initState() {
    super.initState();
    _signInController.addListener(_handleSignInStateChange);
    _syncController.addListener(_handleSyncStateChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signInController.dispose();
    _syncController.dispose();
    super.dispose();
  }

  void _handleSignInStateChange() {
    switch (_signInController.state.runtimeType) {
      case LoginStateLoading:
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
        break;
      case LoginStateSuccess:
        _syncController.syncFromServer();
        break;
      case LoginStateError:
        Navigator.pop(context);
        showCustomModalBottomSheet(
          context: context,
          content: (_signInController.state as LoginStateError).message,
          buttonText: "Try again",
        );
        break;
    }
  }

  void _handleSyncStateChange() {
    switch (_syncController.state.runtimeType) {
      case DownloadedDataFromServer:
        _syncController.syncToServer();
        break;
      case UploadedDataToServer:
        Navigator.pushReplacementNamed(
          context,
          NamedRoute.home,
        );
        break;
      case SyncStateError:
      case UploadDataToServerError:
      case DownloadDataFromServerError:
        Navigator.pop(context);
        showCustomModalBottomSheet(
          context: context,
          content: (_syncController.state as SyncStateError).message,
          buttonText: "Try again",
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoute.login,
            (route) => false,
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        key: Keys.signInListView,
        children: [
          const SizedBox(height: 40),
          Text(
            'Bem vindo de volta!',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(color: AppColors.greenTwo),
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              'assets/images/login.png',
              fit: BoxFit.contain,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  key: Keys.signInEmailField,
                  controller: _emailController,
                  labelText: "Seu Email",
                  hintText: "email@email.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  key: Keys.signInPasswordField,
                  controller: _passwordController,
                  labelText: "Sua senha",
                  hintText: "********",
                  helperText: "Mínimo de 8 caracteres, 1 letra maiúscula, 1 número e 1 símbolo",
                  validator: Validator.validatePassword,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 20.0, top: 16.0, bottom: 4.0),
            child: PrimaryButton(
              key: Keys.signInButton,
              text: 'Login',
              onPressed: () {
                final valid = _formKey.currentState != null && _formKey.currentState!.validate();
                if (valid) {
                  _signInController.login(
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
