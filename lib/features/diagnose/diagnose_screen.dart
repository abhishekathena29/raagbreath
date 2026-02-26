import 'package:flutter/material.dart';
import 'package:raag_breath/features/diagnose/symptom_checker_screen.dart';
import 'package:raag_breath/features/diagnose/risk_assessment_screen.dart';
import 'package:raag_breath/features/diagnose/teacher_parent_alert_screen.dart';
import 'package:raag_breath/features/meditation/lung_capacity_test_screen.dart';

class DiagnoseScreen extends StatelessWidget {
  const DiagnoseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: const Text(
          'Diagnose',
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
            'Check Your Symptoms',
            style: TextStyle(
              color: Color(0xFFC17D3C),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _DiagnoseCard(
            title: 'Symptom Checker',
            subtitle: 'Quick questionnaire to assess your lung condition',
            icon: Icons.checklist,
            accentColor: const Color(0xFF4A7FA8),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SymptomCheckerScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _DiagnoseCard(
            title: 'Risk Assessment',
            subtitle: 'Calculate your lung health score',
            icon: Icons.analytics,
            accentColor: const Color(0xFFC17D3C),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RiskAssessmentScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _DiagnoseCard(
            title: 'Lung Capacity Test',
            subtitle: 'Track how efficiently your lungs use oxygen',
            icon: Icons.air,
            accentColor: const Color(0xFF7B5EA7),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LungCapacityTestScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _DiagnoseCard(
            title: 'Teacher / Parent Alert',
            subtitle: 'Identify early signs of lung problems in children',
            icon: Icons.warning_amber_rounded,
            accentColor: const Color(0xFFCF8A3E),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TeacherParentAlertScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagnoseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _DiagnoseCard({
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
