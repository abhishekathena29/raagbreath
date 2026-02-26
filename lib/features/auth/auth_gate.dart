import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raag_breath/features/auth/login.dart';
import 'package:raag_breath/features/navigation/main_shell.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFFBF6EF),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFC17D3C)),
            ),
          );
        }

        if (snapshot.hasData) {
          return const MainShell();
        }

        return const LoginPage();
      },
    );
  }
}
