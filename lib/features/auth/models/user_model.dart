enum Gender { male, female, other }

enum ActivityLevel { sedentary, moderate, active, athlete }

enum UserType { student, teacher, schoolAdmin, parent, ngo }

class UserModel {
  final String uid;
  final String email;
  final String name;
  final int age;
  final double heightCm;
  final double weightKg;
  final Gender gender;
  final ActivityLevel activityLevel;
  final UserType userType;

  // Stats
  final int totalPracticeMinutes;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastPracticeDate;

  // Calculated/Stored
  final double lungCapacityScore;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.gender,
    required this.activityLevel,
    this.userType = UserType.student,
    this.totalPracticeMinutes = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastPracticeDate,
    this.lungCapacityScore = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'age': age,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'gender': gender.index,
      'activityLevel': activityLevel.index,
      'userType': userType.index,
      'totalPracticeMinutes': totalPracticeMinutes,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastPracticeDate': lastPracticeDate?.toIso8601String(),
      'lungCapacityScore': lungCapacityScore,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      heightCm: map['heightCm']?.toDouble() ?? 0.0,
      weightKg: map['weightKg']?.toDouble() ?? 0.0,
      gender: Gender.values[map['gender'] ?? 0],
      activityLevel: ActivityLevel.values[map['activityLevel'] ?? 0],
      userType: UserType.values[map['userType'] ?? 0],
      totalPracticeMinutes: map['totalPracticeMinutes']?.toInt() ?? 0,
      currentStreak: map['currentStreak']?.toInt() ?? 0,
      longestStreak: map['longestStreak']?.toInt() ?? 0,
      lastPracticeDate: map['lastPracticeDate'] != null
          ? DateTime.parse(map['lastPracticeDate'])
          : null,
      lungCapacityScore: map['lungCapacityScore']?.toDouble() ?? 0.0,
    );
  }
}
