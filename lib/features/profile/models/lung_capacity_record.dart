enum MeasurementMode { breathHold, exhale }

class LungCapacityRecord {
  final DateTime timestamp;
  final int durationSeconds;
  final MeasurementMode mode;
  final String practiceType; // e.g., "Pranayama", "Yoga", "Resting"

  LungCapacityRecord({
    required this.timestamp,
    required this.durationSeconds,
    required this.mode,
    required this.practiceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'durationSeconds': durationSeconds,
      'mode': mode.index,
      'practiceType': practiceType,
    };
  }

  factory LungCapacityRecord.fromJson(Map<String, dynamic> json) {
    return LungCapacityRecord(
      timestamp: DateTime.parse(json['timestamp']),
      durationSeconds: json['durationSeconds'],
      mode: MeasurementMode.values[json['mode']],
      practiceType: json['practiceType'],
    );
  }
}
