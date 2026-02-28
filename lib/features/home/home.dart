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
        // Warm background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFBF6EF), Color(0xFFF5EDE0)],
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello! 👋',
                          style: TextStyle(
                            color: Color(0xFF8C7B6B),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Color(0xFF3D2B1F),
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                      ),
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
                ),

                const SizedBox(height: 28),
                const Text(
                  'Your Lung Health Hub',
                  style: TextStyle(
                    color: Color(0xFF3D2B1F),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Choose a section to get started',
                  style: TextStyle(color: Color(0xFF8C7B6B), fontSize: 13),
                ),
                const SizedBox(height: 18),

                // Simple clean section list
                _SectionTile(
                  title: 'Learn',
                  subtitle: 'Build awareness & know your lungs',
                  emoji: '📚',
                  accentColor: const Color(0xFF0288D1),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LearnScreen()),
                  ),
                ),
                _SectionTile(
                  title: 'Diagnose',
                  subtitle: 'Check symptoms & assess your risk',
                  emoji: '🔬',
                  accentColor: const Color(0xFF3949AB),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DiagnoseScreen()),
                  ),
                ),
                _SectionTile(
                  title: 'Treatment',
                  subtitle: 'Take action & find doctors near you',
                  emoji: '💊',
                  accentColor: const Color(0xFFE64A19),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TreatmentScreen()),
                  ),
                ),
                _SectionTile(
                  title: 'Meditation',
                  subtitle: 'Breathing exercises to strengthen lungs',
                  emoji: '🧘',
                  accentColor: const Color(0xFF7B1FA2),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MeditationPage()),
                  ),
                ),
                _SectionTile(
                  title: 'Music Therapy',
                  subtitle: 'Ragas that calm and enhance breathing',
                  emoji: '🎵',
                  accentColor: const Color(0xFF880E4F),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MusicPage()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTile extends StatefulWidget {
  final String title, subtitle, emoji;
  final Color accentColor;
  final VoidCallback onTap;

  const _SectionTile({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_SectionTile> createState() => _SectionTileState();
}

class _SectionTileState extends State<_SectionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.accentColor.withOpacity(0.10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      widget.emoji,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF3D2B1F),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C7B6B),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: widget.accentColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
