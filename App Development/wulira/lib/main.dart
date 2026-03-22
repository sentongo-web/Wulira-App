// Wulira — Learn Luganda
// Copyright © 2024 Paul Sentongo. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/progress_service.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final progressService = ProgressService();
  final themeService = ThemeService();

  await Future.wait([
    progressService.load(),
    themeService.load(),
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressService),
        ChangeNotifierProvider.value(value: themeService),
      ],
      child: const WuliraApp(),
    ),
  );
}

class WuliraApp extends StatelessWidget {
  const WuliraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeService>().mode;

    return MaterialApp(
      title: 'Wulira — Learn Luganda',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}
