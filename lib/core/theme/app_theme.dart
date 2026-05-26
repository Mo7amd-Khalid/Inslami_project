import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.blue50,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      // 🔵 Primary
      primary: AppColors.blue600,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.blue100,
      onPrimaryContainer: AppColors.blue700,

      // 🟣 Secondary
      secondary: AppColors.indigo500,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.blue50,
      onSecondaryContainer: AppColors.blue700,

      // 🟢 Tertiary
      tertiary: AppColors.green500,
      onTertiary: AppColors.white,
      tertiaryContainer: AppColors.green100,
      onTertiaryContainer: AppColors.green900,

      // 🔴 Error
      error: AppColors.red600,
      onError: AppColors.white,
      errorContainer: AppColors.red100,
      onErrorContainer: AppColors.red900,

      // ⚪ Surface
      surface: AppColors.white,
      onSurface: AppColors.gray900,
      surfaceContainerHighest: AppColors.gray50,
      onSurfaceVariant: AppColors.gray600,

      // 🔳 Borders
      outline: AppColors.gray200,

      shadow: AppColors.black,
      scrim: AppColors.black,

      inverseSurface: AppColors.gray900,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.blue500,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blue600,
      foregroundColor: AppColors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.blue600,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.all(16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue600,
        side: const BorderSide(color: AppColors.blue600),
        padding: const EdgeInsets.all(16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.green500,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gray300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gray300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.blue600, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.red600),
      ),
      hintStyle: const TextStyle(color: AppColors.gray600),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.gray900),
      titleMedium: TextStyle(color: AppColors.gray900),
      titleSmall: TextStyle(color: AppColors.gray900),
      bodyLarge: TextStyle(color: AppColors.gray900),
      bodyMedium: TextStyle(color: AppColors.gray900),
      bodySmall: TextStyle(color: AppColors.gray900),
      labelLarge: TextStyle(color: AppColors.gray900),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.blue600,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.gray200,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.blue500,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF0F172A),

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      // 🔵 Primary
      primary: AppColors.blue500,
      onPrimary: AppColors.gray900,
      primaryContainer: AppColors.blue700,
      onPrimaryContainer: AppColors.white,

      // 🟣 Secondary
      secondary: AppColors.blue100,
      onSecondary: AppColors.gray900,
      secondaryContainer: AppColors.blue700,
      onSecondaryContainer: AppColors.white,

      // 🟢 Tertiary
      tertiary: AppColors.green500,
      onTertiary: AppColors.gray900,
      tertiaryContainer: AppColors.green900,
      onTertiaryContainer: AppColors.white,

      // 🔴 Error
      error: AppColors.red600,
      onError: AppColors.white,
      errorContainer: AppColors.red900,
      onErrorContainer: AppColors.white,

      // ⚫ Surface
      surface: AppColors.gray900,
      onSurface: AppColors.white,
      surfaceContainerHighest: AppColors.gray600,
      onSurfaceVariant: AppColors.gray300,

      outline: AppColors.gray600,

      shadow: AppColors.black,
      scrim: AppColors.black,

      inverseSurface: AppColors.gray50,
      onInverseSurface: AppColors.gray900,
      inversePrimary: AppColors.blue600,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F172A),
      foregroundColor: AppColors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.blue500,
        foregroundColor: AppColors.gray900,
        padding: const EdgeInsets.all(16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue100,
        side: const BorderSide(color: AppColors.blue100),
        padding: const EdgeInsets.all(16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.green500,
      foregroundColor: AppColors.gray900,
      elevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E293B),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gray600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gray600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.blue500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.red600),
      ),
      hintStyle: const TextStyle(color: AppColors.gray300),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.white),
      titleMedium: TextStyle(color: AppColors.white),
      titleSmall: TextStyle(color: AppColors.white),
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
      bodySmall: TextStyle(color: AppColors.gray300),
      labelLarge: TextStyle(color: AppColors.white),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF0F172A),
      selectedItemColor: AppColors.blue500,
      unselectedItemColor: AppColors.gray300,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gray600,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
