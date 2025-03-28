import 'package:despesas_app/app.dart';
import 'package:despesas_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';

void main() async {
  // Impede a execução do código antes de a inicialização ser concluída
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Espera a configuração das dependências ser concluída antes de iniciar o app
  await setup();

  runApp(const App());
}

