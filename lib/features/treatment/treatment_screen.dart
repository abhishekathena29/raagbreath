import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:raag_breath/core/l10n/app_strings.dart';
import 'package:raag_breath/features/treatment/medication_awareness_screen.dart';
import 'package:raag_breath/features/treatment/school_action_screen.dart';

class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: Text(
          s.accessToCare,
          style: const TextStyle(
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
          Text(
            s.supportYourRoutine,
            style: const TextStyle(
              color: Color(0xFFC17D3C),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          const _PulmonologistCard(),
          const SizedBox(height: 16),
          _TreatmentCard(
            title: s.comfortTools,
            subtitle: s.comfortToolsSub,
            icon: Icons.air,
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
            title: s.classroomTips,
            subtitle: s.classroomTipsSub,
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

class _PulmonologistCard extends StatelessWidget {
  const _PulmonologistCard();

  static const _accent = Color(0xFF4A7FA8);
  static const _whatsappNumber = '919818462626';
  static const _displayNumber = '+91 98184 62626';

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse('https://wa.me/$_whatsappNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.medical_services,
                  color: _accent,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  s.connectPulmonologists,
                  style: const TextStyle(
                    color: Color(0xFF3D2B1F),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            s.doctorName,
            style: const TextStyle(
              color: Color(0xFF3D2B1F),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            s.doctorRole,
            style: const TextStyle(
              color: Color(0xFF3D2B1F),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            s.doctorHospital,
            style: const TextStyle(
              color: Color(0xFF8C7B6B),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _openWhatsApp,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF25D366).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF25D366).withOpacity(0.35),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.chat,
                    color: Color(0xFF128C7E),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.whatsapp,
                          style: const TextStyle(
                            color: Color(0xFF128C7E),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _displayNumber,
                          style: const TextStyle(
                            color: Color(0xFF3D2B1F),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF128C7E),
                    size: 18,
                  ),
                ],
              ),
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
