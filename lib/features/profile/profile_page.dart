// ignore_for_file: use_build_context_synchronously

import 'package:despesas_app/locator.dart';
import '../../services/services.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Profile"),
            TextButton(
                onPressed: () async {
                  await locator.get<AuthService>().signOut();
                  await const SecureStorageService().deleteAll();
                  await locator.get<DatabaseService>().deleteDB;
                  if (mounted) {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  }
                },
                child: const Text("Sair"))
          ],
        ),
      ),
    );
  }
}
