import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {


  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      // 🟤 Primary
      primary: AppColors.gold500,
      onPrimary: AppColors.black,
      primaryContainer: AppColors.gold700,
      onPrimaryContainer: AppColors.white,

      // 🟨 Secondary
      secondary: AppColors.gold200,
      onSecondary: AppColors.black,
      secondaryContainer: AppColors.gold600,
      onSecondaryContainer: AppColors.white,

      // 🟠 Tertiary
      tertiary: AppColors.bronze400,
      onTertiary: AppColors.black,
      tertiaryContainer: AppColors.bronze800,
      onTertiaryContainer: AppColors.white,

      // 🔴 Error
      error: AppColors.red600,
      onError: AppColors.white,
      errorContainer: AppColors.red900,
      onErrorContainer: AppColors.white,

      // ⚫ Surface
      surface: AppColors.black900,
      onSurface: AppColors.gold100,

      surfaceContainerHighest: AppColors.black700,
      onSurfaceVariant: AppColors.gold300,

      // ⚪ Outline
      outline: AppColors.gold700,

      // 🌑 Extras
      shadow: AppColors.black,
      scrim: AppColors.black,

      inverseSurface: AppColors.gold50,
      onInverseSurface: AppColors.black900,
      inversePrimary: AppColors.gold400,
    ),

    scaffoldBackgroundColor: AppColors.black900,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black900,
      foregroundColor: AppColors.gold100,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColors.gold100,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "janna",
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.gold200,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.gold700,
      thickness: 0.5,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.black800,

      hintStyle: const TextStyle(
        color: AppColors.gold300,
        fontFamily: "janna",
      ),

      prefixIconColor: AppColors.gold400,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.gold700,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.gold700,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.gold500,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.red600,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.red600,
          width: 2,
        ),
      ),
    ),

    textTheme: const TextTheme(

      // Headlines
      headlineLarge: TextStyle(
        color: AppColors.gold100,
        fontFamily: "janna",
        fontWeight: FontWeight.bold,
      ),

      headlineMedium: TextStyle(
        color: AppColors.gold100,
        fontFamily: "janna",
        fontWeight: FontWeight.bold,
      ),

      // Titles
      titleLarge: TextStyle(
        color: AppColors.gold100,
        fontFamily: "janna",
        fontWeight: FontWeight.w700,
      ),

      titleMedium: TextStyle(
        color: AppColors.gold100,
        fontFamily: "janna",
      ),

      titleSmall: TextStyle(
        color: AppColors.gold300,
        fontFamily: "janna",
      ),

      // Body
      bodyLarge: TextStyle(
        color: AppColors.gold100,
        fontFamily: "janna",
      ),

      bodyMedium: TextStyle(
        color: AppColors.gold200,
        fontFamily: "janna",
      ),

      bodySmall: TextStyle(
        color: AppColors.gold300,
        fontFamily: "janna",
      ),

      // Labels
      labelLarge: TextStyle(
        color: AppColors.black,
        fontFamily: "janna",
        fontWeight: FontWeight.bold,
      ),
    ),

    iconTheme: const IconThemeData(
      color: AppColors.gold400,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.gold500,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.black700,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.gold500,
      foregroundColor: AppColors.black,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold500,
        foregroundColor: AppColors.black,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontFamily: "janna",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
