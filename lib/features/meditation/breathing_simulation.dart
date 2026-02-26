import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/features/auth/services/firestore_service.dart';
import 'models/practice_session.dart';

class BreathingSimulationScreen extends StatefulWidget {
  final String title;
  final Color accent;

  const BreathingSimulationScreen({
    super.key,
    required this.title,
    required this.accent,
  });

  @override
  State<BreathingSimulationScreen> createState() =>
      _BreathingSimulationScreenState();
}

class _BreathingSimulationScreenState extends State<BreathingSimulationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  String _status = 'Prepare';
  int _seconds = 0;
  Timer? _durationTimer;

  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _startDurationTimer();
    _startCycle();
  }

  void _startDurationTimer() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _seconds++);
      }
    });
  }

  Future<void> _endSession() async {
    _isActive = false;
    _durationTimer?.cancel();
    _controller.stop();

    if (_seconds > 10) {
      try {
        final user = Provider.of<AuthService>(context, listen: false).user;
        if (user != null) {
          final session = PracticeSession(
            userId: user.uid,
            date: DateTime.now(),
            durationMinutes: (_seconds / 60).ceil(),
            practiceType: 'Breathing',
            title: widget.title,
          );

          await FirestoreService().savePracticeSession(session);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Session saved! Great job.')),
            );
          }
        }
      } catch (e) {
        debugPrint('Error saving session: $e');
      }
    }

    if (mounted) Navigator.pop(context);
  }

  void _startCycle() async {
    while (mounted && _isActive) {
      if (!mounted) break;
      setState(() => _status = 'Inhale');
      await _controller.forward();

      if (!mounted || !_isActive) break;
      setState(() => _status = 'Hold');
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted || !_isActive) break;
      setState(() => _status = 'Exhale');
      await _controller.reverse();

      if (!mounted || !_isActive) break;
      setState(() => _status = 'Rest');
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  void dispose() {
    _isActive = false;
    _controller.dispose();
    _durationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF3D2B1F)),
          onPressed: _endSession,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFF3D2B1F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow
                    Container(
                      width: 300 * _animation.value,
                      height: 300 * _animation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.accent.withOpacity(
                          0.06 * _opacityAnimation.value,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.accent.withOpacity(
                              0.1 * _opacityAnimation.value,
                            ),
                            blurRadius: 50,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    // Middle circle
                    Container(
                      width: 200 * _animation.value,
                      height: 200 * _animation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            widget.accent.withOpacity(0.3),
                            widget.accent.withOpacity(0.08),
                          ],
                        ),
                      ),
                    ),
                    // Inner circle
                    Container(
                      width: 120 * _animation.value,
                      height: 120 * _animation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.accent,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.air,
                          color: Colors.white,
                          size: 40 * _animation.value,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 60),
            Text(
              _status,
              style: TextStyle(
                color: widget.accent,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Follow the rhythm of the circle',
              style: TextStyle(color: Color(0xFF8C7B6B), fontSize: 16),
            ),
            const SizedBox(height: 32),
            Text(
              '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Color(0xFF8C7B6B),
                fontSize: 24,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 40),
            TextButton.icon(
              onPressed: _endSession,
              icon: const Icon(
                Icons.stop_circle_outlined,
                color: Color(0xFFD32F2F),
              ),
              label: const Text(
                'End Session',
                style: TextStyle(color: Color(0xFFD32F2F), fontSize: 16),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundColor: const Color(0xFFD32F2F).withOpacity(0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
