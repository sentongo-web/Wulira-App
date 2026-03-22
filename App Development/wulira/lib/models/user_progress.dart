class UserProgress {
  final String userId;
  final Set<String> completedLessonIds;
  final Map<String, int> lessonScores;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityDate;
  final int totalXp;

  const UserProgress({
    required this.userId,
    required this.completedLessonIds,
    required this.lessonScores,
    required this.currentStreak,
    required this.longestStreak,
    this.lastActivityDate,
    required this.totalXp,
  });

  UserProgress copyWith({
    Set<String>? completedLessonIds,
    Map<String, int>? lessonScores,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastActivityDate,
    int? totalXp,
  }) {
    return UserProgress(
      userId: userId,
      completedLessonIds: completedLessonIds ?? this.completedLessonIds,
      lessonScores: lessonScores ?? this.lessonScores,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      totalXp: totalXp ?? this.totalXp,
    );
  }

  bool isLessonCompleted(String lessonId) =>
      completedLessonIds.contains(lessonId);

  int scoreForLesson(String lessonId) => lessonScores[lessonId] ?? 0;
}
