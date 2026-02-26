import 'package:flutter/material.dart';

class MedicationAwarenessScreen extends StatelessWidget {
  const MedicationAwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: const Text(
          'Medication Awareness',
          style: TextStyle(color: Color(0xFF3D2B1F)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF3D2B1F)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.medication, color: Color(0xFFC17D3C), size: 64),
            const SizedBox(height: 24),
            const Text(
              'Understanding Your Inhalers',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Medications, such as inhalers, are commonly used to manage respiratory conditions. Inhalers deliver medicine directly to the lungs, making them effective and fast-acting. When used correctly, they are safe and help control symptoms.',
              style: TextStyle(
                color: Color(0xFF8C7B6B),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            _DeviceCard(
              title: 'Nebulizer',
              description:
                  'A machine that delivers a fine, steady mist of medicine through a mouthpiece or mask.',
              icon: Icons.air,
            ),
            const SizedBox(height: 16),
            _DeviceCard(
              title: 'Dry Powder Inhaler',
              description:
                  'Contains pre-set doses of medicine in powder form. When you take a deep, fast breath in from the inhaler, the medicine is released into your airways.',
              icon: Icons.compress,
            ),
            const SizedBox(height: 16),
            _DeviceCard(
              title: 'Metered-Dose Inhaler',
              description:
                  'Contains a canister of medicine. When you press the inhaler, it sprays a pre-set amount of medicine through your mouth to your airways.',
              icon: Icons.water_drop,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _DeviceCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8DDD0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFC17D3C).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFC17D3C), size: 24),
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
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF8C7B6B),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
