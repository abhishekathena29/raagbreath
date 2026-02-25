enum Gender { male, female, other }

enum ActivityLevel { sedentary, moderate, active, athlete }

class UserBio {
  final int age;
  final double heightCm;
  final double weightKg;
  final Gender gender;
  final ActivityLevel activityLevel;

  UserBio({
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.gender,
    required this.activityLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'gender': gender.index,
      'activityLevel': activityLevel.index,
    };
  }

  factory UserBio.fromJson(Map<String, dynamic> json) {
    return UserBio(
      age: json['age'],
      heightCm: json['heightCm'],
      weightKg: json['weightKg'],
      gender: Gender.values[json['gender']],
      activityLevel: ActivityLevel.values[json['activityLevel']],
    );
  }
}
