import 'dart:math' as math;
import 'package:flutter/material.dart';

// ─── Main Learn Screen ────────────────────────────────────────────────────────

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  static const List<_ModuleInfo> _modules = [
    _ModuleInfo(
      index: 1,
      title: 'Know Your Lungs',
      subtitle: 'Anatomy & Function',
      emoji: '🫁',
      gradientColors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
      accentColor: Color(0xFF0288D1),
      tag: 'FOUNDATION',
      durationMin: 8,
    ),
    _ModuleInfo(
      index: 2,
      title: 'What Harms Your Lungs',
      subtitle: 'Pollution & Allergens',
      emoji: '☁️',
      gradientColors: [Color(0xFFFF7043), Color(0xFFBF360C)],
      accentColor: Color(0xFFE64A19),
      tag: 'AWARENESS',
      durationMin: 7,
    ),
    _ModuleInfo(
      index: 3,
      title: 'Keep Your Lungs Healthy',
      subtitle: 'Exercise & Diet',
      emoji: '💪',
      gradientColors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
      accentColor: Color(0xFF388E3C),
      tag: 'HEALTH',
      durationMin: 10,
    ),
    _ModuleInfo(
      index: 4,
      title: 'Air Quality Awareness',
      subtitle: 'AQI & Safety',
      emoji: '🌍',
      gradientColors: [Color(0xFFAB47BC), Color(0xFF6A1B9A)],
      accentColor: Color(0xFF7B1FA2),
      tag: 'ENVIRONMENT',
      durationMin: 9,
    ),
  ];

  late AnimationController _staggerCtrl;

  @override
  void initState() {
    super.initState();
    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _staggerCtrl.forward();
  }

  @override
  void dispose() {
    _staggerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4FB),
      body: Column(
        children: [
          // Header — sky blue gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF29B6F6),
                  Color(0xFF0288D1),
                  Color(0xFF01579B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 20, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📚  LEARN',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                'Lung Health Academy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        '4 interactive modules  ·  ~34 min total',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Horizontal progress overview
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: _modules.map((m) {
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                right: m.index < _modules.length ? 6 : 0,
                              ),
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Module list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              itemCount: _modules.length,
              itemBuilder: (ctx, i) {
                // Staggered interval: each card starts 150ms after the previous
                final start = i * 0.15;
                final end = (start + 0.55).clamp(0.0, 1.0);
                final slideAnim =
                    Tween<Offset>(
                      begin: const Offset(0, 0.4),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _staggerCtrl,
                        curve: Interval(start, end, curve: Curves.easeOutCubic),
                      ),
                    );
                final fadeAnim = Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: _staggerCtrl,
                    curve: Interval(start, end, curve: Curves.easeIn),
                  ),
                );
                return SlideTransition(
                  position: slideAnim,
                  child: FadeTransition(
                    opacity: fadeAnim,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: _ModuleCard(
                        info: _modules[i],
                        onTap: () => Navigator.push(
                          ctx,
                          MaterialPageRoute(
                            builder: (_) => ModuleDetailScreen(
                              moduleIndex: _modules[i].index,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleInfo {
  final int index, durationMin;
  final String title, subtitle, emoji, tag;
  final List<Color> gradientColors;
  final Color accentColor;

  const _ModuleInfo({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradientColors,
    required this.accentColor,
    required this.tag,
    required this.durationMin,
  });
}

class _ModuleCard extends StatefulWidget {
  final _ModuleInfo info;
  final VoidCallback onTap;
  const _ModuleCard({required this.info, required this.onTap});

  @override
  State<_ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<_ModuleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.info;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: info.accentColor.withValues(alpha: 0.15),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: info.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                ),
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'MODULE ${info.index}  ·  ${info.tag}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            info.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(info.emoji, style: const TextStyle(fontSize: 42)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                child: Row(
                  children: [
                    _chip(
                      Icons.timer_outlined,
                      '${info.durationMin} min',
                      info.accentColor,
                    ),
                    const SizedBox(width: 10),
                    _chip(
                      Icons.menu_book_rounded,
                      info.subtitle,
                      info.accentColor,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: info.gradientColors),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Start',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ─── Module Detail Screen ─────────────────────────────────────────────────────

class ModuleDetailScreen extends StatefulWidget {
  final int moduleIndex;
  const ModuleDetailScreen({super.key, required this.moduleIndex});

  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen>
    with SingleTickerProviderStateMixin {
  late final _ModuleContent content;
  int _page = 0;
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    content = _ModuleContent.forIndex(widget.moduleIndex);
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = _page + delta;
    if (next < 0 || next >= content.pages.length) return;
    _fadeCtrl.reverse().then((_) {
      setState(() => _page = next);
      _fadeCtrl.forward();
    });
  }

  // Swipe gesture support
  @override
  Widget build(BuildContext context) {
    final total = content.pages.length;
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4FB),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < -400) _go(1); // swipe left → next
          if (details.primaryVelocity! > 400) _go(-1); // swipe right → prev
        },
        child: Column(
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: content.gradColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MODULE ${widget.moduleIndex}',
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  content.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_page + 1} / $total',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: (_page + 1) / total,
                          backgroundColor: Colors.white.withValues(alpha: 0.25),
                          color: Colors.white,
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
            // Content
            Expanded(
              child: FadeTransition(
                opacity: _fade,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: content.pages[_page].build(
                    context,
                    content.accent,
                    content.gradColors,
                  ),
                ),
              ),
            ),
            // Nav bar
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                20,
                12,
                20,
                MediaQuery.of(context).padding.bottom + 12,
              ),
              child: Row(
                children: [
                  if (_page > 0) ...[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _go(-1),
                        icon: const Icon(Icons.arrow_back_rounded, size: 16),
                        label: const Text('Back'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: content.accent,
                          side: BorderSide(color: content.accent),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _page == total - 1
                          ? () => Navigator.pop(context)
                          : () => _go(1),
                      icon: Icon(
                        _page == total - 1
                            ? Icons.check_circle_outline_rounded
                            : Icons.arrow_forward_rounded,
                        size: 18,
                      ),
                      label: Text(_page == total - 1 ? 'Done!' : 'Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: content.accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Page Model ───────────────────────────────────────────────────────────────

abstract class _Page {
  Widget build(BuildContext ctx, Color accent, List<Color> grad);
}

class _ModuleContent {
  final String title;
  final Color accent;
  final List<Color> gradColors;
  final List<_Page> pages;
  const _ModuleContent({
    required this.title,
    required this.accent,
    required this.gradColors,
    required this.pages,
  });

  static _ModuleContent forIndex(int i) {
    switch (i) {
      case 1:
        return _module1();
      case 2:
        return _module2();
      case 3:
        return _module3();
      case 4:
        return _module4();
      default:
        return _module1();
    }
  }
}

// ─── Reusable Page Widgets ────────────────────────────────────────────────────

class _RichPage extends _Page {
  final String heroEmoji, heroStat, heroLabel, heroSub;
  final String sectionIcon, sectionTitle;
  final List<_Item> items;
  final String? didYouKnow;

  _RichPage({
    required this.heroEmoji,
    required this.heroStat,
    required this.heroLabel,
    required this.heroSub,
    required this.sectionIcon,
    required this.sectionTitle,
    required this.items,
    this.didYouKnow,
  });

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero stat
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: grad,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              Text(heroEmoji, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              Text(
                heroStat,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                heroLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                heroSub,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        // Section
        Row(
          children: [
            Text(sectionIcon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              sectionTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: grad),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        item.emoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.desc,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF757575),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (didYouKnow != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFFFCC02), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('💡', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 8),
                    Text(
                      'Did You Know?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFF57F17),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  didYouKnow!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5D4037),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}

class _GridPage extends _Page {
  final String sectionIcon, sectionTitle;
  final List<_GridItem> items;
  final String? didYouKnow;
  final String? swapLeftEmoji,
      swapLeftTitle,
      swapLeftDesc,
      swapRightEmoji,
      swapRightTitle,
      swapRightDesc,
      swapCaption;

  _GridPage({
    required this.sectionIcon,
    required this.sectionTitle,
    required this.items,
    this.didYouKnow,
    this.swapLeftEmoji,
    this.swapLeftTitle,
    this.swapLeftDesc,
    this.swapRightEmoji,
    this.swapRightTitle,
    this.swapRightDesc,
    this.swapCaption,
  });

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(sectionIcon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              sectionTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
          children: items
              .map(
                (g) => Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(g.emoji, style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 8),
                      Text(
                        g.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (g.desc.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          g.desc,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF9E9E9E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        // Optional gas-swap card
        if (swapLeftEmoji != null) ...[
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              swapLeftEmoji!,
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              swapLeftTitle!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Color(0xFF0288D1),
                              ),
                            ),
                            Text(
                              swapLeftDesc!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF757575),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: grad),
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '⇄',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'SWAP',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBE9E7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              swapRightEmoji!,
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              swapRightTitle!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Color(0xFFE64A19),
                              ),
                            ),
                            Text(
                              swapRightDesc!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF757575),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  swapCaption!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
        if (didYouKnow != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFFFCC02), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('💡', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 8),
                    Text(
                      'Did You Know?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFF57F17),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  didYouKnow!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5D4037),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}

class _AQIPage extends _Page {
  _AQIPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AQI meter interactive
        _AQIMeterWidget(accent: accent, grad: grad),
        const SizedBox(height: 22),
        // AQI levels
        Row(
          children: [
            const Text('📊', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'The 6 AQI Levels',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._levels.map((l) {
          final c = Color(int.parse('FF${l[3]}', radix: 16));
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: c.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Text(l[2], style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l[0],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: c,
                          ),
                        ),
                        Text(
                          l[1],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      l[4],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  static const _levels = [
    ['0–50', 'Good', '😊', '4CAF50', 'SAFE'],
    ['51–100', 'Moderate', '😐', 'FFCA28', 'CAUTION'],
    ['101–150', 'Unhealthy for Sensitive', '😷', 'FF9800', 'LIMIT'],
    ['151–200', 'Unhealthy', '😰', 'F44336', 'AVOID'],
    ['201–300', 'Very Unhealthy', '🤢', '9C27B0', 'STAY IN'],
    ['301+', 'Hazardous', '☠️', '880E4F', 'DANGER'],
  ];
}

class _AQIMeterWidget extends StatefulWidget {
  final Color accent;
  final List<Color> grad;
  const _AQIMeterWidget({required this.accent, required this.grad});

  @override
  State<_AQIMeterWidget> createState() => _AQIMeterWidgetState();
}

class _AQIMeterWidgetState extends State<_AQIMeterWidget> {
  double _aqi = 25;

  Color get _color {
    if (_aqi <= 50) return const Color(0xFF4CAF50);
    if (_aqi <= 100) return const Color(0xFFFFCA28);
    if (_aqi <= 150) return const Color(0xFFFF9800);
    if (_aqi <= 200) return const Color(0xFFF44336);
    if (_aqi <= 300) return const Color(0xFF9C27B0);
    return const Color(0xFF880E4F);
  }

  String get _label {
    if (_aqi <= 50) return 'Good 😊';
    if (_aqi <= 100) return 'Moderate 😐';
    if (_aqi <= 150) return 'Unhealthy for Sensitive 😷';
    if (_aqi <= 200) return 'Unhealthy 😰';
    if (_aqi <= 300) return 'Very Unhealthy 🤢';
    return 'Hazardous ☠️';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('🎚️', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(
                'Try the AQI Meter!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: widget.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _color.withValues(alpha: 0.1),
              border: Border.all(color: _color, width: 4),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _aqi.round().toString(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: _color,
                    ),
                  ),
                  Text(
                    'AQI',
                    style: TextStyle(
                      fontSize: 11,
                      color: _color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _color,
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 7,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 11),
              activeTrackColor: _color,
              inactiveTrackColor: _color.withValues(alpha: 0.2),
              thumbColor: _color,
            ),
            child: Slider(
              value: _aqi,
              min: 0,
              max: 400,
              onChanged: (v) => setState(() => _aqi = v),
            ),
          ),
          const Text(
            'Drag to change AQI value',
            style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
          ),
        ],
      ),
    );
  }
}

class _BarPage extends _Page {
  final String sectionIcon, sectionTitle;
  final List<_BarItem> bars;
  final List<_Item> steps;
  final String stepsTitle, stepsIcon;

  _BarPage({
    required this.sectionIcon,
    required this.sectionTitle,
    required this.bars,
    required this.steps,
    required this.stepsTitle,
    required this.stepsIcon,
  });

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(sectionIcon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              sectionTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: bars
                .map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b.label,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF424242),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: b.value,
                                  backgroundColor: accent.withValues(
                                    alpha: 0.1,
                                  ),
                                  color: accent,
                                  minHeight: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              b.valueLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: accent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(stepsIcon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              stepsTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...steps.asMap().entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: grad),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        e.value.emoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        Text(
                          e.value.desc,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF757575),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ─── Item Models ──────────────────────────────────────────────────────────────

class _Item {
  final String emoji, title, desc;
  const _Item(this.emoji, this.title, this.desc);
}

class _GridItem {
  final String emoji, title, desc;
  const _GridItem(this.emoji, this.title, [this.desc = '']);
}

class _BarItem {
  final String label, valueLabel;
  final double value;
  const _BarItem(this.label, this.value, this.valueLabel);
}

// ─── Module Data (2 dense pages each) ────────────────────────────────────────

// ─── Module 1 Specialized Page Classes ───────────────────────────────────────

// Page 1: How Air Travels — numbered steps with connecting line
class _AirStepsPage extends _Page {
  _AirStepsPage();

  static const _steps = [
    _StepData(
      '1',
      '👃',
      'Nose or Mouth',
      'Air enters your body when you inhale — nasal hairs filter dust',
    ),
    _StepData(
      '2',
      '🌀',
      'Trachea (Windpipe)',
      'Air travels down this tube to your lungs',
    ),
    _StepData(
      '3',
      '🌿',
      'Bronchi & Bronchioles',
      'The trachea branches into two bronchi, then into smaller bronchioles',
    ),
    _StepData(
      '4',
      '🫁',
      'Lungs',
      'Air fills your lungs and reaches millions of tiny air sacs',
    ),
    _StepData(
      '5',
      '🩸',
      'Bloodstream',
      'Oxygen crosses into your blood and travels to every cell in your body!',
    ),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: grad,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            children: [
              Text('🫁', style: TextStyle(fontSize: 44)),
              SizedBox(height: 8),
              Text(
                '20,000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Breaths per day!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "That's 15–30 breaths every single minute",
                style: TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            const Text('💨', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'How Air Travels In',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Numbered steps with vertical connecting line
        ..._steps.asMap().entries.map((entry) {
          final i = entry.key;
          final step = entry.value;
          final isLast = i == _steps.length - 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: number circle + connector line
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: grad),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accent.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          step.number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 44,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accent, accent.withOpacity(0.2)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Right: card content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(step.emoji, style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: accent,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                step.desc,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF757575),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: 16),
        // Did you know
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFCC02), width: 2),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Your lungs have millions of tiny balloon-like sacs called alveoli. One alveolus is the size of a grain of sand — yet you have millions! 🫧',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _StepData {
  final String number, emoji, title, desc;
  const _StepData(this.number, this.emoji, this.title, this.desc);
}

// Page 2: Alveoli — interactive bubble grid
class _AlveoliPage extends _Page {
  _AlveoliPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🔬', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Tiny Air Sacs: Alveoli',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                'Your lungs have ',
                style: TextStyle(fontSize: 14, color: Color(0xFF37474F)),
                textAlign: TextAlign.center,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Color(0xFF37474F)),
                  children: [
                    TextSpan(
                      text: 'millions',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0288D1),
                      ),
                    ),
                    TextSpan(text: ' of tiny balloon-like sacs called '),
                    TextSpan(
                      text: 'alveoli',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0288D1),
                      ),
                    ),
                    TextSpan(
                      text: '.\nThis is where oxygen enters your blood!',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _AlveoliBubbleGrid(accent: accent, grad: grad),
              const SizedBox(height: 14),
              const Text(
                'Each bubble = one alveolus (air sac) — you have millions! 🤩',
                style: TextStyle(fontSize: 12, color: Color(0xFF546E7A)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Fun facts row
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🎾 Amazing Facts',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
              const SizedBox(height: 10),
              const _FactRow(
                '📐',
                'If spread flat, they\'d cover a tennis court!',
              ),
              const SizedBox(height: 8),
              const _FactRow('🔬', 'Visible only under a microscope'),
              const SizedBox(height: 8),
              const _FactRow('💪', 'They expand & contract with every breath'),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _AlveoliBubbleGrid extends StatefulWidget {
  final Color accent;
  final List<Color> grad;
  const _AlveoliBubbleGrid({required this.accent, required this.grad});

  @override
  State<_AlveoliBubbleGrid> createState() => _AlveoliBubbleGridState();
}

class _AlveoliBubbleGridState extends State<_AlveoliBubbleGrid> {
  final Set<int> _popped = {};

  @override
  Widget build(BuildContext context) {
    // 9 bubbles in row 1, 3 in row 2 (matching reference image)
    return Column(
      children: [
        _buildRow(List.generate(9, (i) => i)),
        const SizedBox(height: 8),
        _buildRow(List.generate(3, (i) => i + 9)),
      ],
    );
  }

  Widget _buildRow(List<int> indices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indices.map((idx) {
        final isPopped = _popped.contains(idx);
        return GestureDetector(
          onTap: () => setState(() {
            if (isPopped)
              _popped.remove(idx);
            else
              _popped.add(idx);
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.all(3),
            width: isPopped ? 26 : 32,
            height: isPopped ? 26 : 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isPopped
                    ? [const Color(0xFFE0E0E0), const Color(0xFFBDBDBD)]
                    : [const Color(0xFF4FC3F7), const Color(0xFF0288D1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: isPopped
                  ? []
                  : [
                      BoxShadow(
                        color: const Color(0xFF0288D1).withOpacity(0.4),
                        blurRadius: 4,
                      ),
                    ],
            ),
            child: Center(
              child: Text(
                isPopped ? '💨' : 'O₂',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isPopped ? 10 : 8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FactRow extends StatelessWidget {
  final String emoji, text;
  const _FactRow(this.emoji, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF546E7A),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// Page 3: The Big Swap — O₂/CO₂ reference-style
class _BigSwapPage extends _Page {
  _BigSwapPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🔁', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'The Big Swap',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Your lungs do an amazing swap inside the alveoli — every single breath!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF546E7A),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  // O₂ card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          Text('💙', style: TextStyle(fontSize: 36)),
                          SizedBox(height: 8),
                          Text(
                            'Oxygen (O₂)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Color(0xFF0288D1),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Comes IN —\ngives you energy!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF546E7A),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Swap icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const Text(
                          '⇄',
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFF0288D1),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'SWAP',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: accent,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // CO₂ card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          Text('🧡', style: TextStyle(fontSize: 36)),
                          SizedBox(height: 8),
                          Text(
                            'Carbon Dioxide (CO₂)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Color(0xFFE65100),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Goes OUT —\nwaste gas you exhale',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF546E7A),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Text('😮', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Without this swap, your body can't get enough energy",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF5D4037),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Interactive swap counter
        _SwapCounterWidget(accent: accent, grad: grad),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SwapCounterWidget extends StatefulWidget {
  final Color accent;
  final List<Color> grad;
  const _SwapCounterWidget({required this.accent, required this.grad});

  @override
  State<_SwapCounterWidget> createState() => _SwapCounterWidgetState();
}

class _SwapCounterWidgetState extends State<_SwapCounterWidget>
    with SingleTickerProviderStateMixin {
  int _taps = 0;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween(
      begin: 1.0,
      end: 1.12,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final swaps = _taps * 17000; // avg swaps per breath
    return GestureDetector(
      onTap: () {
        setState(() => _taps++);
        _ctrl.forward().then((_) => _ctrl.reverse());
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: widget.grad),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            ScaleTransition(
              scale: _scale,
              child: const Text('👆', style: TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tap to simulate a breath!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      _taps == 0
                          ? 'Each breath = ~17,000 swaps'
                          : '🫧 ${_taps} breath${_taps > 1 ? 's' : ''} = ~${swaps.toString()} swaps!',
                      key: ValueKey(_taps),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Page 4: Lung Defense System — 3-column grid
class _DefenseSystemPage extends _Page {
  _DefenseSystemPage();

  static const _defenders = [
    _DefenderData(
      '🐍',
      'Cilia',
      'Tiny hair-like structures that trap dust and germs',
      Color(0xFFC8E6C9),
    ),
    _DefenderData(
      '💧',
      'Mucus',
      'Sticky liquid that catches harmful particles',
      Color(0xFFB3E5FC),
    ),
    _DefenderData(
      '🤧',
      'Coughing',
      'Removes trapped dust and germs out of your body',
      Color(0xFFFFF9C4),
    ),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🛡️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Your Lung Defense System',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your lungs also protect you from harmful things in the air!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: _defenders
                    .map(
                      (d) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: _DefenderCard(defender: d),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // How they work together
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '💪 How They Work Together',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
              const SizedBox(height: 12),
              const _FactRow('1️⃣', 'Mucus traps dust, pollen & germs'),
              const SizedBox(height: 8),
              const _FactRow('2️⃣', 'Cilia sweep mucus up towards the throat'),
              const SizedBox(height: 8),
              const _FactRow(
                '3️⃣',
                'Coughing or swallowing removes the nasty stuff!',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Did you know
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFCC02), width: 2),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Your lungs produce about 1 litre of mucus every day to protect you. Good thing you swallow most of it without noticing! 😅',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _DefenderData {
  final String emoji, title, desc;
  final Color bgColor;
  const _DefenderData(this.emoji, this.title, this.desc, this.bgColor);
}

class _DefenderCard extends StatefulWidget {
  final _DefenderData defender;
  const _DefenderCard({required this.defender});

  @override
  State<_DefenderCard> createState() => _DefenderCardState();
}

class _DefenderCardState extends State<_DefenderCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
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
    final d = widget.defender;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        setState(() => _expanded = !_expanded);
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: _expanded
                ? [
                    BoxShadow(
                      color: const Color(0xFF2E7D32).withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                    ),
                  ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: d.bgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(d.emoji, style: const TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                d.title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2E7D32),
                ),
                textAlign: TextAlign.center,
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    d.desc,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF546E7A),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Module 1 Content ─────────────────────────────────────────────────────────

_ModuleContent _module1() => _ModuleContent(
  title: 'Know Your Lungs',
  accent: const Color(0xFF0288D1),
  gradColors: const [Color(0xFF4FC3F7), Color(0xFF0288D1)],
  pages: [
    _AirStepsPage(),
    _AlveoliPage(),
    _BigSwapPage(),
    _DefenseSystemPage(),
  ],
);

// ─── Module 2 Specialized Page Classes ───────────────────────────────────────

// Page 1: PM2.5 hero + Where Does It Come From 2x2 grid
class _Pm25Page extends _Page {
  _Pm25Page();

  static const _sources = [
    _SourceData(
      '🚗',
      'Vehicles',
      'Car & truck exhaust releases harmful gases and particles',
    ),
    _SourceData(
      '🏭',
      'Factories',
      'Industrial smoke contains chemicals and tiny particles',
    ),
    _SourceData(
      '🔥',
      'Burning Waste',
      'Burning garbage releases toxic fumes into the air',
    ),
    _SourceData(
      '🧱',
      'Construction Dust',
      'Cement and dust clouds carry harmful fine particles',
    ),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PM2.5 dark hero card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF2D3748),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'PM2.5',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const Text(
                    '🏭',
                    style: TextStyle(fontSize: 36, color: Colors.white38),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'The Invisible Danger 😲',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Color(0xFFCBD5E0),
                    fontSize: 13,
                    height: 1.6,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'These are ultra-tiny pollution particles that you ',
                    ),
                    TextSpan(
                      text: 'cannot see or smell',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' — yet they travel deep into your lungs and even into your blood!',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'Hair',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'A single human hair is ',
                        style: TextStyle(
                          color: Color(0xFFCBD5E0),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color(0xFFCBD5E0),
                      fontSize: 12,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '30× bigger',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text:
                            " than a PM2.5 particle. That's how tiny — and how sneaky — it is.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        // Where does it come from section title
        Row(
          children: [
            const Text('🌫️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Where Does It Come From?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // 2x2 source grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.05,
          children: _sources
              .map((s) => _SourceCard(source: s, accent: accent))
              .toList(),
        ),
        const SizedBox(height: 16),
        // India fact banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFCC02), width: 2),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "India has some of the world's highest AQI readings — especially in winter. Always check AQI before stepping out! 🌬️",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SourceData {
  final String emoji, title, desc;
  const _SourceData(this.emoji, this.title, this.desc);
}

class _SourceCard extends StatefulWidget {
  final _SourceData source;
  final Color accent;
  const _SourceCard({required this.source, required this.accent});

  @override
  State<_SourceCard> createState() => _SourceCardState();
}

class _SourceCardState extends State<_SourceCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.source;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _pressed ? widget.accent : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _pressed
                  ? widget.accent.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              blurRadius: _pressed ? 12 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.emoji, style: const TextStyle(fontSize: 34)),
            const SizedBox(height: 8),
            Text(
              s.title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              s.desc,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF718096),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Page 2: Danger At Home Too
class _DangerAtHomePage extends _Page {
  _DangerAtHomePage();

  static const _items = [
    _HomeHazardData(
      '🍳',
      'Cooking Smoke',
      'Burning wood, coal, or kerosene for cooking fills the air with fine particles',
    ),
    _HomeHazardData(
      '🪔',
      'Incense Sticks & Coils',
      'Burning incense and mosquito coils release smoke that harms your airways',
    ),
    _HomeHazardData(
      '🪟',
      'Poor Ventilation',
      'Closed rooms trap pollutants inside — open windows whenever you can!',
    ),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            const Text('🏠', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Danger At Home Too!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8EC),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFFE0B2)),
          ),
          child: Column(
            children: [
              // Warning banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9C4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('⚠️', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Indoor air can be even more polluted than outside! Many everyday things at home release harmful smoke.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5D4037),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // Hazard list items
              ..._items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(item.emoji, style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: accent,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.desc,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF718096),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Did you know
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFCC02), width: 2),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Simply opening your windows for 10 minutes can significantly reduce indoor pollution levels. Fresh air is free medicine! 🪟',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _HomeHazardData {
  final String emoji, title, desc;
  const _HomeHazardData(this.emoji, this.title, this.desc);
}

// Page 3: Allergens that trigger breathing problems
class _AllergensPage extends _Page {
  _AllergensPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🤧', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Allergens That Trigger Breathing Problems',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E8FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFD8B4FE)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'These invisible triggers can cause your airways to swell up and make breathing difficult — especially if you have asthma.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B21A8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              // 3-column allergen cards
              Row(
                children: [
                  _AllergenCard(
                    emoji: '🌿',
                    title: 'Dust',
                    desc: 'Tiny particles from surfaces that float in the air',
                  ),
                  const SizedBox(width: 8),
                  _AllergenCard(
                    emoji: '🌸',
                    title: 'Pollen',
                    desc: 'From plants and flowers — especially in spring',
                  ),
                  const SizedBox(width: 8),
                  _AllergenCard(
                    emoji: '🐾',
                    title: 'Pet Dander',
                    desc: "Tiny flakes from animals' skin and fur",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Airway comparison
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF38BDF8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '✅ Healthy Airway',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0369A1),
                                ),
                              ),
                              const Text(
                                'Wide — easy to breathe!',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF0369A1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'VS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFCA5A5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEF4444),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '❌ Inflamed Airway',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFB91C1C),
                                ),
                              ),
                              const Text(
                                'Swollen — hard to breathe!',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFB91C1C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _AllergenCard extends StatelessWidget {
  final String emoji, title, desc;
  const _AllergenCard({
    required this.emoji,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 5),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7C3AED),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF718096),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Page 4: How to Protect Yourself
class _ProtectYourselfPage extends _Page {
  _ProtectYourselfPage();

  static const _steps = [
    _ProtectStep(
      '😷',
      'Wear a mask outdoors',
      'Especially near traffic, construction sites, or on polluted days',
    ),
    _ProtectStep(
      '🪟',
      'Open windows at home',
      'Fresh air circulation reduces indoor pollutants quickly',
    ),
    _ProtectStep(
      '🚶',
      'Avoid smoky and dusty areas',
      'Choose cleaner routes to school or play areas with trees',
    ),
    _ProtectStep(
      '🌱',
      'Keep your home clean',
      'Sweep and dust regularly to reduce allergen build-up',
    ),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🛡️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'How to Protect Yourself',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // Green checklist card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFA7F3D0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('✅', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 8),
                  Text(
                    'Simple Steps to Stay Safe',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ..._steps.map(
                (step) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ProtectStepCard(step: step),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Surprising But True — yellow card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF08A),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('⚠️', style: TextStyle(fontSize: 26)),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Surprising But True!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF713F12),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Even on days when the sky looks clear and blue, air pollution can still be at dangerous levels. You can't always trust your eyes — but you can take simple steps to protect yourself every day.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF854D0E),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ProtectStep {
  final String emoji, title, desc;
  const _ProtectStep(this.emoji, this.title, this.desc);
}

class _ProtectStepCard extends StatelessWidget {
  final _ProtectStep step;
  const _ProtectStepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Text(step.emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF065F46),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  step.desc,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
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

// ─── Module 2 Content ─────────────────────────────────────────────────────────

_ModuleContent _module2() => _ModuleContent(
  title: 'What Harms Your Lungs',
  accent: const Color(0xFFE64A19),
  gradColors: const [Color(0xFFFF7043), Color(0xFFBF360C)],
  pages: [
    _Pm25Page(),
    _DangerAtHomePage(),
    _AllergensPage(),
    _ProtectYourselfPage(),
  ],
);

// ─── Module 3 Specialized Page Classes ───────────────────────────────────────

// Page 1: Move Your Body + Exercise Bar Chart
class _MoveYourBodyPage extends _Page {
  _MoveYourBodyPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Move Your Body hero card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: grad,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Move Your Body, Strengthen Your Lungs! 💪',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Exercise makes your lungs work harder — and that makes them stronger over time. Any movement counts!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ExerciseChip('🚶', 'Walking'),
                  _ExerciseChip('🏃', 'Running'),
                  _ExerciseChip('🚴', 'Cycling'),
                  _ExerciseChip('⚽', 'Sports'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        // Exercise bar chart section
        Row(
          children: [
            const Text('📈', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Exercise Builds Lung Power',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How exercise improves your lungs over time:',
                style: TextStyle(
                  fontSize: 12,
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              _AnimatedBar(
                label: 'Oxygen Supply',
                value: 0.95,
                display: '+95%',
                color: accent,
                delay: 0,
              ),
              const SizedBox(height: 10),
              _AnimatedBar(
                label: 'Breathing Efficiency',
                value: 0.78,
                display: '+78%',
                color: const Color(0xFF43A047),
                delay: 200,
              ),
              const SizedBox(height: 10),
              _AnimatedBar(
                label: 'Energy Levels',
                value: 0.62,
                display: '+62%',
                color: const Color(0xFF66BB6A),
                delay: 400,
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Text('🌟', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Even 20–30 minutes of activity a day makes a big difference! 🎉',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF2E7D32),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ExerciseChip extends StatelessWidget {
  final String emoji, label;
  const _ExerciseChip(this.emoji, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 26)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _AnimatedBar extends StatefulWidget {
  final String label, display;
  final double value;
  final Color color;
  final int delay;
  const _AnimatedBar({
    required this.label,
    required this.value,
    required this.display,
    required this.color,
    required this.delay,
  });

  @override
  State<_AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<_AnimatedBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _anim = Tween(
      begin: 0.0,
      end: widget.value,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.display,
              style: TextStyle(
                fontSize: 12,
                color: widget.color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: _anim.value,
              backgroundColor: const Color(0xFFE5E7EB),
              color: widget.color,
              minHeight: 10,
            ),
          ),
        ),
      ],
    );
  }
}

// Page 2: Breathing Exercises
class _BreathingExPage extends _Page {
  _BreathingExPage();

  static const _steps = [
    _BrStep(
      '1',
      'Breathe In Slowly 🌬️',
      'Inhale through your nose for 4 seconds — feel your belly rise',
    ),
    _BrStep('2', 'Hold It 🤫', 'Hold your breath gently for 2 seconds'),
    _BrStep(
      '3',
      'Breathe Out Slowly 💨',
      'Exhale through your mouth for 6 seconds — slowly and fully',
    ),
    _BrStep(
      '4',
      'Repeat 5–10 Times 🔁',
      'Do this every morning for stronger, healthier lungs!',
    ),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🧘', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Breathing Exercises',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "You can make your lungs stronger without even going outside! Try this simple deep breathing exercise:",
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        // Numbered steps
        ..._steps.asMap().entries.map((e) {
          final i = e.key;
          final step = e.value;
          final isLast = i == _steps.length - 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: grad),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          step.number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 38,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        color: accent.withOpacity(0.25),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: accent,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          step.desc,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: 18),
        // Types of breathing exercise
        Row(
          children: [
            _BrTypeCard(
              '🧘',
              'Yoga',
              'Opens up your chest and diaphragm, as flow',
              accent,
            ),
            const SizedBox(width: 10),
            _BrTypeCard(
              '🌀',
              'Pranayama',
              'Breathing techniques to build lung capacity',
              accent,
            ),
            const SizedBox(width: 10),
            _BrTypeCard(
              '🌳',
              'Outdoors',
              'Fresh air outdoors is the best combo!',
              accent,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _BrStep {
  final String number, title, desc;
  const _BrStep(this.number, this.title, this.desc);
}

class _BrTypeCard extends StatelessWidget {
  final String emoji, title, desc;
  final Color accent;
  const _BrTypeCard(this.emoji, this.title, this.desc, this.accent);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 5),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 3),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF9CA3AF),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Page 3: Protect Yourself on Bad Air Days
class _BadAirPage extends _Page {
  _BadAirPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🌡️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Protect Yourself on Bad Air Days',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Check the air quality before going outside and adjust your day!',
          style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4),
        ),
        const SizedBox(height: 14),
        // AQI summary cards
        Row(
          children: [
            _AqiSummaryCard(
              '😊',
              'Good Day',
              'Go outside!',
              const Color(0xFFECFDF5),
              const Color(0xFF065F46),
            ),
            const SizedBox(width: 8),
            _AqiSummaryCard(
              '😐',
              'Moderate',
              'Be cautious',
              const Color(0xFFFFFBEB),
              const Color(0xFF78350F),
            ),
            const SizedBox(width: 8),
            _AqiSummaryCard(
              '😷',
              'Unhealthy',
              'Stay indoors!',
              const Color(0xFFFEF2F2),
              const Color(0xFF991B1B),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Tips
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFA7F3D0)),
          ),
          child: Column(
            children: [
              _BadAirTip(
                '😷',
                'Wear a mask on polluted days',
                'Wearing an N95 mask near traffic or construction',
              ),
              const SizedBox(height: 10),
              _BadAirTip(
                '🪟',
                'Stay indoors with windows open',
                'Air circulation helps even on bad air days',
              ),
              const SizedBox(height: 10),
              _BadAirTip(
                '🌀',
                'Use an air purifier, if available',
                'Device removes harmful indoor particles',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFFCC02), width: 2),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Download a free AQI app to check air quality every morning — before you step out!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _AqiSummaryCard extends StatelessWidget {
  final String emoji, title, sub;
  final Color bg, textColor;
  const _AqiSummaryCard(
    this.emoji,
    this.title,
    this.sub,
    this.bg,
    this.textColor,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              sub,
              style: TextStyle(fontSize: 10, color: textColor.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _BadAirTip extends StatelessWidget {
  final String emoji, title, desc;
  const _BadAirTip(this.emoji, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF065F46),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                    height: 1.3,
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

// Page 4: Eat & Drink for Healthy Lungs
class _EatDrinkPage extends _Page {
  _EatDrinkPage();

  static const _foods = [
    _FoodData(
      '🍊',
      'Citrus Fruits',
      'Rich in Vitamin C — reduces lung inflammation',
    ),
    _FoodData(
      '🥦',
      'Green Vegetables',
      'Antioxidants that protect lung tissue',
    ),
    _FoodData('🫐', 'Berries', 'Fight inflammation and oxidative stress'),
    _FoodData('🥕', 'Carrots & Beets', 'Improve oxygen use in the body'),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🥗', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Eat & Drink for Healthy Lungs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'What you eat and drink directly affects your lung health. These foods are lung superfoods 🦸',
          style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4),
        ),
        const SizedBox(height: 14),
        // 2x2 food grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.1,
          children: _foods
              .map((f) => _FoodCard(food: f, accent: accent))
              .toList(),
        ),
        const SizedBox(height: 18),
        // Stay Hydrated section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '💧 Stay Hydrated — Every Drop Counts!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E40AF),
                ),
              ),
              const SizedBox(height: 10),
              // Water drop row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  8,
                  (i) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text('💧', style: TextStyle(fontSize: 22)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  '= 8 glasses a day keeps your airways moist & clear',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF3B82F6),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFFCC02), width: 2),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Singing and playing wind instruments like a flute or harmonica are great lung exercises! They strengthen your diaphragm and improve breath control 🎵",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _FoodData {
  final String emoji, title, desc;
  const _FoodData(this.emoji, this.title, this.desc);
}

class _FoodCard extends StatelessWidget {
  final _FoodData food;
  final Color accent;
  const _FoodCard({required this.food, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(food.emoji, style: const TextStyle(fontSize: 34)),
          const SizedBox(height: 6),
          Text(
            food.title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            food.desc,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF9CA3AF),
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Page 5: Daily Health Checklist
class _DailyChecklistPage extends _Page {
  _DailyChecklistPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('✅', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Your Daily Lung Health Checklist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _ChecklistWidget(accent: accent),
        const SizedBox(height: 18),
        // Power Fact yellow card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF08A),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('⚡', style: TextStyle(fontSize: 26)),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Power Fact!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF713F12),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Singing and playing wind instruments like a flute or harmonica are also great lung exercises! They train you to control your breath and strengthen your diaphragm 🎵",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF854D0E),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ChecklistWidget extends StatefulWidget {
  final Color accent;
  const _ChecklistWidget({required this.accent});

  @override
  State<_ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<_ChecklistWidget> {
  static const _items = [
    _CheckItem('🏃', 'Did 20+ minutes of physical activity'),
    _CheckItem('🧘', 'Did my breathing exercises today'),
    _CheckItem('💧', 'Drank 8 glasses of water'),
    _CheckItem('🍎', 'Ate fruits or vegetables today'),
    _CheckItem('🪟', 'Opened windows for fresh air'),
    _CheckItem('😷', 'Wore a mask in a polluted area'),
  ];

  final Set<int> _checked = {};

  @override
  Widget build(BuildContext context) {
    final total = _items.length;
    final done = _checked.length;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '⭐ Tap to check off your healthy habits!',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: widget.accent,
                ),
              ),
              Text(
                '$done / $total',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: widget.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: total > 0 ? done / total : 0,
              backgroundColor: Colors.white,
              color: widget.accent,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 14),
          ..._items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            final checked = _checked.contains(i);
            return GestureDetector(
              onTap: () => setState(() {
                if (checked)
                  _checked.remove(i);
                else
                  _checked.add(i);
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: checked
                      ? widget.accent.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: checked ? widget.accent : Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: checked ? widget.accent : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: checked
                              ? widget.accent
                              : const Color(0xFFD1D5DB),
                          width: 2,
                        ),
                      ),
                      child: checked
                          ? const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(item.emoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: checked
                              ? widget.accent
                              : const Color(0xFF374151),
                          decoration: checked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          if (_checked.length == _items.length)
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.accent.withOpacity(0.8), widget.accent],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🎉', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 8),
                  Text(
                    'Amazing! You completed all habits today!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
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

class _CheckItem {
  final String emoji, label;
  const _CheckItem(this.emoji, this.label);
}

// ─── Module 3 Content ─────────────────────────────────────────────────────────

_ModuleContent _module3() => _ModuleContent(
  title: 'Keep Your Lungs Healthy',
  accent: const Color(0xFF388E3C),
  gradColors: const [Color(0xFF66BB6A), Color(0xFF2E7D32)],
  pages: [
    _MoveYourBodyPage(),
    _BreathingExPage(),
    _BadAirPage(),
    _EatDrinkPage(),
    _DailyChecklistPage(),
  ],
);

// ─── Module 4 Specialized Page Classes ───────────────────────────────────────

// Page 1: What is the AQI?
class _WhatIsAqiPage extends _Page {
  _WhatIsAqiPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: grad,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🌍', style: TextStyle(fontSize: 44)),
              SizedBox(height: 10),
              Text(
                'What is the AQI?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'The Air Quality Index (AQI) is like a daily health report for the air around you. Governments measure the air every day and give it a score — so you know when it\'s safe to go outside!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        // AQI scale bar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0 = Perfect',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF388E3C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '500 = Dangerous',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7B1FA2),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 18,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF4CAF50), // Good
                        Color(0xFFFFEB3B), // Moderate
                        Color(0xFFFF9800), // Unhealthy for Sensitive
                        Color(0xFFF44336), // Unhealthy
                        Color(0xFF9C27B0), // Very Unhealthy
                        Color(0xFF7B1FA2), // Hazardous
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good',
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Moderate',
                    style: TextStyle(fontSize: 9, color: Color(0xFFF9A825)),
                  ),
                  Text(
                    'Unhealthy',
                    style: TextStyle(fontSize: 9, color: Color(0xFFF44336)),
                  ),
                  Text(
                    'Hazardous',
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF7B1FA2),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFCC02), width: 2),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💡', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Think of the AQI like a thermometer for air pollution — the higher the number, the more dangerous the air is to breathe!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Page 2: Try the AQI Meter — interactive slider + gauge
class _AqiMeterPage extends _Page {
  _AqiMeterPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🎛️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Try the AQI Meter!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Slide to explore different AQI levels',
          style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
        const SizedBox(height: 16),
        _InteractiveAqiMeter(accent: accent),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _InteractiveAqiMeter extends StatefulWidget {
  final Color accent;
  const _InteractiveAqiMeter({required this.accent});

  @override
  State<_InteractiveAqiMeter> createState() => _InteractiveAqiMeterState();
}

class _InteractiveAqiMeterState extends State<_InteractiveAqiMeter> {
  double _aqi = 25;

  static const _levels = [
    _AqiLevel(
      0,
      50,
      '😊',
      'Good',
      Color(0xFF4CAF50),
      'Air is clean and safe. Great day to go outside! 🌞',
    ),
    _AqiLevel(
      51,
      100,
      '😐',
      'Moderate',
      Color(0xFFF9A825),
      'Air is acceptable. Sensitive people take care.',
    ),
    _AqiLevel(
      101,
      150,
      '😷',
      'Unhealthy for Sensitive Groups',
      Color(0xFFFF7043),
      'Children & elderly should limit time outdoors.',
    ),
    _AqiLevel(
      151,
      200,
      '🥵',
      'Unhealthy',
      Color(0xFFF44336),
      'Everyone may experience health effects. Wear a mask!',
    ),
    _AqiLevel(
      201,
      300,
      '⚠️',
      'Very Unhealthy',
      Color(0xFF9C27B0),
      'Serious health risk. Stay indoors if possible.',
    ),
    _AqiLevel(
      301,
      500,
      '☠️',
      'Hazardous',
      Color(0xFF7B1FA2),
      'Emergency conditions! Everyone should avoid going out.',
    ),
  ];

  _AqiLevel get _currentLevel {
    for (final l in _levels) {
      if (_aqi <= l.max) return l;
    }
    return _levels.last;
  }

  @override
  Widget build(BuildContext context) {
    final lvl = _currentLevel;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12),
        ],
      ),
      child: Column(
        children: [
          // Gauge arc (simulated semicircle using CustomPaint)
          SizedBox(
            height: 150,
            child: CustomPaint(
              painter: _GaugePainter(aqi: _aqi, color: lvl.color),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _aqi.round().toString(),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: lvl.color,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: lvl.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(lvl.emoji, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            lvl.label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: lvl.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            lvl.desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: lvl.color,
              activeTrackColor: lvl.color,
              inactiveTrackColor: const Color(0xFFE5E7EB),
              overlayColor: lvl.color.withOpacity(0.15),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              trackHeight: 8,
            ),
            child: Slider(
              value: _aqi,
              min: 0,
              max: 500,
              onChanged: (v) => setState(() => _aqi = v),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0\nGood',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '500\nHazardous',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF7B1FA2),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Drag to change AQI value',
            style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}

class _AqiLevel {
  final int min, max;
  final String emoji, label, desc;
  final Color color;
  const _AqiLevel(
    this.min,
    this.max,
    this.emoji,
    this.label,
    this.color,
    this.desc,
  );
}

class _GaugePainter extends CustomPainter {
  final double aqi;
  final Color color;
  const _GaugePainter({required this.aqi, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 10);
    final radius = size.width * 0.42;
    const startAngle = 3.14159; // π (left)
    const sweepAngle = 3.14159; // π (full semicircle)
    final fraction = (aqi / 500).clamp(0.0, 1.0);

    // Background arc
    final bgPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Gradient arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final shader = const SweepGradient(
      startAngle: 3.14159,
      endAngle: 3.14159 * 2,
      colors: [
        Color(0xFF4CAF50),
        Color(0xFFFFEB3B),
        Color(0xFFFF9800),
        Color(0xFFF44336),
        Color(0xFF9C27B0),
        Color(0xFF7B1FA2),
      ],
    ).createShader(rect);

    final fgPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, sweepAngle * fraction, false, fgPaint);

    // Needle
    final needleAngle = 3.14159 + (3.14159 * fraction);
    final needleEnd = Offset(
      center.dx + (radius * 0.75) * math.cos(needleAngle),
      center.dy + (radius * 0.75) * math.sin(needleAngle),
    );
    final needlePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, needleEnd, needlePaint);
    canvas.drawCircle(center, 6, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.aqi != aqi || old.color != color;
}

// Page 3: The 6 AQI Levels
class _AqiLevelsPage extends _Page {
  _AqiLevelsPage();

  static const _list = [
    _AqiLevelRow(
      '😊',
      '0–50',
      'Good',
      Color(0xFF4CAF50),
      'SAFE',
      'Air quality is satisfactory. Go outside and enjoy! 🌞',
      Color(0xFF4CAF50),
    ),
    _AqiLevelRow(
      '😐',
      '51–100',
      'Moderate',
      Color(0xFFF9A825),
      'CAUTION',
      'Acceptable for most people. Sensitive individuals should take care.',
      Color(0xFFF9A825),
    ),
    _AqiLevelRow(
      '😷',
      '101–150',
      'Unhealthy for Sensitive Groups',
      Color(0xFFFF7043),
      'LIMIT',
      'Children, elderly & people with AQI 200+ should limit outdoor time.',
      Color(0xFFFF7043),
    ),
    _AqiLevelRow(
      '🥵',
      '151–200',
      'Unhealthy',
      Color(0xFFF44336),
      'AVOID',
      'Everyone may begin to experience health effects. Wear a mask & go indoors.',
      Color(0xFFF44336),
    ),
    _AqiLevelRow(
      '⚠️',
      '201–300',
      'Very Unhealthy',
      Color(0xFF9C27B0),
      'STAY IN',
      'Increased risk for everyone. Outdoor activities can be dangerous.',
      Color(0xFF9C27B0),
    ),
    _AqiLevelRow(
      '☠️',
      '301–500',
      'Hazardous',
      Color(0xFF7B1FA2),
      'DANGER',
      'Emergency conditions — serious health effects for everyone. Avoid going outside.',
      Color(0xFF7B1FA2),
    ),
  ];

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🏷️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'The 6 AQI Levels',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ..._list.map(
          (l) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _AqiLevelCard(level: l),
          ),
        ),
      ],
    );
  }
}

class _AqiLevelRow {
  final String emoji, range, label, badge, desc;
  final Color color, badgeColor;
  const _AqiLevelRow(
    this.emoji,
    this.range,
    this.label,
    this.color,
    this.badge,
    this.desc,
    this.badgeColor,
  );
}

class _AqiLevelCard extends StatelessWidget {
  final _AqiLevelRow level;
  const _AqiLevelCard({required this.level});

  @override
  Widget build(BuildContext context) {
    final l = level;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: l.color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: l.color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Text(l.emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      l.range,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: l.color,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        l.label,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  l.desc,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6B7280),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: l.badgeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l.badge,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Page 4: Who Is Most at Risk + How to Check AQI
class _AqiRiskCheckPage extends _Page {
  _AqiRiskCheckPage();

  @override
  Widget build(BuildContext ctx, Color accent, List<Color> grad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Who is most at risk
        Row(
          children: [
            const Text('⚠️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Who Is Most at Risk?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'When AQI is above 100, these groups need to be extra careful — even before the general public feels the effects.',
          style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _RiskCard(
              '👶',
              'Children',
              'Lungs are still growing and developing — most vulnerable',
            ),
            const SizedBox(width: 8),
            _RiskCard(
              '👴',
              'Elderly',
              'Weaker immune & lung defense systems make recovery harder',
            ),
            const SizedBox(width: 8),
            _RiskCard(
              '🫁',
              'Asthma Patients',
              'Sensitive airways react strongly to pollution triggers',
            ),
          ],
        ),
        const SizedBox(height: 22),
        // How to Check
        Row(
          children: [
            const Text('📱', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'How to Check the AQI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3 Easy Ways to Know Today\'s Air Quality',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
              const SizedBox(height: 14),
              _CheckAqiTip(
                icon: '📱',
                title: 'Use a free AQI app on your phone',
                desc: 'Search "AQI India" or "Air Visual" — free to download',
                bg: const Color(0xFFEFF6FF),
              ),
              const SizedBox(height: 10),
              _CheckAqiTip(
                icon: '🌐',
                title: 'Visit an AQI website',
                desc: 'Sites like iqair.com show live local readings',
                bg: const Color(0xFFECFDF5),
              ),
              const SizedBox(height: 10),
              _CheckAqiTip(
                icon: '📻',
                title: 'Listen to local weather reports',
                desc: 'Many news channels share air quality updates',
                bg: const Color(0xFFFFF8E1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Did you know
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E8FF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFD8B4FE)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🌍', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    'Did You Know?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'India has some of the world\'s highest AQI readings — especially in winter. Cities close to the glaciers. Checking the AQI before stepping out could be one of the most important habits before you go out! 🌬️',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B21A8),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _RiskCard extends StatelessWidget {
  final String emoji, title, desc;
  const _RiskCard(this.emoji, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 5),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF374151),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF9CA3AF),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckAqiTip extends StatelessWidget {
  final String icon, title, desc;
  final Color bg;
  const _CheckAqiTip({
    required this.icon,
    required this.title,
    required this.desc,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6B7280),
                    height: 1.3,
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

// ─── Module 4 Content ─────────────────────────────────────────────────────────

_ModuleContent _module4() => _ModuleContent(
  title: 'Air Quality Awareness',
  accent: const Color(0xFF7B1FA2),
  gradColors: const [Color(0xFFAB47BC), Color(0xFF6A1B9A)],
  pages: [
    _WhatIsAqiPage(),
    _AqiMeterPage(),
    _AqiLevelsPage(),
    _AqiRiskCheckPage(),
  ],
);
