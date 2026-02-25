import 'package:flutter/material.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  int _currentStep = 0;
  int _riskScore = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Do you have a persistent cough?',
      'options': [
        {'text': 'Yes, for more than 2 weeks', 'score': 2},
        {'text': 'Yes, but recent', 'score': 1},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'question': 'Do you experience breathlessness?',
      'options': [
        {'text': 'Even while resting', 'score': 3},
        {'text': 'During moderate activity', 'score': 2},
        {'text': 'Only during heavy exercise', 'score': 0},
      ],
    },
    {
      'question': 'Have you been exposed to pollution or smoke recently?',
      'options': [
        {'text': 'Yes, regularly', 'score': 2},
        {'text': 'Occasionally', 'score': 1},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'question': 'Do you experience chest pain or tightness?',
      'options': [
        {'text': 'Frequently', 'score': 3},
        {'text': 'Rarely', 'score': 1},
        {'text': 'Never', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _riskScore += score;
      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      appBar: AppBar(
        title: const Text(
          'Symptom Checker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _currentStep < _questions.length
              ? _buildQuestionnaire()
              : _buildResult(),
        ),
      ),
    );
  }

  Widget _buildQuestionnaire() {
    final q = _questions[_currentStep];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${_currentStep + 1} of ${_questions.length}',
          style: const TextStyle(
            color: Color(0xFF72E8D4),
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
                onPressed: () => _answerQuestion(opt['score'] as int),
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
    String riskLevel;
    Color riskColor;
    String advice;

    if (_riskScore >= 6) {
      riskLevel = 'High Risk';
      riskColor = Colors.redAccent;
      advice =
          'Your symptoms may indicate a high risk of a lung condition. Please consult a doctor immediately.';
    } else if (_riskScore >= 3) {
      riskLevel = 'Moderate Risk';
      riskColor = Colors.orangeAccent;
      advice =
          'You have some symptoms that could be related to a lung problem. Consider tracking them and consulting a doctor if they persist.';
    } else {
      riskLevel = 'Low Risk';
      riskColor = const Color(0xFF72E8D4);
      advice =
          'Your symptoms are mild. Maintain healthy habits, but if anything worsens, consult a doctor.';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.analytics, size: 80, color: Color(0xFFB0A3FF)),
        const SizedBox(height: 24),
        const Text(
          'Assessment Complete',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: riskColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: riskColor),
          ),
          child: Column(
            children: [
              Text(
                riskLevel,
                style: TextStyle(
                  color: riskColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                advice,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFB7B0D7),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF72E8D4),
              foregroundColor: const Color(0xFF0D082B),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Return to Diagnose',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
