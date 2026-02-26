import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/features/auth/services/firestore_service.dart';
import 'package:raag_breath/features/meditation/models/practice_session.dart';

class LungCapacityTestScreen extends StatefulWidget {
  const LungCapacityTestScreen({super.key});

  @override
  State<LungCapacityTestScreen> createState() => _LungCapacityTestScreenState();
}

class _LungCapacityTestScreenState extends State<LungCapacityTestScreen>
    with SingleTickerProviderStateMixin {
  bool _isTesting = false;
  int _currentDuration = 0;
  Timer? _timer;
  String _selectedPracticeType = 'Pranayama';

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTest() {
    setState(() {
      _isTesting = true;
      _currentDuration = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentDuration = timer.tick;
        });
      }
    });
  }

  Future<void> _stopTest() async {
    _timer?.cancel();
    final duration = _currentDuration;
    setState(() => _isTesting = false);

    try {
      final user = Provider.of<AuthService>(context, listen: false).user;
      if (user != null) {
        final session = PracticeSession(
          userId: user.uid,
          date: DateTime.now(),
          durationMinutes: (duration / 60).ceil().clamp(1, 60),
          practiceType: 'Lung Test',
          title: 'Held for ${duration}s',
        );
        await FirestoreService().savePracticeSession(session);
      }
    } catch (e) {
      debugPrint("Error saving test: $e");
    }

    if (mounted) {
      _showResultDialog(duration);
    }
  }

  void _showResultDialog(int duration) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Result', style: TextStyle(color: Color(0xFF3D2B1F))),
        content: Text(
          'You held your breath for $duration seconds!',
          style: const TextStyle(color: Color(0xFF8C7B6B)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text(
              'Done',
              style: TextStyle(color: Color(0xFFC17D3C)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3D2B1F)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Measure Lung Capacity',
          style: TextStyle(color: Color(0xFF3D2B1F)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How long can you hold your breath?',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedPracticeType,
              dropdownColor: Colors.white,
              style: const TextStyle(color: Color(0xFF3D2B1F)),
              decoration: InputDecoration(
                labelText: 'Practice Context',
                labelStyle: const TextStyle(color: Color(0xFF8C7B6B)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE8DDD0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFC17D3C)),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Pranayama', child: Text('Pranayama')),
                DropdownMenuItem(value: 'Yoga', child: Text('Yoga')),
                DropdownMenuItem(value: 'Resting', child: Text('Resting')),
                DropdownMenuItem(
                  value: 'Post-Workout',
                  child: Text('Post-Workout'),
                ),
              ],
              onChanged: _isTesting
                  ? null
                  : (v) {
                      if (v != null) setState(() => _selectedPracticeType = v);
                    },
            ),
            const Spacer(),
            Center(
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 200 * (_isTesting ? _pulseAnimation.value : 1.0),
                    height: 200 * (_isTesting ? _pulseAnimation.value : 1.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isTesting
                          ? const Color(0xFFC17D3C).withOpacity(0.15)
                          : const Color(0xFFE8DDD0).withOpacity(0.5),
                      border: Border.all(
                        color: _isTesting
                            ? const Color(0xFFC17D3C)
                            : const Color(0xFFE8DDD0),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _isTesting ? '$_currentDuration' : 'Start',
                        style: TextStyle(
                          color: const Color(0xFF3D2B1F),
                          fontSize: _isTesting ? 64 : 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            if (_isTesting)
              ElevatedButton(
                onPressed: _stopTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'STOP / EXHALE',
                  style: TextStyle(fontSize: 18),
                ),
              )
            else
              ElevatedButton(
                onPressed: _startTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC17D3C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'INHALE & START',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
