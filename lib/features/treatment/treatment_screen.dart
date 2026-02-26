import 'package:flutter/material.dart';
import 'package:raag_breath/features/treatment/doctor_connect_screen.dart';
import 'package:raag_breath/features/treatment/medication_awareness_screen.dart';
import 'package:raag_breath/features/treatment/school_action_screen.dart';
import 'package:raag_breath/features/meditation/meditation.dart';
import 'package:raag_breath/features/music/music.dart';

class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: const Text(
          'Treatment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3D2B1F),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF3D2B1F)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Take Action',
            style: TextStyle(
              color: Color(0xFFC17D3C),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Meditation & Breathing',
            subtitle: 'Pranayama, Dhyana, and Yoga practices',
            icon: Icons.self_improvement,
            accentColor: const Color(0xFF8B6B4A),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MeditationPage()),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Music Therapy',
            subtitle: 'Raag practice and breathwork with music',
            icon: Icons.music_note,
            accentColor: const Color(0xFF7B5EA7),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MusicPage()),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Doctor Connect',
            subtitle: 'Find nearby doctors and teleconsultation',
            icon: Icons.medical_services,
            accentColor: const Color(0xFF4A7FA8),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DoctorConnectScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'Medication Awareness',
            subtitle: 'Learn about inhalers and devices',
            icon: Icons.medication,
            accentColor: const Color(0xFFC17D3C),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MedicationAwarenessScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: 'School Action Kit',
            subtitle: 'Support for students with respiratory conditions',
            icon: Icons.school,
            accentColor: const Color(0xFF5B8A6E),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8DDD0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3D2B1F).withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
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
                      fontWeight: FontWeight.w700,
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
            Icon(Icons.chevron_right, color: accentColor),
          ],
        ),
      ),
    );
  }
}
