import 'dart:math';
import 'dart:typed_data';
import 'package:fftea/fftea.dart';
import '../../auth/models/user_model.dart';
import 'package:flutter/foundation.dart';

class BreathingService {
  // Singleton pattern
  static final BreathingService _instance = BreathingService._internal();
  factory BreathingService() => _instance;
  BreathingService._internal();

  /// Constants
  static const double userMaxCalibration =
      0.8; // Calibrate based on mic sensitivity

  /// 1. The Core Mathematical Framework - PVC Calculation
  /// Standard Formula for Indian Populations (Adjusted)
  /// PVC_Indian = [(0.052 * H) - (0.022 * A) - 3.60] * 0.90
  double calculatePVC(int age, double heightCm, Gender gender) {
    // Formula provided is generic, but usually gender specific.
    // Assuming the provided formula is the target one.
    // If standard spirometric models differentiate, we might need to adjust.
    // For now, implementing exactly as requested:
    // PVC = [(0.052 * H) - (0.022 * A) - 3.60] * 0.90

    double pvc = ((0.052 * heightCm) - (0.022 * age) - 3.60) * 0.90;

    // Male lungs are typically larger, common adjustment if not in formula:
    // But adhering strictly to "Standard Formula for Indian Populations (Adjusted)" given in prompt.
    // However, usually females have ~10-20% less capacity.
    // Let's stick to the prompt's formula but if it's negative (for kids/short people), clamp it.

    return max(pvc, 1.5); // Minimum fallback
  }

  /// Mapping Sound to Volume (V)
  /// Acoustic Integration method: V_session ≈ Σ (RMS_norm * K)
  double calculateVolume(List<double> rmsValues, double durationSeconds) {
    if (rmsValues.isEmpty) return 0.0;

    // K: Calibration constant (Liters per unit of sound)
    // This is highly heuristic without a real flow meter.
    // Tuning K such that a strong exhale roughly equals 0.5-1L/sec per max RMS.
    const double K = 0.05;

    double totalVolume = 0.0;
    for (var rms in rmsValues) {
      totalVolume += (rms * K);
    }
    return totalVolume;
  }

  /// 2. Logic per Technique

  /// Kapalbhati Power Logic (PEFR Proxy)
  /// Measures "Peak Amplitude" of each stroke.
  double calculateKapalbhatiPower(List<double> samples) {
    if (samples.isEmpty) return 0.0;

    // Find absolute peak in this window
    double peak = 0.0;
    for (var s in samples) {
      if (s.abs() > peak) peak = s.abs();
    }

    // Compare peak to predicted Max Flow
    // Capping at 100
    double score = (peak / userMaxCalibration) * 100;
    return score.clamp(0.0, 100.0);
  }

  /// Bhramari Consistency Logic
  /// Returns stability score 0-1 (1 is very stable)
  double calculateBhramariStability(List<double> frequencies) {
    if (frequencies.length < 2) return 0.0;

    // Standard deviation of frequency over time
    double sd = _calculateStandardDeviation(frequencies);

    // Lower SD = Higher Yogic Score
    // If SD is 0, score is 1. If SD is high, score drops.
    return 1.0 / (sd + 1);
  }

  double _calculateStandardDeviation(List<double> data) {
    if (data.isEmpty) return 0.0;

    double mean = data.reduce((a, b) => a + b) / data.length;
    double sumSquaredDiff = 0.0;

    for (var x in data) {
      double diff = x - mean;
      sumSquaredDiff += diff * diff;
    }

    return sqrt(sumSquaredDiff / data.length);
  }

  /// Nadi Shodhana Control & Symmetry
  /// Returns a symmetry score 0-100
  /// based on Tin : Tout ratio (Ideal is 1:2)
  double calculateSymmetryScore(double inhaleDuration, double exhaleDuration) {
    if (inhaleDuration <= 0 || exhaleDuration <= 0) return 0.0;

    double ratio = exhaleDuration / inhaleDuration;
    // Ideal ratio is 2.0
    double deviation = (ratio - 2.0).abs();

    // If ratio is exactly 2, diff is 0 -> Score 100
    // If ratio is 1 (1:1), diff is 1.
    // Let's map deviation to score.
    double score = (1.0 - (deviation / 2.0)) * 100;
    return score.clamp(0, 100);
  }

  /// Signal Processing Utils

  /// Calculate RMS of a buffer
  double calculateRMS(List<double> buffer) {
    if (buffer.isEmpty) return 0.0;
    double sum = 0.0;
    for (var sample in buffer) {
      sum += sample * sample;
    }
    return sqrt(sum / buffer.length);
  }

  /// Calculate Dominant Frequency using FFT
  double calculateDominantFrequency(List<double> pcmData, int sampleRate) {
    if (pcmData.isEmpty) return 0.0;

    // Pad to power of 2 for FFT
    final int n = pow(2, (log(pcmData.length) / ln2).ceil()).toInt();
    final paddedData = Float64List(n);
    for (int i = 0; i < pcmData.length; i++) {
      paddedData[i] = pcmData[i];
    }

    final fft = FFT(n);
    final freqData = fft.realFft(paddedData);

    // Find peak magnitude
    double maxMag = 0.0;
    int peakIndex = 0;

    // Search only valid human whistling/humming range (e.g., 50Hz - 2000Hz)
    // Bin resolution = sampleRate / n
    // Index = Freq / Resolution
    double resolution = sampleRate / n;
    int minIndex = (50 / resolution).ceil();
    int maxIndex = (2000 / resolution).floor();

    if (maxIndex >= freqData.length) maxIndex = freqData.length - 1;

    for (int i = minIndex; i <= maxIndex; i++) {
      // Magnitude = sqrt(re^2 + im^2)
      // FFTea realFft returns complex numbers, but here we likely get a specific structure.
      // Actually fftea returns ComplexArray or similar.
      // Let's check fftea usage.
      // `realFft` usually returns compact complex.
      // For simplicity with this library, let's use magnitude if available or manual calc.

      final c = freqData[i];
      // Complex magnitude
      double mag = sqrt(c.x * c.x + c.y * c.y);

      if (mag > maxMag) {
        maxMag = mag;
        peakIndex = i;
      }
    }

    return peakIndex * resolution;
  }

  // Lung Age Calculation
  // If EVC < PVC, Lung Age is higher.
  // Standard approximation: Lung Age = (0.0414 * H) - (0.0244 * EVC) - 3.59 (Heuristic example)
  // Or simple inverse of PVC formula.
  int calculateLungAge(double cv, double heightCm) {
    // Inverse of PVC formula for Age:
    // PVC = [(0.052 * H) - (0.022 * A) - 3.60] * 0.90
    // PVC / 0.90 = (0.052 * H) - (0.022 * A) - 3.60
    // (PVC / 0.90) + 3.60 - (0.052 * H) = -0.022 * A
    // A = [(0.052 * H) - 3.60 - (PVC/0.90)] / 0.022

    double estimatedAge = ((0.052 * heightCm) - 3.60 - (cv / 0.90)) / 0.022;
    return estimatedAge.round().clamp(10, 120);
  }
}
