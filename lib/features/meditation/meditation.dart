import 'package:flutter/material.dart';
import 'package:raag_breath/core/data/practice_data.dart';
import 'package:raag_breath/core/l10n/app_strings.dart';
import 'package:raag_breath/core/models/practice_item.dart';
import 'package:raag_breath/features/meditation/practice_detail.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Scaffold(
      body: Stack(
        children: [
          const _SectionBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.meditation,
                    style: const TextStyle(
                      color: Color(0xFF3D2B1F),
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    s.meditationSubtitle,
                    style: const TextStyle(
                      color: Color(0xFF8C7B6B),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _PranayamaSection(
                    title: s.pranayamaBreaths,
                    items: PracticeData.pranayama,
                  ),
                  const SizedBox(height: 18),
                  _PracticeSection(
                    title: s.dhyanaPractices,
                    items: PracticeData.meditation,
                  ),
                  const SizedBox(height: 18),
                  _PracticeSection(
                    title: s.yogaFoundations,
                    items: PracticeData.yoga,
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

class _PranayamaSection extends StatelessWidget {
  const _PranayamaSection({required this.title, required this.items});

  final String title;
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 12),
        ...items.map(
          (item) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PracticeDetailScreen(item: item),
                ),
              );
            },
            child: _PracticeCard(
              title: item.title,
              subtitle: item.subtitle,
              meta: item.meta,
              accent: item.accent,
            ),
          ),
        ),
      ],
    );
  }
}

class _PracticeSection extends StatelessWidget {
  const _PracticeSection({required this.title, required this.items});

  final String title;
  final List<PracticeItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 12),
        ...items.map(
          (item) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PracticeDetailScreen(item: item),
                ),
              );
            },
            child: _PracticeCard(
              title: item.title,
              subtitle: item.subtitle,
              meta: item.meta,
              accent: item.accent,
            ),
          ),
        ),
      ],
    );
  }
}

class _PracticeCard extends StatelessWidget {
  const _PracticeCard({
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            width: 10,
            height: 42,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF3D2B1F),
                    fontSize: 15,
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
          const SizedBox(width: 12),
          Text(
            meta,
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionBackground extends StatelessWidget {
  const _SectionBackground();

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
            top: -110,
            right: -60,
            child: _warmCircle(const Color(0xFFC17D3C).withOpacity(0.08)),
          ),
          Positioned(
            bottom: -90,
            left: -50,
            child: _warmCircle(const Color(0xFF8B6B4A).withOpacity(0.06)),
          ),
        ],
      ),
    );
  }

  Widget _warmCircle(Color color) {
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
