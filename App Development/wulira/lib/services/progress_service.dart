import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_progress.dart';

class ProgressService extends ChangeNotifier {
  UserProgress _progress = UserProgress(
    userId: 'local_user',
    completedLessonIds: {},
    lessonScores: {},
    currentStreak: 0,
    longestStreak: 0,
    totalXp: 0,
  );

  UserProgress get progress => _progress;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('user_progress');
    if (raw != null) {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      _progress = UserProgress(
        userId: 'local_user',
        completedLessonIds: Set<String>.from(map['completedLessonIds'] ?? []),
        lessonScores: Map<String, int>.from(map['lessonScores'] ?? {}),
        currentStreak: map['currentStreak'] ?? 0,
        longestStreak: map['longestStreak'] ?? 0,
        lastActivityDate: map['lastActivityDate'] != null
            ? DateTime.parse(map['lastActivityDate'])
            : null,
        totalXp: map['totalXp'] ?? 0,
      );
      notifyListeners();
    }
  }

  Future<void> completeLesson(String lessonId, int score) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastActivity = _progress.lastActivityDate != null
        ? DateTime(
            _progress.lastActivityDate!.year,
            _progress.lastActivityDate!.month,
            _progress.lastActivityDate!.day,
          )
        : null;

    int newStreak = _progress.currentStreak;
    if (lastActivity == null) {
      newStreak = 1;
    } else if (today.difference(lastActivity).inDays == 1) {
      newStreak += 1;
    } else if (today.difference(lastActivity).inDays > 1) {
      newStreak = 1;
    }

    final newCompleted = Set<String>.from(_progress.completedLessonIds)
      ..add(lessonId);
    final newScores = Map<String, int>.from(_progress.lessonScores)
      ..[lessonId] = score;

    _progress = _progress.copyWith(
      completedLessonIds: newCompleted,
      lessonScores: newScores,
      currentStreak: newStreak,
      longestStreak: newStreak > _progress.longestStreak
          ? newStreak
          : _progress.longestStreak,
      lastActivityDate: now,
      totalXp: _progress.totalXp + (score * 10),
    );

    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'user_progress',
      jsonEncode({
        'completedLessonIds': _progress.completedLessonIds.toList(),
        'lessonScores': _progress.lessonScores,
        'currentStreak': _progress.currentStreak,
        'longestStreak': _progress.longestStreak,
        'lastActivityDate': _progress.lastActivityDate?.toIso8601String(),
        'totalXp': _progress.totalXp,
      }),
    );
  }
}
