import 'package:flutter/material.dart';
import 'package:raag_breath/core/data/practice_data.dart';
import 'package:raag_breath/features/meditation/practice_detail.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  static const List<_LocalPracticeItem> _taalPractice = [
    _LocalPracticeItem(
      title: 'Teentaal',
      subtitle: '16 beats, steady and expansive.',
      meta: 'Dha Dhin Dhin Dha',
      accent: Color(0xFF72E8D4),
    ),
    _LocalPracticeItem(
      title: 'Ektaal',
      subtitle: '12 beats for slow vilambit.',
      meta: 'Dhin Dhin DhaGe',
      accent: Color(0xFF5AD8FE),
    ),
    _LocalPracticeItem(
      title: 'Rupak',
      subtitle: '7 beats with a rolling feel.',
      meta: 'Tin Tin Na Dhin Na',
      accent: Color(0xFFB0A3FF),
    ),
  ];

  static const List<_LocalPracticeItem> _breathTone = [
    _LocalPracticeItem(
      title: 'AUM Humming',
      subtitle: 'Resonant humming to steady the breath.',
      meta: '5-7 min',
      accent: Color(0xFF72E8D4),
    ),
    _LocalPracticeItem(
      title: 'Sargam Warmup',
      subtitle: 'Sa Re Ga to loosen the voice.',
      meta: '7-10 min',
      accent: Color(0xFF5AD8FE),
    ),
    _LocalPracticeItem(
      title: 'Tanpura Drone',
      subtitle: 'Sustain tone for pitch focus.',
      meta: '10-12 min',
      accent: Color(0xFFB078FF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _SectionBackground(),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Music',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Indian classical practice for breath, raga, and rhythm.',
                  style: TextStyle(color: Color(0xFFB7B0D7), fontSize: 15),
                ),
                const SizedBox(height: 20),
                _RaagSection(
                  title: 'Raag Practice',
                  items: PracticeData.raagPractice,
                ),
                const SizedBox(height: 18),
                _Section(title: 'Taal and Layakari', items: _taalPractice),
                const SizedBox(height: 18),
                _Section(title: 'Breath + Nada', items: _breathTone),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RaagSection extends StatelessWidget {
  const _RaagSection({required this.title, required this.items});

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
            color: Colors.white,
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

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});

  final String title;
  final List<_LocalPracticeItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => _PracticeCard(
            title: item.title,
            subtitle: item.subtitle,
            meta: item.meta,
            accent: item.accent,
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
        color: const Color(0xFF1A143C),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF2D2553)),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
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
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFFB7B0D7),
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
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocalPracticeItem {
  const _LocalPracticeItem({
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final String meta;
  final Color accent;
}

class _SectionBackground extends StatelessWidget {
  const _SectionBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3B1F5D), Color(0xFF0D082B)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -70,
            child: _glowCircle(const Color(0xFF72E8D4).withOpacity(0.18)),
          ),
          Positioned(
            top: 80,
            left: -70,
            child: _glowCircle(const Color(0xFF5AD8FE).withOpacity(0.18)),
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
