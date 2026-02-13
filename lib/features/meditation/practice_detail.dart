import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/models/practice_item.dart';
import 'breathing_simulation.dart';

class PracticeDetailScreen extends StatelessWidget {
  final PracticeItem item;

  const PracticeDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      body: Stack(
        children: [
          const _DetailBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: item.accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: item.accent.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              item.meta,
                              style: TextStyle(
                                color: item.accent,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (item.purpose != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          item.purpose!,
                          style: TextStyle(
                            color: item.accent,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      _DetailSection(
                        title: 'Description',
                        content: item.description,
                      ),
                      if (item.timeOfDay != null || item.mood != null) ...[
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            if (item.timeOfDay != null)
                              Expanded(
                                child: _InfoCard(
                                  label: 'Time',
                                  value: item.timeOfDay!,
                                  icon: Icons.access_time_rounded,
                                  accent: item.accent,
                                ),
                              ),
                            if (item.timeOfDay != null && item.mood != null)
                              const SizedBox(width: 16),
                            if (item.mood != null)
                              Expanded(
                                child: _InfoCard(
                                  label: 'Mood',
                                  value: item.mood!,
                                  icon: Icons.auto_awesome_rounded,
                                  accent: item.accent,
                                ),
                              ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 32),
                      const Text(
                        'Steps to Practice',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...item.steps.asMap().entries.map((entry) {
                        return _StepItem(
                          index: entry.key + 1,
                          text: entry.value,
                          accent: item.accent,
                        );
                      }),
                      const SizedBox(height: 40),
                      if (item.videoUrl != null) ...[
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () async {
                            final url = Uri.parse(item.videoUrl!);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          icon: const Icon(Icons.play_circle_fill_rounded),
                          label: const Text(
                            'Watch Tutorial Video',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: item.accent,
                            side: BorderSide(
                              color: item.accent.withOpacity(0.5),
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      if (item.timeOfDay == null) // Breathing exercise
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: item.accent,
                            foregroundColor: const Color(0xFF0D082B),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            shadowColor: item.accent.withOpacity(0.4),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BreathingSimulationScreen(
                                  title: item.title,
                                  accent: item.accent,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Start Simulation',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                        )
                      else // Raag practice or other
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: item.accent,
                            foregroundColor: const Color(0xFF0D082B),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            shadowColor: item.accent.withOpacity(0.4),
                          ),
                          onPressed: () {
                            // TODO: Implement music practice session
                          },
                          child: const Text(
                            'Start Practice',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      const SizedBox(height: 48),
                    ]),
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

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;

  const _DetailSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB7B0D7),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF17123A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2D2553)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFB7B0D7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int index;
  final String text;
  final Color accent;

  const _StepItem({
    required this.index,
    required this.text,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: accent.withOpacity(0.5), width: 1.5),
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBackground extends StatelessWidget {
  const _DetailBackground();

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
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF72E8D4).withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
