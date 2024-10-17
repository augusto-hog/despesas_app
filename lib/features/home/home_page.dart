import 'package:despesas_app/common/constants/routes.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final _secureStorage = const SecureStorageService();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Nova Tela"),
            ElevatedButton(
              onPressed: () {
                _secureStorage.deleteOne(key: "CURRENT_USER").then(
                  (_) => Navigator.popAndPushNamed(
                    context,
                    NamedRoute.initial,
                  ),
                );
              },
              child: const Text("Logout")
            ),
          ],
        ),
      ),
    );
  }
}