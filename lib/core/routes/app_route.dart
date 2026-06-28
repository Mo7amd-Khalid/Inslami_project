import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:islami_app/domain/models/all_azkar_dm.dart';
import 'package:islami_app/domain/models/hadeth_dm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';
import 'package:islami_app/presentation/display_ayat/display_ayat_screen.dart';
import 'package:islami_app/presentation/display_azkar/display_azkar_view.dart';
import 'package:islami_app/presentation/home/home_screen.dart';
import 'package:islami_app/core/routes/routes.dart';
import 'package:islami_app/presentation/onboarding/onboarding_screen.dart';
import 'package:islami_app/presentation/reciter/reciter_view.dart';
import 'package:islami_app/presentation/widgets/hadeth_display_screen.dart';


abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigating to: ${settings.name}');
    }

    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case Routes.onboardingViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OnBoardingScreen(),
        );
      case Routes.homeViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );
      case Routes.displayAyatViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DisplayAyatScreen(
            arguments: settings.arguments as Map<String, dynamic>,
          ),
        );
      case Routes.displayHadethViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HadethDisplayScreen(
            hadith: settings.arguments as HadethDM,
          ),
        );
      case Routes.reciterViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ReciterView(
            reciter: settings.arguments as Reciters,
          ),
        );
      case Routes.azkarView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DisplayAzkarView(
            azkar: settings.arguments as AllAzkarDm,
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Page Not Found')),
              ),
        );
    }
  }
}
