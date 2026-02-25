import 'package:flutter/material.dart';
import 'package:raag_breath/features/treatment/medication_awareness_screen.dart';
import 'package:raag_breath/features/treatment/doctor_connect_screen.dart';
import 'package:raag_breath/features/treatment/school_action_screen.dart';
import 'package:raag_breath/features/meditation/meditation.dart';
import 'package:raag_breath/features/music/music.dart';

class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Treatment & Action',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Take Action',
            style: TextStyle(
              color: Color(0xFFB0A3FF),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Medication Awareness',
            subtitle: 'Learn about inhalers and other treatments',
            icon: Icons.medication,
            accentColor: const Color(0xFF72E8D4),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MedicationAwarenessScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Doctor Connect',
            subtitle: 'Find healthcare professionals and clinics',
            icon: Icons.medical_services,
            accentColor: const Color(0xFF5AD8FE),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DoctorConnectScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Meditation & Breathing',
            subtitle: 'Strengthen lungs and improve oxygen intake',
            icon: Icons.self_improvement,
            accentColor: const Color(0xFFB0A3FF),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MeditationPage()),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Music Therapy',
            subtitle: 'Listen to ragas that enhance your breathing',
            icon: Icons.music_note,
            accentColor: const Color(0xFF9D4EDD),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MusicPage()),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'School Action Kit',
            subtitle: 'Resources for teachers and school staff',
            icon: Icons.school,
            accentColor: Colors.orangeAccent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SchoolActionScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _TreatmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _TreatmentCard({
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: accentColor),
          ],
        ),
      ),
    );
  }
}
