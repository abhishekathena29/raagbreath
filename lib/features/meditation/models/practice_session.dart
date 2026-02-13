class PracticeSession {
  final String userId;
  final DateTime date;
  final int durationMinutes;
  final String practiceType; // e.g., 'Breathing', 'Meditation'
  final String title;

  PracticeSession({
    required this.userId,
    required this.date,
    required this.durationMinutes,
    required this.practiceType,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'durationMinutes': durationMinutes,
      'practiceType': practiceType,
      'title': title,
    };
  }

  factory PracticeSession.fromMap(Map<String, dynamic> map) {
    return PracticeSession(
      userId: map['userId'] ?? '',
      date: DateTime.parse(map['date']),
      durationMinutes: map['durationMinutes']?.toInt() ?? 0,
      practiceType: map['practiceType'] ?? '',
      title: map['title'] ?? '',
    );
  }
}
