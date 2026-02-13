import '../../features/auth/models/user_model.dart';
import 'dart:math';

class LungCapacityCalculator {
  static double calculate(UserModel user) {
    // 1. Base Capacity Estimation (Simplified from Robinson Formula)
    // Male: (0.052 * H) - (0.022 * A) - 3.60
    // Female: (0.041 * H) - (0.018 * A) - 2.69

    double base;
    if (user.gender == Gender.male) {
      base = (0.052 * user.heightCm) - (0.022 * user.age) - 3.60;
    } else {
      base = (0.041 * user.heightCm) - (0.018 * user.age) - 2.69;
    }

    // Safety clamp (2L to 7L reasonable range)
    if (base < 2.0) base = 2.0;

    // 2. Activity Level Factor
    double activityBonus = 0.0;
    switch (user.activityLevel) {
      case ActivityLevel.sedentary:
        activityBonus = 0.0;
        break;
      case ActivityLevel.moderate:
        activityBonus = 0.3;
        break;
      case ActivityLevel.active:
        activityBonus = 0.6;
        break;
      case ActivityLevel.athlete:
        activityBonus = 1.0;
        break;
    }

    // 3. Practice Bonus (Dynamic Element)
    // +0.05L for every hour of total practice (capped at 1.5L)
    double practiceBonus = (user.totalPracticeMinutes / 60) * 0.05;
    practiceBonus = min(practiceBonus, 1.5);

    // 4. Streak Bonus (Consistency Wrapper)
    // +0.1L for every 7 day streak (capped at 0.5L)
    double streakBonus = (user.currentStreak / 7) * 0.1;
    streakBonus = min(streakBonus, 0.5);

    double total = base + activityBonus + practiceBonus + streakBonus;
    return double.parse(total.toStringAsFixed(2));
  }
}
