import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: const Color(0xFF17123A),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF72E8D4),
          unselectedItemColor: const Color(0xFF726A92),
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information),
              label: 'Diagnose',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.healing),
              label: 'Treatment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
