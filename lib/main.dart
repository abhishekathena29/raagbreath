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
        scaffoldBackgroundColor: const Color(0xFFFBF6EF),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFC17D3C),
          secondary: Color(0xFF8B6B4A),
          surface: Colors.white,
          onSurface: Color(0xFF3D2B1F),
        ),
        textTheme: ThemeData(brightness: Brightness.light).textTheme.apply(
          bodyColor: const Color(0xFF3D2B1F),
          displayColor: const Color(0xFF3D2B1F),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF3D2B1F)),
          titleTextStyle: TextStyle(
            color: Color(0xFF3D2B1F),
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
