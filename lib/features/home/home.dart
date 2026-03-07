import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/features/auth/models/user_model.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/features/auth/services/firestore_service.dart';
import 'package:raag_breath/features/learn/learn_screen.dart';
import 'package:raag_breath/features/diagnose/diagnose_screen.dart';
import 'package:raag_breath/features/treatment/treatment_screen.dart';
import 'package:raag_breath/features/meditation/meditation.dart';
import 'package:raag_breath/features/music/music.dart';
import 'package:raag_breath/features/profile/profile.dart';
import 'package:raag_breath/features/chatbot/chatbot_screen.dart';

// ─── Helpers ──────────────────────────────────────────────────────────────────

String _greeting() {
  final h = DateTime.now().hour;
  if (h < 12) return 'Good Morning';
  if (h < 17) return 'Good Afternoon';
  return 'Good Evening';
}

String _greetingEmoji() {
  final h = DateTime.now().hour;
  if (h < 12) return '☀️';
  if (h < 17) return '🌤️';
  return '🌙';
}

String _userTypeLabel(UserType type) {
  switch (type) {
    case UserType.student:
      return 'Student';
    case UserType.teacher:
      return 'Teacher';
    case UserType.schoolAdmin:
      return 'School Admin';
    case UserType.parent:
      return 'Parent';
    case UserType.ngo:
      return 'NGO';
  }
}

// ─── Daily Tips Data ──────────────────────────────────────────────────────────

const _kHealthTips = [
  _HealthTip(
    '🫁',
    'Deep Breathing',
    'Practice deep breathing for 10 minutes daily to improve lung capacity and reduce stress.',
  ),
  _HealthTip(
    '💧',
    'Stay Hydrated',
    'Drink at least 8 glasses of water daily. Proper hydration keeps your airways moist and clear.',
  ),
  _HealthTip(
    '🚶',
    'Daily Walk',
    'A 30-minute brisk walk each day strengthens your lungs and improves oxygen intake.',
  ),
  _HealthTip(
    '😤',
    'Pranayama',
    'Practice Nadi Shodhana (alternate nostril breathing) to balance energy and improve focus.',
  ),
  _HealthTip(
    '🪟',
    'Fresh Air',
    'Open windows in the morning to ventilate your home and flush out pollutants overnight.',
  ),
  _HealthTip(
    '🎵',
    'Raga Therapy',
    'Listening to Raag Bhairav in the morning supports calm breathing and mental clarity.',
  ),
];

class _HealthTip {
  final String emoji, title, body;
  const _HealthTip(this.emoji, this.title, this.body);
}

// ─── Home Page ────────────────────────────────────────────────────────────────

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final firebaseUser = authService.user;

    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFBF6EF)),
      child: firebaseUser == null
          ? _buildAnonymousHome(context)
          : StreamBuilder<UserModel?>(
              stream: FirestoreService().getUserStream(firebaseUser.uid),
              builder: (ctx, snapshot) {
                final userModel = snapshot.data;
                return _buildDashboard(context, userModel);
              },
            ),
    );
  }

  Widget _buildAnonymousHome(BuildContext context) {
    return _buildDashboard(context, null);
  }

  Widget _buildDashboard(BuildContext context, UserModel? user) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Greeting Banner ──────────────────────────────────────────────
          _GreetingBanner(user: user),

          const SizedBox(height: 20),

          // ── Stats Row ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _StatsRow(user: user),
          ),

          const SizedBox(height: 24),

          // ── Quick Actions ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                _QuickActionsGrid(),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ── Daily Health Tips ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Health Tips',
                  style: TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                ..._kHealthTips.map((tip) => _TipCard(tip: tip)),
              ],
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ─── Greeting Banner ──────────────────────────────────────────────────────────

class _GreetingBanner extends StatelessWidget {
  final UserModel? user;
  const _GreetingBanner({required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user?.name.isNotEmpty == true ? user!.name : 'Friend';
    final role = user != null ? _userTypeLabel(user!.userType) : '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.of(context).padding.top + 24,
        24,
        28,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6B3D1E), Color(0xFFC17D3C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_greeting()} ${_greetingEmoji()}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                if (role.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      role.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Row ────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final UserModel? user;
  const _StatsRow({required this.user});

  @override
  Widget build(BuildContext context) {
    final streak = user?.currentStreak ?? 0;
    final sessions = user?.totalPracticeMinutes ?? 0;
    final lungScore = user?.lungCapacityScore ?? 0.0;

    return Row(
      children: [
        _StatCard(
          icon: Icons.local_fire_department_rounded,
          iconColor: const Color(0xFFD32F2F), // amber bg, consistent with app
          value: '$streak',
          label: 'Day Streak',
          bgColor: const Color(0xFFFFF3E0),
        ),
        const SizedBox(width: 12),
        _StatCard(
          icon: Icons.calendar_month_rounded,
          iconColor: const Color(0xFF8B6B4A),
          value: '${sessions}m',
          label: 'Total Practice',
          bgColor: const Color(0xFFF5EDE0),
        ),
        const SizedBox(width: 12),
        _StatCard(
          icon: Icons.air_rounded,
          iconColor: const Color(0xFF5B8A6E),
          value: lungScore > 0 ? '${lungScore.toStringAsFixed(1)}L' : '--',
          label: 'Lung Score',
          bgColor: const Color(0xFFE8F5EE),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor, bgColor;
  final String value, label;
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF8C8C9E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Quick Actions Grid ───────────────────────────────────────────────────────

class _ActionItem {
  final String label, emoji;
  final Color color, bgColor;
  final Widget Function(BuildContext) destination;
  const _ActionItem(
    this.label,
    this.emoji,
    this.color,
    this.bgColor,
    this.destination,
  );
}

class _QuickActionsGrid extends StatelessWidget {
  static final _actions = <_ActionItem>[
    _ActionItem(
      'Diagnose',
      '🔬',
      const Color(0xFFD32F2F),
      const Color(0xFFFFEBEE),
      (_) => const DiagnoseScreen(),
    ),
    _ActionItem(
      'Learn',
      '📚',
      const Color(0xFF1565C0),
      const Color(0xFFE3F2FD),
      (_) => const LearnScreen(),
    ),
    _ActionItem(
      'Meditation',
      '🧘',
      const Color(0xFF7B1FA2),
      const Color(0xFFF3E5F5),
      (_) => const MeditationPage(),
    ),
    _ActionItem(
      'Music Therapy',
      '🎵',
      const Color(0xFF880E4F),
      const Color(0xFFFCE4EC),
      (_) => const MusicPage(),
    ),
    _ActionItem(
      'Treatment',
      '💊',
      const Color(0xFFE65100),
      const Color(0xFFFFF3E0),
      (_) => const TreatmentScreen(),
    ),
    _ActionItem(
      'AI Chat',
      '🤖',
      const Color(0xFF00695C),
      const Color(0xFFE0F2F1),
      (_) => const ChatbotScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: _actions.length,
      itemBuilder: (ctx, i) => _ActionCard(action: _actions[i]),
    );
  }
}

class _ActionCard extends StatefulWidget {
  final _ActionItem action;
  const _ActionCard({required this.action});

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.93,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.action;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        Navigator.push(context, MaterialPageRoute(builder: a.destination));
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC17D3C).withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: a.bgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(a.emoji, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                a.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3D2B1F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Tip Card ─────────────────────────────────────────────────────────────────

class _TipCard extends StatelessWidget {
  final _HealthTip tip;
  const _TipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF5EDE0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(tip.emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8C8C9E),
                    height: 1.5,
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
