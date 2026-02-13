import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/features/auth/login.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: const MyApp(),
    ),
  );
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
        textTheme: ThemeData(
          brightness: Brightness.dark,
        ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: const LoginPage(),
    );
  }
}
