import 'package:flutter/material.dart';
import 'package:raag_breath/features/learn/learn_screen.dart';
import 'package:raag_breath/features/diagnose/diagnose_screen.dart';
import 'package:raag_breath/features/treatment/treatment_screen.dart';
import 'package:raag_breath/features/meditation/meditation.dart';
import 'package:raag_breath/features/music/music.dart';

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
                Text(
                  'Your Lung Health Hub',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),
                _MainSectionCard(
                  title: 'Learn',
                  subtitle: 'Build awareness and know your lungs',
                  icon: Icons.auto_stories,
                  accentColor: const Color(0xFF72E8D4),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LearnScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _MainSectionCard(
                  title: 'Diagnose',
                  subtitle: 'Check symptoms and assess your risks',
                  icon: Icons.health_and_safety,
                  accentColor: const Color(0xFF5AD8FE),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DiagnoseScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _MainSectionCard(
                  title: 'Treatment',
                  subtitle: 'Take action, exercise and find doctors',
                  icon: Icons.healing,
                  accentColor: const Color(0xFFB0A3FF),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TreatmentScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _MainSectionCard(
                  title: 'Meditation & Breathing',
                  subtitle: 'Practice exercises to strengthen your lungs',
                  icon: Icons.self_improvement,
                  accentColor: const Color(0xFF00B4D8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MeditationPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _MainSectionCard(
                  title: 'Music Therapy',
                  subtitle: 'Listen to ragas that enhance breathing',
                  icon: Icons.music_note,
                  accentColor: const Color(0xFF9D4EDD),
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
            Text(
              'Hello! 👋',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 15,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Welcome Back',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.spa,
            color: Theme.of(context).colorScheme.primary,
            size: 26,
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: accentColor, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: accentColor, size: 28),
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -60,
            child: _glowCircle(const Color(0xFF72E8D4).withOpacity(0.25)),
          ),
          Positioned(
            top: 80,
            left: -70,
            child: _glowCircle(const Color(0xFFB078FF).withOpacity(0.2)),
          ),
        ],
      ),
    );
  }

  Widget _glowCircle(Color color) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
