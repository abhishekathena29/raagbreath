import 'package:flutter/material.dart';

// ─── Main Learn Screen ────────────────────────────────────────────────────────

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          // Custom header with explicit back button (white) so it's visible
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF283593),
                  Color(0xFF3949AB),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 20, 20),
                child: Row(
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
                              color: Colors.white60,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            'Lung Health Academy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '4 modules · ~34 min total',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
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
          // Module list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              itemCount: _modules.length,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _ModuleCard(
                  info: _modules[i],
                  onTap: () => Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (_) =>
                          ModuleDetailScreen(moduleIndex: _modules[i].index),
                    ),
                  ),
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    final total = content.pages.length;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
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

_ModuleContent _module1() => _ModuleContent(
  title: 'Know Your Lungs',
  accent: const Color(0xFF0288D1),
  gradColors: const [Color(0xFF4FC3F7), Color(0xFF0288D1)],
  pages: [
    _RichPage(
      heroEmoji: '🫁',
      heroStat: '20,000',
      heroLabel: 'Breaths per day!',
      heroSub: "That's 15–30 breaths every single minute",
      sectionIcon: '💨',
      sectionTitle: 'How Air Travels In',
      items: const [
        _Item('👃', 'Nose or Mouth', 'Air enters your body when you inhale'),
        _Item(
          '🌀',
          'Windpipe (Trachea)',
          'Air travels down this tube to your lungs',
        ),
        _Item(
          '🫁',
          'Lungs',
          'Air fills your lungs and reaches the tiny air sacs',
        ),
        _Item(
          '🩸',
          'Bloodstream',
          'Oxygen enters your blood and travels to every cell!',
        ),
      ],
      didYouKnow:
          "Your lungs have millions of tiny balloon-like sacs called alveoli. One alveolus is the size of a grain of sand — yet you have millions! 🫧",
    ),
    _GridPage(
      sectionIcon: '🔄',
      sectionTitle: 'Alveoli & The Big Swap',
      items: const [
        _GridItem('🫧', 'Alveoli', 'Millions of tiny air sacs'),
        _GridItem('🩸', 'Gas Exchange', 'O₂ in → CO₂ out'),
        _GridItem('🔬', 'Microscopic', 'Visible only under magnification'),
        _GridItem('💪', 'Elastic', 'Expand & contract every breath'),
      ],
      swapLeftEmoji: '🟦',
      swapLeftTitle: 'Oxygen (O₂)',
      swapLeftDesc: 'Comes IN — gives you energy!',
      swapRightEmoji: '🟧',
      swapRightTitle: 'Carbon Dioxide (CO₂)',
      swapRightDesc: 'Goes OUT — waste gas you exhale',
      swapCaption:
          'Your lungs do this swap millions of times every day. Without it, your body can\'t produce energy.',
      didYouKnow:
          "If the alveoli in your lungs were spread flat, they'd cover the size of a tennis court! That's how much surface area they hold. 🎾",
    ),
  ],
);

_ModuleContent _module2() => _ModuleContent(
  title: 'What Harms Your Lungs',
  accent: const Color(0xFFE64A19),
  gradColors: const [Color(0xFFFF7043), Color(0xFFBF360C)],
  pages: [
    _RichPage(
      heroEmoji: '☁️',
      heroStat: 'PM2.5',
      heroLabel: 'The Invisible Danger',
      heroSub: '30× thinner than human hair — enters your bloodstream',
      sectionIcon: '🌫️',
      sectionTitle: 'Sources of Pollution',
      items: const [
        _Item('🚗', 'Vehicles', 'Cars & trucks release harmful exhaust gases'),
        _Item('🏭', 'Factories', 'Industrial smoke with toxic chemicals'),
        _Item(
          '🔥',
          'Burning Waste',
          'Releases toxic fumes and fine particles into the air',
        ),
        _Item(
          '🏗️',
          'Construction Dust',
          'Dust and debris carry harmful particles',
        ),
      ],
      didYouKnow:
          "India has some of the world's highest AQI readings — especially in winter. Always check the AQI before stepping out! 🌬️",
    ),
    _RichPage(
      heroEmoji: '🏠',
      heroStat: '5×',
      heroLabel: 'Indoor air can be more polluted than outdoor!',
      heroSub: 'Everyday things at home release harmful smoke',
      sectionIcon: '⚠️',
      sectionTitle: 'Danger At Home Too!',
      items: const [
        _Item(
          '🍳',
          'Cooking Smoke',
          'Burning wood, coal or kerosene fills air with fine particles',
        ),
        _Item(
          '🪔',
          'Incense & Coils',
          'Burning incense & mosquito coils release harmful smoke',
        ),
        _Item(
          '🌬️',
          'Poor Ventilation',
          'Closed rooms trap pollutants — open windows whenever you can',
        ),
        _Item(
          '🤧',
          'Allergens',
          'Dust, pollen, pet dander trigger breathing problems',
        ),
      ],
      didYouKnow:
          "Even on a clear day, indoor air can contain more pollutants than outdoor air. Simply opening windows for 10 minutes helps a lot! 🪟",
    ),
  ],
);

