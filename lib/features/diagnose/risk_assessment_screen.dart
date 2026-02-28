import 'package:flutter/material.dart';

class RiskAssessmentScreen extends StatefulWidget {
  const RiskAssessmentScreen({super.key});

  @override
  State<RiskAssessmentScreen> createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen>
    with SingleTickerProviderStateMixin {
  bool _showResult = false;

  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  static const _accent = Color(0xFFE64A19);
  static const _bg = Color(0xFFFFF3EE);

  final List<_RiskFactor> _factors = [
    _RiskFactor(
      emoji: '🏙️',
      title: 'Outdoor Air Pollution',
      desc: 'How polluted is the air where you live or go to school?',
      leftLabel: 'Clean Air',
      rightLabel: 'Very Polluted',
      leftEmoji: '🌿',
      rightEmoji: '🏭',
    ),
    _RiskFactor(
      emoji: '🏠',
      title: 'Indoor Air Quality at Home',
      desc: 'Cooking smoke, incense, poor ventilation?',
      leftLabel: 'Well Ventilated',
      rightLabel: 'Lots of Smoke',
      leftEmoji: '🪟',
      rightEmoji: '🔥',
    ),
    _RiskFactor(
      emoji: '🚬',
      title: 'Exposure to Cigarette Smoke',
      desc: 'Do people around you smoke at home or nearby?',
      leftLabel: 'No Exposure',
      rightLabel: 'Heavy Daily Smoke',
      leftEmoji: '✅',
      rightEmoji: '💨',
    ),
    _RiskFactor(
      emoji: '🧬',
      title: 'Family History of Lung Disease',
      desc: 'Asthma, TB, COPD or breathing issues in family?',
      leftLabel: 'No History',
      rightLabel: 'Strong Family History',
      leftEmoji: '😊',
      rightEmoji: '😔',
    ),
    _RiskFactor(
      emoji: '🤧',
      title: 'Allergies or Asthma',
      desc: 'Do you have known allergies, asthma or breathing triggers?',
      leftLabel: 'No Allergies',
      rightLabel: 'Severe Allergies/Asthma',
      leftEmoji: '✅',
      rightEmoji: '😰',
    ),
    _RiskFactor(
      emoji: '🏃',
      title: 'Physical Activity Level',
      desc: 'How often do you exercise, run, or play sports?',
      leftLabel: 'Never Exercise',
      rightLabel: 'Very Active Daily',
      leftEmoji: '🛋️',
      rightEmoji: '🥇',
      invertedScore: true,
    ),
    _RiskFactor(
      emoji: '🥗',
      title: 'Diet & Hydration',
      desc: 'How often do you eat fruits, vegetables, and drink enough water?',
      leftLabel: 'Poor Diet',
      rightLabel: 'Excellent Diet',
      leftEmoji: '🍟',
      rightEmoji: '🥦',
      invertedScore: true,
    ),
  ];

  final List<double> _sliderValues = List.filled(7, 0.3);

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  // Score 0-100: higher = healthier lungs
  int get _lungHealthScore {
    double raw = 0;
    for (int i = 0; i < _factors.length; i++) {
      final v = _sliderValues[i];
      if (_factors[i].invertedScore) {
        raw += v * (_factors.length > 0 ? 100.0 / _factors.length : 0);
      } else {
        raw += (1 - v) * (_factors.length > 0 ? 100.0 / _factors.length : 0);
      }
    }
    return raw.round().clamp(0, 100);
  }

  String _getLevelLabel(double v, bool inverted) {
    final eff = inverted ? v : (1 - v);
    if (eff >= 0.75)
      return ['Excellent', 'Very Active', 'Clean Air'][inverted ? 0 : 0];
    if (eff >= 0.5) {
      if (inverted) return 'Sometimes Active';
      return 'Moderate';
    }
    if (eff >= 0.25) return inverted ? 'Rarely Active' : 'Some Exposure';
    return inverted ? 'No Activity' : 'High Exposure';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: FadeTransition(
              opacity: _fade,
              child: _showResult ? _buildResult() : _buildSliders(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFBF360C), Color(0xFFE64A19), Color(0xFFFF7043)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
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
                      'TOOL 2 OF 2',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'Lung Health Risk Assessment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
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

  Widget _buildSliders() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Intro card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFBF360C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What is Risk Assessment? 😊',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'This tool looks at your environment, lifestyle and health history to calculate a Lung Health Score. It helps you understand your risk before symptoms even appear.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Text('💡', style: TextStyle(fontSize: 14)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Higher score = healthier lungs. Lower score = higher risk. Always see a doctor for a real diagnosis.',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text('📊', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(
                'Rate Each Risk Factor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._factors.asMap().entries.map(
            (e) => _buildSliderCard(e.key, e.value),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCard(int i, _RiskFactor factor) {
    final v = _sliderValues[i];
    final label = _getLevelLabel(v, factor.invertedScore);
    final isGood = factor.invertedScore ? v > 0.5 : v < 0.5;
    final labelColor = isGood ? const Color(0xFF43A047) : _accent;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    factor.emoji,
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
                      factor.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF212121),
                      ),
                    ),
                    Text(
                      factor.desc,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(factor.leftEmoji, style: const TextStyle(fontSize: 18)),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 6,
                    activeTrackColor: _accent,
                    inactiveTrackColor: _accent.withValues(alpha: 0.15),
                    thumbColor: _accent,
                    overlayColor: _accent.withValues(alpha: 0.1),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                  ),
                  child: Slider(
                    value: v,
                    onChanged: (val) => setState(() => _sliderValues[i] = val),
                  ),
                ),
              ),
              Text(factor.rightEmoji, style: const TextStyle(fontSize: 18)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                factor.leftLabel,
                style: const TextStyle(fontSize: 10, color: Color(0xFFBDBDBD)),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: labelColor,
                ),
              ),
              Text(
                factor.rightLabel,
                style: const TextStyle(fontSize: 10, color: Color(0xFFBDBDBD)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final score = _lungHealthScore;
    String emoji;
    Color scoreColor;
    String title;
    String message;
    List<String> tips;

    if (score >= 75) {
      emoji = '🌿';
      scoreColor = const Color(0xFF43A047);
      title = 'Great Lung Health!';
      message =
          'Your lifestyle and environment show low risk to your lungs. Keep up the great efforts — your lungs thank you!';
      tips = [
        'Maintain your diet and exercise',
        'Keep checking AQI levels',
        'Continue breathing exercises',
      ];
    } else if (score >= 50) {
      emoji = '⚠️';
      scoreColor = const Color(0xFFFB8C00);
      title = 'Moderate Risk';
      message =
          'There are some risk factors in your environment or lifestyle. Take simple steps now before symptoms appear.';
      tips = [
        'Improve ventilation at home',
        'Wear a mask on polluted days',
        'Add more fruits & vegetables',
      ];
    } else {
      emoji = '🚨';
      scoreColor = const Color(0xFFE53935);
      title = 'High Risk — Take Action';
      message =
          'Your risk score is low. Multiple environmental or lifestyle factors are harming your lung health. Consider consulting a doctor and making changes.';
      tips = [
        'Quit or avoid cigarette exposure',
        'Consult a doctor this week',
        'Use an air purifier at home',
      ];
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: scoreColor.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: CircularProgressIndicator(
                        value: score / 100,
                        strokeWidth: 13,
                        backgroundColor: scoreColor.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$score',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: scoreColor,
                          ),
                        ),
                        Text(
                          '/100',
                          style: TextStyle(
                            fontSize: 12,
                            color: scoreColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(emoji, style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: scoreColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFBF360C),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🛡️  What You Can Do Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ...tips.map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          t,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              child: const Text('← Back to Diagnose'),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                _showResult = false;
                _sliderValues.fillRange(0, _sliderValues.length, 0.3);
              });
              _fadeCtrl.forward(from: 0);
            },
            child: Text('Reassess', style: TextStyle(color: _accent)),
          ),
        ],
      ),
    );
  }
}

class _RiskFactor {
  final String emoji, title, desc, leftLabel, rightLabel, leftEmoji, rightEmoji;
  final bool invertedScore;

  const _RiskFactor({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftEmoji,
    required this.rightEmoji,
    this.invertedScore = false,
  });
}
