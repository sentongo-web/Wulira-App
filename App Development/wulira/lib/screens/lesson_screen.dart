// Copyright © 2024 Paul Sentongo. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/lesson.dart';
import '../models/word.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initTts();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('sw-TZ');
    await _tts.setSpeechRate(0.6);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _tts.setCompletionHandler(() => setState(() => _isSpeaking = false));
  }

  Future<void> _speak(String text) async {
    if (_isSpeaking) {
      await _tts.stop();
      setState(() => _isSpeaking = false);
      return;
    }
    setState(() => _isSpeaking = true);
    await _tts.speak(text);
  }

  void _next() {
    if (_currentIndex < widget.lesson.words.length - 1) {
      _slideController.reset();
      setState(() => _currentIndex++);
      _slideController.forward();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => QuizScreen(lesson: widget.lesson)),
      );
    }
  }

  void _previous() {
    if (_currentIndex > 0) setState(() => _currentIndex--);
  }

  @override
  void dispose() {
    _tts.stop();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;
    final word = widget.lesson.words[_currentIndex];
    final total = widget.lesson.words.length;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(widget.lesson.title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/$total',
                style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentIndex + 1) / total,
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
            minHeight: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SlideTransition(
                position: _slideAnimation,
                child: _WordCard(
                  word: word,
                  isSpeaking: _isSpeaking,
                  onSpeak: () => _speak(word.luganda),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            child: Row(
              children: [
                if (_currentIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previous,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 52),
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Back', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                    ),
                  ),
                if (_currentIndex > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _next,
                    child: Text(_currentIndex == total - 1 ? 'Take Quiz' : 'Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WordCard extends StatelessWidget {
  final Word word;
  final bool isSpeaking;
  final VoidCallback onSpeak;

  const _WordCard({required this.word, required this.isSpeaking, required this.onSpeak});

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: colors.cardShadow, blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            word.luganda,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              word.phonetic,
              style: const TextStyle(fontSize: 16, color: AppColors.primary, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'English',
            style: TextStyle(fontSize: 12, color: colors.textHint, fontWeight: FontWeight.w600, letterSpacing: 1.2),
          ),
          const SizedBox(height: 6),
          Text(
            word.english,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: colors.textPrimary),
          ),
          if (word.exampleSentence != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Example', style: TextStyle(fontSize: 11, color: colors.textHint, fontWeight: FontWeight.w700, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text(word.exampleSentence!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(word.exampleTranslation ?? '', style: TextStyle(fontSize: 13, color: colors.textSecondary)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 28),
          GestureDetector(
            onTap: onSpeak,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isSpeaking ? AppColors.primary : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSpeaking ? Icons.stop_circle : Icons.volume_up_rounded,
                    color: isSpeaking ? Colors.white : AppColors.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isSpeaking ? 'Stop' : 'Hear it',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isSpeaking ? Colors.white : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
