import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'services/breathing_service.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/features/auth/services/firestore_service.dart';
import 'package:raag_breath/features/auth/models/user_model.dart';
import 'models/practice_session.dart';

class BreathingSessionScreen extends StatefulWidget {
  final String title;
  final String techniqueId; // 'nadi_shodhana', 'bhramari', 'kapalbhati', etc.
  final Color accent;

  const BreathingSessionScreen({
    super.key,
    required this.title,
    required this.techniqueId,
    required this.accent,
  });

  @override
  State<BreathingSessionScreen> createState() => _BreathingSessionScreenState();
}

class _BreathingSessionScreenState extends State<BreathingSessionScreen>
    with TickerProviderStateMixin {
  /// Services
  final _audioRecorder = AudioRecorder();
  final _breathingService = BreathingService();

  /// State
  bool _isRecording = false;
  bool _hasPermission = false;
  StreamSubscription<RecordState>? _recordSub;
  StreamSubscription<Amplitude>? _ampSub;
  Timer? _analysisTimer;
  Timer? _sessionTimer;

  /// Metrics
  int _secondsElapsed = 0;
  double _currentRMS = 0.0;
  // ignore: unused_field
  final List<double> _rmsBuffer = [];
  final List<double> _analysisBuffer = []; // For FFT/Advanced

  // Results
  double _totalVolume = 0.0;
  // ignore: unused_field
  double _techniqueScore = 0.0; // 0-100
  // ignore: unused_field
  double _stabilityScore = 0.0; // 0-1 (For Bhramari)
  double _maxFlow = 0.0; // For Kapalbhati

  /// Animations
  late AnimationController _visualizerController;

  @override
  void initState() {
    super.initState();
    _visualizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat(reverse: true);

    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Microphone permission is required for breathing analysis',
            ),
          ),
        );
        Navigator.pop(context);
      }
      return;
    }
    setState(() => _hasPermission = true);
  }

  Future<void> _startSession() async {
    if (!_hasPermission) return;

    try {
      if (await _audioRecorder.hasPermission()) {
        final stream = await _audioRecorder.startStream(
          const RecordConfig(
            encoder: AudioEncoder.pcm16bits,
            sampleRate: 44100,
            numChannels: 1,
            noiseSuppress: false,
            echoCancel: false,
          ),
        );

        setState(() => _isRecording = true);
        _startTimer();

        // 1. Process Stream for Real-time Analysis (FFT/Raw data)
        // With record package 5.x, startStream returns a Stream<Uint8List>
        stream.listen((data) {
          _processAudioChunk(data);
        });

        // 2. Amplitude stream for quick RMS checks (optional if calculating manually)
        // Note: record package might not support both stream and getAmplitude concurrent?
        // We actally can calc RMS from PCM stream manually.
      }
    } catch (e) {
      debugPrint("Error starting recorder: $e");
    }
  }

  Future<void> _stopSession() async {
    _sessionTimer?.cancel();
    await _audioRecorder.stop();
    setState(() => _isRecording = false);
    _showResults();
  }

  void _startTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _secondsElapsed++);
    });
  }

  void _processAudioChunk(Uint8List data) {
    // Convert 16-bit PCM to doubles -1.0 to 1.0
    final buffer = data.buffer.asByteData();
    List<double> samples = [];

    for (int i = 0; i < data.length; i += 2) {
      if (i + 2 <= data.length) {
        int sample = buffer.getInt16(i, Endian.little);
        samples.add(sample / 32768.0);
      }
    }

    if (samples.isEmpty) return;

    // 1. Calculate RMS
    double rms = _breathingService.calculateRMS(samples);

    // Safety check: Too loud?
    if (rms > 0.95) {
      HapticFeedback.heavyImpact();
      // Show "Slow Down" toast/overlay (simplified here)
    }

    // Accumulate Volume
    // Assume this chunk represents X duration.
    // 44100Hz, chunk size varies.
    double chunkDuration = samples.length / 44100.0;

    // Simple noise gate
    if (rms > 0.02) {
      // Only count valid breath
      double vol = _breathingService.calculateVolume([rms], chunkDuration);
      _totalVolume += vol;

      // Specific Logic
      if (widget.techniqueId == 'kapalbhati') {
        double power = _breathingService.calculateKapalbhatiPower(samples);
        if (power > _maxFlow) _maxFlow = power;
      }

      if (widget.techniqueId == 'bhramari') {
        // FFT Analysis occasionally
        _analysisBuffer.addAll(samples);
        // Process every ~0.5s (approx 22000 samples)
        if (_analysisBuffer.length > 4096) {
          // Take 4096 for FFT
          final fftData = _analysisBuffer.sublist(0, 4096);
          double freq = _breathingService.calculateDominantFrequency(
            fftData,
            44100,
          );

          // Check consistency - if freq in range 100-300Hz (Humming)
          if (freq > 100 && freq < 400) {
            // Good hum
          }

          _analysisBuffer.removeRange(0, 4096);
        }
      }
    }

    if (mounted) {
      setState(() {
        _currentRMS = rms;
        _visualizerController.value = rms.clamp(0.0, 1.0);
      });
    }
  }

  Future<void> _showResults() async {
    // Get User Data for PVC
    final authService = Provider.of<AuthService>(context, listen: false);
    final firebaseUser = authService.user;

    double pvc = 0.0;
    int lungAge = 0;

    UserModel? user;

    if (firebaseUser != null) {
      // Fetch full user model
      user = await FirestoreService().getUser(firebaseUser.uid);

      if (user != null) {
        pvc = _breathingService.calculatePVC(
          user.age,
          user.heightCm,
          user.gender,
        );

        if (_totalVolume > pvc) {
          lungAge = user.age - 5;
        } else {
          lungAge = _breathingService.calculateLungAge(
            _totalVolume,
            user.heightCm,
          );
        }
      }
    }

    // Save Session
    try {
      if (user != null) {
        final session = PracticeSession(
          userId: user.uid,
          date: DateTime.now(),
          durationMinutes: (_secondsElapsed / 60).ceil(),
          practiceType: 'Breathing: ${widget.title}',
          title: widget.title,
        );
        await FirestoreService().savePracticeSession(session);
      }
    } catch (e) {
      debugPrint("Save error: $e");
    }

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0D082B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Session Complete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _ResultRow(
              label: 'Total Volume',
              value: '${_totalVolume.toStringAsFixed(1)} L',
            ),
            _ResultRow(
              label: 'Predicted Capacity',
              value: '${pvc.toStringAsFixed(1)} L',
            ),
            const Divider(color: Colors.white24, height: 32),
            _ResultRow(
              label: 'Lung Age',
              value: '$lungAge years',
              // We don't have user age handy unless we fetch it, but we calculated lungAge above.
              // Let's just assume if lungAge < 30 it's good or compare to pvc.
              isGood: pvc > 0 && lungAge < 40, // Simplified check
            ),

            if (widget.techniqueId == 'kapalbhati')
              _ResultRow(
                label: 'Max Power',
                value: '${_maxFlow.toStringAsFixed(1)} %',
              ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                  Navigator.pop(context); // Close screen
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Color(0xFF0D082B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recordSub?.cancel();
    _ampSub?.cancel();
    _audioRecorder.dispose();
    _analysisTimer?.cancel();
    _sessionTimer?.cancel();
    _visualizerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: _isRecording ? _stopSession : () => Navigator.pop(context),
        ),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Visualizer
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.accent.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: widget.accent.withOpacity(0.1 + (_currentRMS * 0.4)),
                    blurRadius: 50 + (_currentRMS * 100),
                    spreadRadius: 10 + (_currentRMS * 50),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.mic,
                  size: 60 + (_currentRMS * 40),
                  color: widget.accent,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              _isRecording ? 'Breathing...' : 'Ready?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Time: ${(_secondsElapsed ~/ 60).toString().padLeft(2, '0')}:${(_secondsElapsed % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 48),

            if (!_isRecording)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _startSession,
                icon: const Icon(Icons.play_arrow, color: Color(0xFF0D082B)),
                label: const Text(
                  'Start',
                  style: TextStyle(
                    color: Color(0xFF0D082B),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              TextButton.icon(
                onPressed: _stopSession,
                icon: const Icon(Icons.stop, color: Color(0xFFFF6B6B)),
                label: const Text(
                  'Stop Session',
                  style: TextStyle(color: Color(0xFFFF6B6B), fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool? isGood;

  const _ResultRow({required this.label, required this.value, this.isGood});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isGood != null) ...[
                const SizedBox(width: 8),
                Icon(
                  isGood! ? Icons.check_circle : Icons.warning_amber_rounded,
                  color: isGood! ? Colors.greenAccent : Colors.orangeAccent,
                  size: 20,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
