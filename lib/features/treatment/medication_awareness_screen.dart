import 'package:flutter/material.dart';

class MedicationAwarenessScreen extends StatelessWidget {
  const MedicationAwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: const Text(
          'Comfort Tools',
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
            const Icon(Icons.air, color: Color(0xFFC17D3C), size: 64),
            const SizedBox(height: 24),
            const Text(
              'Helpful Breathing Space Tools',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Some everyday tools can make your space feel more comfortable and support calmer breathing habits. These are general wellness ideas for creating cleaner, gentler surroundings at home or school.',
              style: TextStyle(
                color: Color(0xFF8C7B6B),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            _DeviceCard(
              title: 'Air Purifier',
              description:
                  'Helps reduce dust and fine particles in indoor spaces, especially in rooms that feel stuffy or polluted.',
              icon: Icons.air,
            ),
            const SizedBox(height: 16),
            _DeviceCard(
              title: 'Humidifier',
              description:
                  'Adds gentle moisture to dry indoor air, which some people find more comfortable during dry weather or air-conditioned days.',
              icon: Icons.water_drop,
            ),
            const SizedBox(height: 16),
            _DeviceCard(
              title: 'Steam Bowl',
              description:
                  'A warm bowl of steam can be used for a short, mindful breathing break. Keep a safe distance and use adult supervision when needed.',
              icon: Icons.spa,
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