_ModuleContent _module3() => _ModuleContent(
  title: 'Keep Your Lungs Healthy',
  accent: const Color(0xFF388E3C),
  gradColors: const [Color(0xFF66BB6A), Color(0xFF2E7D32)],
  pages: [
    _BarPage(
      sectionIcon: '🏃',
      sectionTitle: 'Exercise Builds Lung Power',
      bars: const [
        _BarItem('Oxygen Supply', 0.95, '+95%'),
        _BarItem('Breathing Efficiency', 0.78, '+78%'),
        _BarItem('Energy Levels', 0.62, '+62%'),
      ],
      stepsIcon: '🧘',
      stepsTitle: 'Breathing Exercise',
      steps: const [
        _Item(
          '1️⃣',
          'Breathe In Slowly 🌬️',
          'Inhale through nose for 4 seconds — feel your belly rise',
        ),
        _Item('2️⃣', 'Hold It 🤫', 'Hold your breath gently for 2 seconds'),
        _Item(
          '3️⃣',
          'Breathe Out Slowly 💨',
          'Exhale through mouth for 6 seconds — slowly and fully',
        ),
        _Item(
          '4️⃣',
          'Repeat 5–10 Times 🔁',
          'Do this every morning for stronger, healthier lungs!',
        ),
      ],
    ),
    _GridPage(
      sectionIcon: '🥗',
      sectionTitle: 'Eat & Drink for Healthy Lungs',
      items: const [
        _GridItem('🍊', 'Citrus Fruits', 'Rich in Vitamin C'),
        _GridItem('🥦', 'Green Vegetables', 'Antioxidants protect lungs'),
        _GridItem('🫐', 'Berries', 'Fight inflammation'),
        _GridItem('🥕', 'Carrots & Beets', 'Improve oxygen use'),
      ],
      didYouKnow:
          "Singing and playing wind instruments like a flute or harmonica are great lung exercises! They strengthen your diaphragm and improve breath control 🎵",
    ),
  ],
);

_ModuleContent _module4() => _ModuleContent(
  title: 'Air Quality Awareness',
  accent: const Color(0xFF7B1FA2),
  gradColors: const [Color(0xFFAB47BC), Color(0xFF6A1B9A)],
  pages: [
    _RichPage(
      heroEmoji: '🌍',
      heroStat: 'AQI',
      heroLabel: "Your Air's Daily Health Report",
      heroSub: 'The Air Quality Index tells you how safe the air is to breathe',
      sectionIcon: '⚠️',
      sectionTitle: 'Who Is Most at Risk?',
      items: const [
        _Item(
          '👶',
          'Children',
          'Lungs still growing and developing — most vulnerable',
        ),
        _Item('👴', 'Elderly', 'Weaker immune & lung defense systems'),
        _Item(
          '🤧',
          'Asthma Patients',
          'Airways already sensitive to pollution',
        ),
        _Item(
          '🏃',
          'Outdoor Workers',
          'High exposure for long hours every day',
        ),
      ],
      didYouKnow:
          "3 easy ways to check your AQI: (1) Use a free AQI app, (2) Visit an AQI website, (3) Listen to local weather reports for air quality updates.",
    ),
    _AQIPage(),
  ],
);
