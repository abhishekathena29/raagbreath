import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../../meditation/models/practice_session.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<void> savePracticeSession(PracticeSession session) async {
    // 1. Save Session
    await _db.collection('practice_sessions').add(session.toMap());

    // 2. Update User Stats (increment total minutes)
    final userRef = _db.collection('users').doc(session.userId);

    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) return;

      final currentMinutes = snapshot.data()?['totalPracticeMinutes'] ?? 0;
      final currentStreak = snapshot.data()?['currentStreak'] ?? 0;
      final lastPracticeStr = snapshot.data()?['lastPracticeDate'];
      DateTime? lastPractice = lastPracticeStr != null
          ? DateTime.parse(lastPracticeStr)
          : null;

      int newStreak = currentStreak;
      final today = DateTime.now();

      // Streak Logic
      if (lastPractice != null) {
        final difference = today.difference(lastPractice).inDays;
        if (difference == 1) {
          newStreak++; // Sequential day
        } else if (difference > 1) {
          newStreak = 1; // Reset streak
        }
      } else {
        newStreak = 1; // First session
      }

      transaction.update(userRef, {
        'totalPracticeMinutes': currentMinutes + session.durationMinutes,
        'currentStreak': newStreak,
        'lastPracticeDate': today.toIso8601String(),
      });
    });
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Stream<UserModel?> getUserStream(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data()!);
      }
      return null;
    });
  }

  Future<List<PracticeSession>> getRecentPracticeSessions(String uid) async {
    try {
      final querySnapshot = await _db
          .collection('practice_sessions')
          .where('userId', isEqualTo: uid)
          .orderBy('date', descending: true)
          .limit(5)
          .get();

      return querySnapshot.docs
          .map((doc) => PracticeSession.fromMap(doc.data()))
          .toList();
    } catch (e) {
      // Return empty list on error to avoid breaking UI
      return [];
    }
  }

  Future<void> updateUserBio(
    String uid, {
    int? age,
    double? heightCm,
    Gender? gender,
    ActivityLevel? activityLevel,
  }) async {
    final Map<String, dynamic> data = {};
    if (age != null) data['age'] = age;
    if (heightCm != null) data['heightCm'] = heightCm;
    if (gender != null) data['gender'] = gender.index;
    if (activityLevel != null) data['activityLevel'] = activityLevel.index;

    // Note: We should probably recalculate lung capacity here too in a real app logic

    await _db.collection('users').doc(uid).update(data);
  }
}
