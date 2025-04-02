import 'package:despesas_app/app.dart';
import 'package:despesas_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa formatação de datas em português
  await initializeDateFormatting('pt_BR', null);

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configura Injeção de Dependências
  setupDependencies();
  await locator.allReady();

  runApp(const App());
}
