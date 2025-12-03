import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<_SessionCardData> _featuredSessions = const [
    _SessionCardData(
      title: 'Anger Release',
      tag: 'Anger Release',
      imageUrl:
          'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=900&q=80',
      accent: Color(0xFF72E8D4),
    ),
    _SessionCardData(
      title: 'Stress Relief',
      tag: 'Doze Off',
      imageUrl:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',
      accent: Color(0xFF5AD8FE),
    ),
    _SessionCardData(
      title: 'Calm Focus',
      tag: 'Calm Focus',
      imageUrl:
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80',
      accent: Color(0xFFB0A3FF),
    ),
  ];

  final List<_QuickStartData> _quickStarts = const [
    _QuickStartData(
      title: 'Deep Rest',
      imageUrl:
          'https://images.unsplash.com/photo-1526401485004-2aa7c769f5c1?auto=format&fit=crop&w=900&q=80',
      accent: Color(0xFFB078FF),
    ),
    _QuickStartData(
      title: 'Morning Glow',
      imageUrl:
          'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=900&q=80',
      accent: Color(0xFF72E8D4),
    ),
  ];

  final List<_Category> _categories = const [
    _Category('Meditation', Icons.self_improvement),
    _Category('Relief', Icons.spa),
    _Category('Prayer', Icons.front_hand),
    _Category('Mantras', Icons.auto_awesome),
    _Category('Yoga', Icons.emoji_people),
    _Category('Soundscapes', Icons.music_note),
    _Category('Breath', Icons.air),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      body: Stack(
        children: [
          _BackgroundLayer(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildFeatured(),
                  const SizedBox(height: 22),
                  _buildCategories(),
                  const SizedBox(height: 24),
                  _buildQuickStart(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Good Evening✌️',
              style: TextStyle(
                color: Color(0xFFB7B0D7),
                fontSize: 15,
                height: 1.2,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Lilly Wilson',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1540),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.nightlight_round,
            color: Color(0xFF72E8D4),
            size: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatured() {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _featuredSessions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final session = _featuredSessions[index];
          return _FeaturedCard(session: session);
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _categories
          .map(
            (category) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A143C),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFF2D2553)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(category.icon, size: 18, color: const Color(0xFF72E8D4)),
                  const SizedBox(width: 8),
                  Text(
                    category.label,
                    style: const TextStyle(
                      color: Color(0xFFC4BDD7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildQuickStart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Quick Start',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                color: Color(0xFF72E8D4),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _quickStarts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final quick = _quickStarts[index];
              return _QuickStartCard(data: quick);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: const Color(0xFF17123A),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF72E8D4),
          unselectedItemColor: const Color(0xFF726A92),
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.self_improvement),
              label: 'Meditation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Music',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.session});

  final _SessionCardData session;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: DecorationImage(
          image: NetworkImage(session.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.55),
                ],
              ),
            ),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.82),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.self_improvement,
                    size: 16,
                    color: Color(0xFF5B4BA6),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    session.tag,
                    style: const TextStyle(
                      color: Color(0xFF3B305C),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: session.accent,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                session.title,
                style: const TextStyle(
                  color: Color(0xFF1E2D38),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStartCard extends StatelessWidget {
  const _QuickStartCard({required this.data});

  final _QuickStartData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: DecorationImage(
          image: NetworkImage(data.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF2B224C).withOpacity(0.9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                data.title,
                style: TextStyle(
                  color: data.accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 16,
            right: 16,
            child: Text(
              data.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundLayer extends StatelessWidget {
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
            right: -60,
            child: _glowCircle(const Color(0xFF72E8D4).withOpacity(0.25)),
          ),
          Positioned(
            top: 80,
            left: -70,
            child: _glowCircle(const Color(0xFFB078FF).withOpacity(0.2)),
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

class _SessionCardData {
  const _SessionCardData({
    required this.title,
    required this.tag,
    required this.imageUrl,
    required this.accent,
  });

  final String title;
  final String tag;
  final String imageUrl;
  final Color accent;
}

class _QuickStartData {
  const _QuickStartData({
    required this.title,
    required this.imageUrl,
    required this.accent,
  });

  final String title;
  final String imageUrl;
  final Color accent;
}

class _Category {
  const _Category(this.label, this.icon);

  final String label;
  final IconData icon;
}
