import 'package:flutter/material.dart';

class RiskAssessmentScreen extends StatefulWidget {
  const RiskAssessmentScreen({super.key});

  @override
  State<RiskAssessmentScreen> createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen> {
  int _currentStep = 0;
  int _healthScore = 100;

  final List<Map<String, dynamic>> _factors = [
    {
      'question': 'Do you live in a highly polluted area?',
      'options': [
        {'text': 'Yes, AQI is often high', 'deduction': 15},
        {'text': 'Moderate pollution', 'deduction': 5},
        {'text': 'No, air is mostly clean', 'deduction': 0},
      ],
    },
    {
      'question': 'Are you exposed to cigarette smoke?',
      'options': [
        {'text': 'Yes, I smoke', 'deduction': 30},
        {'text': 'Yes, passive smoking', 'deduction': 15},
        {'text': 'No', 'deduction': 0},
      ],
    },
    {
      'question': 'Is there a family history of respiratory diseases?',
      'options': [
        {'text': 'Yes, multiple members', 'deduction': 20},
        {'text': 'Yes, one member', 'deduction': 10},
        {'text': 'No', 'deduction': 0},
      ],
    },
    {
      'question': 'Do you exercise regularly?',
      'options': [
        {'text': 'Yes, >= 3 times/week', 'deduction': -10}, // Bonus!
        {'text': 'Sometimes', 'deduction': 0},
        {'text': 'Rarely', 'deduction': 10},
      ],
    },
  ];

  void _answerFactor(int deduction) {
    setState(() {
      _healthScore -= deduction;
      if (_healthScore > 100) _healthScore = 100;
      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      appBar: AppBar(
        title: const Text(
          'Risk Assessment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _currentStep < _factors.length
              ? _buildQuestionnaire()
              : _buildResult(),
        ),
      ),
    );
  }

  Widget _buildQuestionnaire() {
    final q = _factors[_currentStep];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Factor ${_currentStep + 1} of ${_factors.length}',
          style: const TextStyle(
            color: Color(0xFF5AD8FE),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          q['question'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 32),
        ...(q['options'] as List<Map<String, dynamic>>).map((opt) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A143C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFF2D2553)),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () => _answerFactor(opt['deduction'] as int),
                child: Text(
                  opt['text'] as String,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildResult() {
    String message;
    Color scoreColor;

    if (_healthScore >= 80) {
      scoreColor = const Color(0xFF72E8D4);
      message = 'Your lung health score is excellent. Keep up the good habits!';
    } else if (_healthScore >= 50) {
      scoreColor = Colors.orangeAccent;
      message =
          'You have a moderate risk level. Consider taking steps to reduce exposure to pollutants and improve indoor air quality.';
    } else {
      scoreColor = Colors.redAccent;
      message =
          'Your risk level is high. Focus on reducing exposure to smoke and pollutants immediately, and consider consulting a healthcare professional.';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: _healthScore / 100,
                strokeWidth: 12,
                backgroundColor: const Color(0xFF1A143C),
                valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
              ),
            ),
            Text(
              '$_healthScore',
              style: TextStyle(
                color: scoreColor,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          'Your Lung Health Score',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFB7B0D7),
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5AD8FE),
              foregroundColor: const Color(0xFF0D082B),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Done',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
