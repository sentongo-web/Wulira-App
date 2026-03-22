class Word {
  final String id;
  final String luganda;
  final String english;
  final String phonetic;
  final String category;
  final int level;
  final String? exampleSentence;
  final String? exampleTranslation;

  const Word({
    required this.id,
    required this.luganda,
    required this.english,
    required this.phonetic,
    required this.category,
    required this.level,
    this.exampleSentence,
    this.exampleTranslation,
  });
}
