import 'package:flutter/material.dart';

class AppColors {
  // Brand colors (same in both modes)
  static const primary = Color(0xFF2D7D46);
  static const primaryLight = Color(0xFF4CAF70);
  static const primaryDark = Color(0xFF1B5E34);
  static const accent = Color(0xFFFFCC00);
  static const accentDark = Color(0xFFE6B800);
  static const error = Color(0xFFD32F2F);
  static const success = Color(0xFF388E3C);

  // Light mode
  static const lightBackground = Color(0xFFF5F5F0);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightTextPrimary = Color(0xFF1A1A1A);
  static const lightTextSecondary = Color(0xFF666666);
  static const lightTextHint = Color(0xFF999999);
  static const lightCardShadow = Color(0x1A000000);

  // Dark mode
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkCard = Color(0xFF2A2A2A);
  static const darkTextPrimary = Color(0xFFEEEEEE);
  static const darkTextSecondary = Color(0xFFAAAAAA);
  static const darkTextHint = Color(0xFF666666);
  static const darkCardShadow = Color(0x40000000);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.lightSurface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.lightBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: AppColors.lightCardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: AppColors.lightSurface,
        ),
        extensions: const [WuliraColors.light],
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          primary: AppColors.primaryLight,
          secondary: AppColors.accent,
          surface: AppColors.darkSurface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkSurface,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: AppColors.darkCardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: AppColors.darkCard,
        ),
        extensions: const [WuliraColors.dark],
      );
}

// Custom theme extension for easy access to custom colors
class WuliraColors extends ThemeExtension<WuliraColors> {
  final Color background;
  final Color surface;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color cardShadow;
  final Color headerGradientStart;
  final Color headerGradientEnd;

  const WuliraColors({
    required this.background,
    required this.surface,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.cardShadow,
    required this.headerGradientStart,
    required this.headerGradientEnd,
  });

  static const light = WuliraColors(
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    cardColor: AppColors.lightSurface,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textHint: AppColors.lightTextHint,
    cardShadow: AppColors.lightCardShadow,
    headerGradientStart: AppColors.primaryDark,
    headerGradientEnd: AppColors.primary,
  );

  static const dark = WuliraColors(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    cardColor: AppColors.darkCard,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textHint: AppColors.darkTextHint,
    cardShadow: AppColors.darkCardShadow,
    headerGradientStart: Color(0xFF0D3B20),
    headerGradientEnd: Color(0xFF1B5E34),
  );

  @override
  WuliraColors copyWith({
    Color? background,
    Color? surface,
    Color? cardColor,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? cardShadow,
    Color? headerGradientStart,
    Color? headerGradientEnd,
  }) {
    return WuliraColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      cardColor: cardColor ?? this.cardColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      cardShadow: cardShadow ?? this.cardShadow,
      headerGradientStart: headerGradientStart ?? this.headerGradientStart,
      headerGradientEnd: headerGradientEnd ?? this.headerGradientEnd,
    );
  }

  @override
  WuliraColors lerp(WuliraColors? other, double t) {
    if (other is! WuliraColors) return this;
    return WuliraColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      headerGradientStart:
          Color.lerp(headerGradientStart, other.headerGradientStart, t)!,
      headerGradientEnd:
          Color.lerp(headerGradientEnd, other.headerGradientEnd, t)!,
    );
  }
}

// Helper extension for easy access in widgets
extension ThemeContextExtension on BuildContext {
  WuliraColors get wColors =>
      Theme.of(this).extension<WuliraColors>() ?? WuliraColors.light;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
