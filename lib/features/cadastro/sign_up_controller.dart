import 'dart:developer';
import 'package:despesas_app/features/cadastro/sign_up_state.dart';
import 'package:flutter/foundation.dart';

class SignUpController extends ChangeNotifier {
  SignUpState _state = SignUpInitialState();
  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners(); // Notifica os listeners sobre a mudança de estado
  }

  Future<bool> doSignUp() async {
    _changeState(SignUpLoadingState());

    try {
      // Simulação de uma requisição assíncrona com um pequeno atraso
      await Future.delayed(const Duration(seconds: 2));

      //throw Exception("Erro ao cadastrar usuário");

      log("Usuário criado!");

      _changeState(SignUpSuccessState());

      return true;
    } catch (e) {
      log("Erro ao cadastrar usuário: $e");
      _changeState(SignUpErrorState());
      return false;
    }
  }
}
