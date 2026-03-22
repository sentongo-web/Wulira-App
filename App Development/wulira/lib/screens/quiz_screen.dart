// Copyright © 2024 Paul Sentongo. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../models/word.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _correctAnswers = 0;
  String? _selectedAnswer;
  bool _answered = false;
  late List<_Question> _questions;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
  }

  List<_Question> _buildQuestions() {
    final words = List<Word>.from(widget.lesson.words)..shuffle();
    return words.map((word) {
      final others = widget.lesson.words.where((w) => w.id != word.id).toList()..shuffle();
      final options = [word.english, ...others.take(3).map((w) => w.english)]..shuffle();
      return _Question(lugandaWord: word.luganda, correctAnswer: word.english, options: options);
    }).toList();
  }

  void _selectAnswer(String answer) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (answer == _questions[_questionIndex].correctAnswer) _correctAnswers++;
    });
  }

  void _next() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      _finish();
    }
  }

  void _finish() {
    final score = ((_correctAnswers / _questions.length) * 100).round();
    context.read<ProgressService>().completeLesson(widget.lesson.id, score);
    _showResultDialog(score);
  }

  void _showResultDialog(int score) {
    final passed = score >= 60;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(passed ? '🎉' : '💪', style: const TextStyle(fontSize: 60)),
            const SizedBox(height: 12),
            Text(
              passed ? 'Webale nyo!' : 'Keep trying!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(passed ? 'Great job!' : "You'll get it next time!",
                style: const TextStyle(color: AppColors.lightTextSecondary)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: passed
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '$score%',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: passed ? AppColors.primary : AppColors.error,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('$_correctAnswers / ${_questions.length} correct',
                style: const TextStyle(color: AppColors.lightTextSecondary)),
            const SizedBox(height: 20),
            Text('+${score ~/ 10} XP earned',
                style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Color _optionColor(String option) {
    if (!_answered) return Colors.transparent;
    final correct = _questions[_questionIndex].correctAnswer;
    if (option == correct) return AppColors.success.withValues(alpha: 0.15);
    if (option == _selectedAnswer) return AppColors.error.withValues(alpha: 0.15);
    return Colors.transparent;
  }

  Color _optionBorderColor(String option) {
    if (!_answered) return Colors.transparent;
    final correct = _questions[_questionIndex].correctAnswer;
    if (option == correct) return AppColors.success;
    if (option == _selectedAnswer) return AppColors.error;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;
    final question = _questions[_questionIndex];
    final total = _questions.length;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('${widget.lesson.title} Quiz'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('${_questionIndex + 1}/$total',
                  style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_questionIndex + 1) / total,
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
            minHeight: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'What does this mean?',
                    style: TextStyle(fontSize: 15, color: colors.textSecondary, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      question.lugandaWord,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('Choose the correct answer',
                      style: TextStyle(fontSize: 14, color: colors.textHint)),
                  const SizedBox(height: 12),
                  ...question.options.map((option) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => _selectAnswer(option),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: _optionColor(option) == Colors.transparent
                              ? colors.cardColor
                              : _optionColor(option),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _optionBorderColor(option), width: 2),
                          boxShadow: [
                            BoxShadow(color: colors.cardShadow, blurRadius: 4, offset: const Offset(0, 2)),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.textPrimary),
                              ),
                            ),
                            if (_answered && option == question.correctAnswer)
                              const Icon(Icons.check_circle, color: AppColors.success, size: 22),
                            if (_answered && option == _selectedAnswer && option != question.correctAnswer)
                              const Icon(Icons.cancel, color: AppColors.error, size: 22),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          if (_answered)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: ElevatedButton(
                onPressed: _next,
                child: Text(_questionIndex == _questions.length - 1 ? 'See Results' : 'Next Question'),
              ),
            ),
        ],
      ),
    );
  }
}

class _Question {
  final String lugandaWord;
  final String correctAnswer;
  final List<String> options;
  _Question({required this.lugandaWord, required this.correctAnswer, required this.options});
}
