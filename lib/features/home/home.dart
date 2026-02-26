import 'package:flutter/material.dart';
import 'package:raag_breath/features/learn/learn_screen.dart';
import 'package:raag_breath/features/diagnose/diagnose_screen.dart';
import 'package:raag_breath/features/treatment/treatment_screen.dart';
import 'package:raag_breath/features/meditation/meditation.dart';
import 'package:raag_breath/features/music/music.dart';
import 'package:raag_breath/features/profile/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BackgroundLayer(),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                const Text(
                  'Your Lung Health Hub',
                  style: TextStyle(
                    color: Color(0xFF3D2B1F),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose a section to get started',
                  style: TextStyle(color: Color(0xFF8C7B6B), fontSize: 14),
                ),
                const SizedBox(height: 24),
                _MainSectionCard(
                  title: 'Learn',
                  subtitle: 'Build awareness and know your lungs',
                  icon: Icons.auto_stories,
                  accentColor: const Color(0xFF5B8A6E),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LearnScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MainSectionCard(
                  title: 'Diagnose',
                  subtitle: 'Check symptoms and assess your risks',
                  icon: Icons.health_and_safety,
                  accentColor: const Color(0xFF4A7FA8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DiagnoseScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MainSectionCard(
                  title: 'Treatment',
                  subtitle: 'Take action, exercise and find doctors',
                  icon: Icons.healing,
                  accentColor: const Color(0xFFC17D3C),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TreatmentScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MainSectionCard(
                  title: 'Meditation & Breathing',
                  subtitle: 'Practice exercises to strengthen your lungs',
                  icon: Icons.self_improvement,
                  accentColor: const Color(0xFF8B6B4A),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MeditationPage()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MainSectionCard(
                  title: 'Music Therapy',
                  subtitle: 'Listen to ragas that enhance breathing',
                  icon: Icons.music_note,
                  accentColor: const Color(0xFF7B5EA7),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MusicPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello! 👋',
              style: TextStyle(
                color: Color(0xFF8C7B6B),
                fontSize: 15,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Welcome Back',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFC17D3C).withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8DDD0)),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFFC17D3C),
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}

class _MainSectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _MainSectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8DDD0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3D2B1F).withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: accentColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF3D2B1F),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF8C7B6B),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: accentColor, size: 26),
          ],
        ),
      ),
    );
  }
}

class _BackgroundLayer extends StatelessWidget {
  const _BackgroundLayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFBF6EF), Color(0xFFF5EDE0)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -50,
            child: _warmCircle(const Color(0xFFC17D3C).withOpacity(0.08)),
          ),
          Positioned(
            top: 200,
            left: -70,
            child: _warmCircle(const Color(0xFF8B6B4A).withOpacity(0.06)),
          ),
        ],
      ),
    );
  }

  Widget _warmCircle(Color color) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
