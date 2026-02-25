import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/features/auth/login.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/firebase_options.dart';
import 'package:raag_breath/core/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Raag Breath',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF00B4D8),
          secondary: Color(0xFF9D4EDD),
          surface: Colors.white,
          onSurface: Color(0xFF1D3557),
        ),
        textTheme: ThemeData(brightness: Brightness.light).textTheme.apply(
          bodyColor: const Color(0xFF1D3557),
          displayColor: const Color(0xFF1D3557),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1D3557)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1D3557),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D082B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF72E8D4),
          secondary: Color(0xFFB078FF),
          surface: Color(0xFF1A143C),
          onSurface: Colors.white,
        ),
        textTheme: ThemeData(
          brightness: Brightness.dark,
        ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
