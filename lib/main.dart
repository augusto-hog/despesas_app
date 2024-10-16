import 'package:despesas_app/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Impede a execução do código antes de a inicialização ser concluída
  WidgetsFlutterBinding.ensureInitialized(); // Isso é importante!

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
