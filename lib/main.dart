import 'package:flutter/material.dart';
import 'package:raag_breath/features/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raag Breath',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF72E8D4),
          secondary: Color(0xFFB078FF),
          background: Color(0xFF0D082B),
          surface: Color(0xFF17123A),
        ),
        scaffoldBackgroundColor: const Color(0xFF0D082B),
        textTheme: ThemeData(brightness: Brightness.dark)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: const LoginPage(),
    );
  }
}
