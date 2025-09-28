import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppTextStyle
{
  static TextStyle largeTitle({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 24,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle mediumTitle({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 22,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle smallTitle({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 20,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle largeLabel({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 22,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle mediumLabel({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 20,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle smallLabel({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 18,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle largeBody({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 16,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mediumBody({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 14,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle smallBody({Color color = AppColors.gold})
  {
    return TextStyle(
      fontSize: 12,
      color: color,
      fontFamily: "janna",
      fontWeight: FontWeight.w400,
    );
  }
}