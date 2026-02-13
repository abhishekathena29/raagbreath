import 'package:flutter/material.dart';
import 'package:raag_breath/features/home/home.dart';
import 'package:raag_breath/features/meditation/meditation.dart';
import 'package:raag_breath/features/music/music.dart';
import 'package:raag_breath/features/profile/profile.dart';
import 'package:raag_breath/features/navigation/app_bottom_nav.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages = const [
    HomePage(),
    MeditationPage(),
    MusicPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
