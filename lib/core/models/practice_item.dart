import 'package:flutter/material.dart';

class PracticeItem {
  final String id;
  final String title;
  final String subtitle;
  final String meta;
  final Color accent;
  final String description;
  final List<String> steps;
  final String? purpose;
  final String? timeOfDay;
  final String? mood;

  final String? videoUrl;

  const PracticeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.accent,
    required this.description,
    required this.steps,
    this.purpose,
    this.timeOfDay,
    this.mood,
    this.videoUrl,
  });
}
