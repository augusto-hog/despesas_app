import 'dart:developer';

import '../../common/constants/constants.dart';
import '../../common/utils/utils.dart';
import '../../common/widgets/widgets.dart';
import '../../locator.dart';
import '../../services/services.dart';
import 'sign_up_controller.dart';
import 'sign_up_state.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with CustomModalSheetMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signUpController = locator.get<SignUpController>();
  final _syncController = locator.get<SyncController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _signUpController.dispose();
    _syncController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signUpController.addListener(_handleSignUpstateChange);
    _syncController.addListener(_handleSyncStateChange);
  }

  void _handleSignUpstateChange() {
    final state = _signUpController.state;
    switch (state.runtimeType) {
      case SignUpStateLoading _:
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
        break;
      case SignUpStateSuccess _:
        _syncController.syncFromServer();
        break;
      case SignUpStateError:
        Navigator.pop(context);
        showCustomModalBottomSheet(
          context: context,
          content: (state as SignUpStateError).message,
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
        Navigator.pushNamedAndRemoveUntil(
          context,
          NamedRoute.home,
          (route) => false,
        );
        break;
      case SyncStateError:
      case UploadDataToServerError:
      case DownloadDataFromServerError:
        Navigator.pop(context);
        showCustomModalBottomSheet(
          context: context,
          content: (_syncController.state as SyncStateError).message,
          buttonText: "Tentar novamente",
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoute.cadastro,
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
        key: Keys.signUpListView,
        children: [
          const SizedBox(height: 40),
          Text(
            'Finanças em Ordem',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(color: AppColors.greenTwo),
          ),
          Text(
            'Vida mais Leve.',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(color: AppColors.greenOne),
          ),
          SizedBox(
            width: 200, // Defina a largura desejada
            height: 200, // Defina a altura desejada
            child: Image.asset(
              'assets/images/form.png',
              fit: BoxFit.contain, // Ajuste a forma como a imagem se adapta ao Container
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    key: Keys.signUpNameField,
                    controller: _nameController,
                    labelText: "seu nome",
                    hintText: "Digite seu nome",
                    inputFormatters: [
                      UpperCaseTextInputFormatter(),
                    ],
                    validator: Validator.validateName,
                  ),
                  CustomTextFormField(
                    key: Keys.signUpEmailField,
                    controller: _emailController,
                    labelText: "seu Email",
                    hintText: "email@email.com",
                    validator: Validator.validateEmail,
                  ),
                  PasswordFormField(
                    key: Keys.signUpPasswordField,
                    controller: _passwordController,
                    labelText: "escolha sua senha",
                    hintText: "********",
                    helperText: "Mínimo de 8 caracteres, 1 letra maiuscula, 1 número e 1 simbolo",
                    validator: Validator.validatePassword,
                  ),
                  PasswordFormField(
                    key: Keys.signUpConfirmPasswordField,
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
            padding: const EdgeInsets.only(left: 32.0, right: 20.0, top: 16.0, bottom: 4.0),
            child: PrimaryButton(
              key: Keys.signUpButton,
              text: 'Cadastre-se',
              onPressed: () async {
                final valid = _formKey.currentState != null && _formKey.currentState!.validate();
                if (valid) {
                  try {
                    await _signUpController.signUp(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    log('Usuário cadastrado com sucesso');
                    // Aqui você pode adicionar um redirecionamento ou mensagem de sucesso
                  } catch (e) {
                    log('Erro ao cadastrar usuário: $e'); // Log do erro
                  }
                } else {
                  log('Formulário inválido');
                }
              },
            ),
          ),
          MultiTextButton(
            key: Keys.signUpAlreadyHaveAccountButton,
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
