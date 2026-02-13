import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_bio_model.dart';
import '../models/lung_capacity_record.dart';

class LungCapacityRepository {
  static const String _bioKey = 'user_bio';
  static const String _recordsKey = 'lung_capacity_records';

  Future<void> saveUserBio(UserBio bio) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bioKey, jsonEncode(bio.toJson()));
  }

  Future<UserBio?> getUserBio() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bioString = prefs.getString(_bioKey);
    if (bioString == null) return null;
    return UserBio.fromJson(jsonDecode(bioString));
  }

  Future<void> saveRecord(LungCapacityRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> records = prefs.getStringList(_recordsKey) ?? [];
    records.add(jsonEncode(record.toJson()));
    await prefs.setStringList(_recordsKey, records);
  }

  Future<List<LungCapacityRecord>> getRecords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recordsString = prefs.getStringList(_recordsKey) ?? [];
    return recordsString
        .map((e) => LungCapacityRecord.fromJson(jsonDecode(e)))
        .toList();
  }
}
