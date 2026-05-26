import 'package:flutter/material.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_route.dart';
import 'core/routes/routes.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  SharedPreferences preferences = getIt();
  bool? onboarding = preferences.getBool(AppKeywords.onboardingKeyword);
  runApp(MyApp(onboarding: onboarding,));
}

class MyApp extends StatelessWidget {
  const MyApp({this.onboarding, super.key});
  final bool? onboarding;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: onboarding == true ? Routes.homeViews : Routes.onboardingViews,
    );
  }
}


