import 'word.dart';

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final int level;
  final String category;
  final List<Word> words;
  final bool isPremium;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.level,
    required this.category,
    required this.words,
    this.isPremium = false,
  });
}
