import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:islami_app/presentation/display_content/display_content_screen.dart';
import 'package:islami_app/presentation/home/home_screen.dart';
import 'package:islami_app/core/routes/routes.dart';
import 'package:islami_app/presentation/onboarding/onboarding_screen.dart';


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
      case Routes.displayContentViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DisplayContentScreen(
            arguments: settings.arguments as Map<String, dynamic>,
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
