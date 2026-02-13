import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/core/utils/lung_capacity_calculator.dart';
import 'package:raag_breath/features/auth/models/user_model.dart';
import 'package:raag_breath/features/auth/onboarding_screen.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/features/auth/services/firestore_service.dart';
import 'package:raag_breath/features/meditation/models/practice_session.dart';
import '../meditation/lung_capacity_test_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const List<_PracticeItem> _todayPlan = [
    _PracticeItem(
      title: 'Morning Pranayama',
      subtitle: 'Nadi Shodhana + Bhramari',
      meta: '12 min',
      accent: Color(0xFF72E8D4),
    ),
    _PracticeItem(
      title: 'Raga Listening',
      subtitle: 'Raag Bhairav with tanpura drone',
      meta: '15 min',
      accent: Color(0xFF5AD8FE),
    ),
    _PracticeItem(
      title: 'Evening Yoga',
      subtitle: 'Surya Namaskar + moon flow',
      meta: '18 min',
      accent: Color(0xFFB078FF),
    ),
  ];

  static const List<_PracticeItem> _savedRoutines = [
    _PracticeItem(
      title: 'Breath Reset',
      subtitle: 'Ujjayi + So-Ham meditation',
      meta: '10 min',
      accent: Color(0xFF72E8D4),
    ),
    _PracticeItem(
      title: 'Riyaz Focus',
      subtitle: 'Sa Re Ga warmup + Raag Yaman',
      meta: '20 min',
      accent: Color(0xFFB0A3FF),
    ),
    _PracticeItem(
      title: 'Night Calm',
      subtitle: 'Yoga Nidra + soft humming',
      meta: '15 min',
      accent: Color(0xFF5AD8FE),
    ),
  ];

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Helper to format practice time
  String _formatPracticeTime(int minutes) {
    if (minutes < 60) return '${minutes}m';
    return '${(minutes / 60).toStringAsFixed(1)}h';
  }

  Widget _buildLungCapacityDashboard(UserModel user, Color accent) {
    // Calculate Dynamic Capacity
    final double capacity = LungCapacityCalculator.calculate(user);
    final String capacityStr = '${capacity}L';

    // Calculate target (arbitrary goal, e.g. Base + 20%)
    final double target = (capacity * 1.2);
    final String targetStr = '${target.toStringAsFixed(1)}L';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LungCapacityTestScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1540),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFF2D2553)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lung Capacity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.monitor_heart, size: 14, color: accent),
                      const SizedBox(width: 4),
                      Text(
                        'Dynamic Score',
                        style: TextStyle(
                          color: accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Progress Bar (Capacity relative to 7L max)
            Stack(
              children: [
                Container(
                  height: 12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D082B),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: (capacity / 8.0).clamp(0.0, 1.0),
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accent, accent.withOpacity(0.5)],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat('Estimated', capacityStr, accent),
                _buildStat('Goal', targetStr, const Color(0xFFB7B0D7)),
                _buildStat(
                  'Streak',
                  '${user.currentStreak} Days',
                  const Color(0xFFECB4FF),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF2D2553)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat(
                  'Total Practice',
                  _formatPracticeTime(user.totalPracticeMinutes),
                  Colors.white70,
                ),
                _buildStat(
                  'Sessions',
                  'View History >',
                  Colors.white30,
                ), // Placeholder for history
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection(String uid) {
    return FutureBuilder<List<PracticeSession>>(
      future: FirestoreService().getRecentPracticeSessions(uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final sessions = snapshot.data!;
        if (sessions.isEmpty) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Activity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...sessions.map((session) {
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF72E8D4).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.history,
                        color: Color(0xFF72E8D4),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.title.isNotEmpty
                                ? session.title
                                : session.practiceType,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${session.practiceType} • ${_formatPracticeTime(session.durationMinutes)}",
                            style: const TextStyle(
                              color: Color(0xFFB7B0D7),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${session.date.day}/${session.date.month}",
                      style: const TextStyle(
                        color: Colors.white30,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFB7B0D7),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    if (user == null) {
      return Container(
        color: const Color(0xFF0D082B),
        child: const Center(
          child: Text(
            "Please login to view profile",
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return StreamBuilder<UserModel?>(
      stream: FirestoreService().getUserStream(user.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData &&
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Handle case where user document doesn't exist yet or error
        final userModel = snapshot.data;
        if (userModel == null) {
          return const Center(
            child: Text(
              "Loading Profile...",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return Stack(
          children: [
            const _SectionBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const OnboardingScreen(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white70,
                              ),
                              onPressed: () => authService.signOut(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hello, ${userModel.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Keep breathing, keep growing.',
                      style: TextStyle(color: Color(0xFFB7B0D7), fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    _buildLungCapacityDashboard(
                      userModel,
                      const Color(0xFF72E8D4),
                    ),
                    const SizedBox(height: 32),
                    _Section(
                      title: 'Today\'s Sadhana',
                      items: ProfilePage._todayPlan,
                    ),
                    const SizedBox(height: 18),
                    _Section(
                      title: 'Saved Routines',
                      items: ProfilePage._savedRoutines,
                    ),
                    const SizedBox(height: 32),
                    _buildHistorySection(user.uid),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});

  final String title;
  final List<_PracticeItem> items;

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
        ...items.map((item) => _PracticeCard(item: item)),
      ],
    );
  }
}

class _PracticeCard extends StatelessWidget {
  const _PracticeCard({required this.item});

  final _PracticeItem item;

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
              color: item.accent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
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
            item.meta,
            style: TextStyle(
              color: item.accent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticeItem {
  const _PracticeItem({
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
            top: -110,
            right: -60,
            child: _glowCircle(const Color(0xFFB078FF).withOpacity(0.2)),
          ),
          Positioned(
            bottom: -90,
            left: -50,
            child: _glowCircle(const Color(0xFF72E8D4).withOpacity(0.2)),
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
