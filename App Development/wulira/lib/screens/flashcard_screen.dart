// Copyright © 2024 Paul Sentongo. All rights reserved.

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/lesson.dart';
import '../theme/app_theme.dart';

class FlashcardScreen extends StatefulWidget {
  final Lesson lesson;
  const FlashcardScreen({super.key, required this.lesson});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  bool _flipped = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  final FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('sw-TZ');
    await _tts.setSpeechRate(0.6);
  }

  void _flip() {
    if (_flipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
      _tts.speak(widget.lesson.words[_index].luganda);
    }
    setState(() => _flipped = !_flipped);
  }

  void _next() {
    _flipController.reset();
    setState(() {
      _flipped = false;
      if (_index < widget.lesson.words.length - 1) _index++;
    });
  }

  void _previous() {
    _flipController.reset();
    setState(() {
      _flipped = false;
      if (_index > 0) _index--;
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;
    final word = widget.lesson.words[_index];
    final total = widget.lesson.words.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lesson.title} — Flashcards'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: colors.background,
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_index + 1) / total,
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
            minHeight: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              '${_index + 1} / $total',
              style: TextStyle(color: colors.textSecondary, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: _flip,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (_, child) {
                    final angle = _flipAnimation.value * pi;
                    final showBack = angle > pi / 2;
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(angle),
                      child: showBack
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: _CardFace(
                                isBack: true,
                                topText: word.english,
                                bottomText: word.exampleSentence != null
                                    ? '"${word.exampleSentence}"'
                                    : null,
                              ),
                            )
                          : _CardFace(
                              isBack: false,
                              topText: word.luganda,
                              bottomText: word.phonetic,
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Tap card to flip',
              style: TextStyle(color: colors.textHint, fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _index > 0 ? _previous : null,
                    icon: const Icon(Icons.arrow_back_ios, size: 16),
                    label: const Text('Prev'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      side: const BorderSide(color: AppColors.primary),
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _index < total - 1 ? _next : null,
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    label: const Text('Next'),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(0, 50)),
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

class _CardFace extends StatelessWidget {
  final bool isBack;
  final String topText;
  final String? bottomText;

  const _CardFace({required this.isBack, required this.topText, this.bottomText});

  @override
  Widget build(BuildContext context) {
    final colors = context.wColors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isBack ? AppColors.primaryDark : colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: colors.cardShadow, blurRadius: 20, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isBack ? 'English' : 'Luganda',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: isBack ? Colors.white54 : colors.textHint,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              topText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: isBack ? Colors.white : AppColors.primary,
              ),
            ),
          ),
          if (bottomText != null) ...[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                bottomText!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: isBack ? Colors.white70 : colors.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
