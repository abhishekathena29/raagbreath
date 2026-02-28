import 'package:flutter/material.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  int _riskScore = 0;
  int? _selectedIndex;
  bool _showResult = false;

  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  static const _bg = Color(0xFFEEF0FF);

  final List<Map<String, dynamic>> _questions = [
    {
      'emoji': '😮',
      'question': 'Do you have a cough right now?',
      'options': [
        {
          'emoji': '✅',
          'text': 'No cough',
          'sub': "I'm not coughing at all",
          'score': 0,
        },
        {
          'emoji': '😤',
          'text': 'Mild, occasional cough',
          'sub': 'Just now and then, not too bad',
          'score': 1,
        },
        {
          'emoji': '😰',
          'text': 'Frequent or persistent cough',
          'sub': 'I cough a lot or it won\'t go away',
          'score': 2,
        },
        {
          'emoji': '🩸',
          'text': 'Coughing with blood or phlegm',
          'sub': 'Mucus or blood when I cough',
          'score': 3,
        },
      ],
    },
    {
      'emoji': '💨',
      'question': 'How is your breathing right now?',
      'options': [
        {
          'emoji': '😌',
          'text': 'Breathing fine',
          'sub': 'No trouble at all',
          'score': 0,
        },
        {
          'emoji': '🏃',
          'text': 'Short of breath during exercise',
          'sub': 'Only when I run or exercise hard',
          'score': 1,
        },
        {
          'emoji': '🚶',
          'text': 'Breathless on mild activity',
          'sub': 'Even walking up stairs is hard',
          'score': 2,
        },
        {
          'emoji': '🛋️',
          'text': 'Breathless even at rest',
          'sub': "I struggle even when I'm sitting still",
          'score': 3,
        },
      ],
    },
    {
      'emoji': '🫁',
      'question': 'Do you feel tightness or pain in your chest?',
      'options': [
        {
          'emoji': '✅',
          'text': 'No chest issues',
          'sub': 'My chest feels fine',
          'score': 0,
        },
        {
          'emoji': '😬',
          'text': 'Mild tightness occasionally',
          'sub': 'Comes and goes, not too bad',
          'score': 1,
        },
        {
          'emoji': '😣',
          'text': 'Frequent chest tightness',
          'sub': 'Often feels tight or heavy',
          'score': 2,
        },
        {
          'emoji': '🚨',
          'text': 'Severe chest pain',
          'sub': 'Sharp or intense pain in chest',
          'score': 3,
        },
      ],
    },
    {
      'emoji': '🤧',
      'question': 'Have you been around smoke or pollution?',
      'options': [
        {
          'emoji': '✅',
          'text': 'Not at all',
          'sub': 'Clean air around me',
          'score': 0,
        },
        {
          'emoji': '🏙️',
          'text': 'Occasionally exposed',
          'sub': 'Sometimes near traffic or smoke',
          'score': 1,
        },
        {
          'emoji': '🏭',
          'text': 'Regular exposure',
          'sub': 'Daily near pollution or indoor smoke',
          'score': 2,
        },
        {
          'emoji': '🚬',
          'text': 'Heavy smoke exposure',
          'sub': 'I smoke or live with smokers',
          'score': 3,
        },
      ],
    },
    {
      'emoji': '😴',
      'question': 'How is your energy and sleep?',
      'options': [
        {
          'emoji': '✅',
          'text': 'Feeling fresh and rested',
          'sub': 'No fatigue or sleep trouble',
          'score': 0,
        },
        {
          'emoji': '😐',
          'text': 'Mildly tired sometimes',
          'sub': 'Some days feel sluggish',
          'score': 1,
        },
        {
          'emoji': '😩',
          'text': 'Often fatigued',
          'sub': 'Tired most of the time',
          'score': 2,
        },
        {
          'emoji': '🛏️',
          'text': 'Severe fatigue & poor sleep',
          'sub': 'Can barely function or rest',
          'score': 3,
        },
      ],
    },
    {
      'emoji': '🌡️',
      'question': 'Any fever, chills or night sweats?',
      'options': [
        {
          'emoji': '✅',
          'text': 'None at all',
          'sub': "I'm feeling normal temperature",
          'score': 0,
        },
        {
          'emoji': '🤒',
          'text': 'Mild fever occasionally',
          'sub': 'Low-grade fever sometimes',
          'score': 1,
        },
        {
          'emoji': '🥵',
          'text': 'Recurring fever',
          'sub': 'Fever that keeps coming back',
          'score': 2,
        },
        {
          'emoji': '🥶',
          'text': 'Night sweats + chills',
          'sub': 'Wake up drenched or shivering',
          'score': 3,
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
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

  void _goNext() {
    if (_selectedIndex == null) return;
    final score =
        (_questions[_currentStep]['options'] as List)[_selectedIndex!]['score']
            as int;
    _riskScore += score;

    _fadeCtrl.reverse().then((_) {
      setState(() {
        if (_currentStep < _questions.length - 1) {
          _currentStep++;
          _selectedIndex = null;
        } else {
          _showResult = true;
        }
      });
      _fadeCtrl.forward();
    });
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
              child: _showResult ? _buildResult() : _buildBody(),
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
          colors: [Color(0xFF3949AB), Color(0xFF5C6BC0)],
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SYMPTOM CHECKER',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'How Are Your Lungs Feeling?',
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
            if (!_showResult) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _questions.length,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _currentStep ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i <= _currentStep
                            ? Colors.white
                            : Colors.white30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ] else
              const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    final q = _questions[_currentStep];
    final options = q['options'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info banner (first question only)
          if (_currentStep == 0) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF3949AB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'What is a Symptom Checker? 🧐',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'This tool asks a few simple questions about how you\'re feeling. Based on your answers, it gives you a quick idea of whether your lungs might need attention.',
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
                        Text('⚠️', style: TextStyle(fontSize: 14)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'This tool is a guide only — it does not replace a real doctor.',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // How it helps (first question only)
          if (_currentStep == 0) ...[
            const Text(
              '💡  How It Helps You',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3949AB),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _HelpChip(emoji: '❓', label: 'Ask\nQuestions'),
                const SizedBox(width: 10),
                _HelpChip(emoji: '🔍', label: 'Analyse\nAnswers'),
                const SizedBox(width: 10),
                _HelpChip(emoji: '✅', label: 'Guide\nYou'),
              ],
            ),
            const SizedBox(height: 24),
          ],

          // Section label
          Text(
            '🙏  Start the Check',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF3949AB),
            ),
          ).apply(visible: _currentStep == 0),
          if (_currentStep == 0) const SizedBox(height: 14),

          // Question card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUESTION ${_currentStep + 1} OF ${_questions.length}',
                  style: const TextStyle(
                    color: Color(0xFF3949AB),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  q['emoji'] as String,
                  style: const TextStyle(fontSize: 36),
                ),
                const SizedBox(height: 8),
                Text(
                  q['question'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 20),
                ...options.asMap().entries.map((e) {
                  final selected = _selectedIndex == e.key;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedIndex = e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF3949AB)
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF3949AB)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              e.value['emoji'] as String,
                              style: const TextStyle(fontSize: 22),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.value['text'] as String,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: selected
                                          ? Colors.white
                                          : const Color(0xFF212121),
                                    ),
                                  ),
                                  Text(
                                    e.value['sub'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: selected
                                          ? Colors.white70
                                          : const Color(0xFF9E9E9E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (selected)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedIndex != null ? _goNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3949AB),
                disabledBackgroundColor: const Color(0xFFBBBEE0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(
                _currentStep == _questions.length - 1
                    ? 'See Results →'
                    : 'Next →',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    String riskLevel;
    String emoji;
    Color riskColor;
    String advice;
    List<String> tips;

    if (_riskScore >= 10) {
      riskLevel = 'High Risk';
      emoji = '🚨';
      riskColor = const Color(0xFFE53935);
      advice =
          'Your answers suggest significant lung symptoms. Please consult a doctor as soon as possible — early action matters!';

      tips = [
        'Avoid smoking & polluted areas',
        'Use a mask outdoors',
        'Do not delay medical help',
      ];
    } else if (_riskScore >= 5) {
      riskLevel = 'Moderate Risk';
      emoji = '⚠️';
      riskColor = const Color(0xFFFB8C00);
      advice =
          'You have some symptoms worth watching. Track them over the next few days and see a doctor if they worsen.';

      tips = [
        'Check AQI before going out',
        'Try breathing exercises',
        'See a doctor if symptoms persist',
      ];
    } else {
      riskLevel = 'Low Risk';
      emoji = '✅';
      riskColor = const Color(0xFF43A047);
      advice =
          'Your symptoms are mild or absent. Keep up healthy habits and continue monitoring your lung health regularly.';

      tips = [
        'Do 20 min of daily exercise',
        'Practice pranayama breathing',
        'Check your AQI regularly',
      ];
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: riskColor.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 60)),
                const SizedBox(height: 10),
                const Text(
                  'Assessment Complete',
                  style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                ),
                const SizedBox(height: 6),
                Text(
                  riskLevel,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: riskColor,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Score: $_riskScore / ${_questions.length * 3}',
                    style: TextStyle(
                      color: riskColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  advice,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF616161),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF3949AB),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '💡  What You Can Do',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ...tips.map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
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
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3949AB),
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
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              setState(() {
                _currentStep = 0;
                _riskScore = 0;
                _selectedIndex = null;
                _showResult = false;
              });
              _fadeCtrl.forward(from: 0);
            },
            child: const Text(
              'Retake Quiz',
              style: TextStyle(color: Color(0xFF3949AB)),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpChip extends StatelessWidget {
  final String emoji, label;
  const _HelpChip({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF616161),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on Widget {
  Widget apply({required bool visible}) =>
      visible ? this : const SizedBox.shrink();
}
