import 'package:flutter/material.dart';
import 'package:islami_app/UI/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/home/home_screen.dart';
import 'UI/tabs/hadeth_tab/hadeth_display_screen.dart';
import 'UI/tabs/quran_tab/quran_details_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? onboarding = preferences.getBool("onboarding");
  runApp(MyApp(onboarding: onboarding,));
}

class MyApp extends StatelessWidget {
  const MyApp({this.onboarding, super.key});

  final bool? onboarding;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        OnBoardingScreen.routeName : (_) => OnBoardingScreen(),
        HomeScreen.routeName : (_) => HomeScreen(),
        QuranDetailsScreen.routeName : (_) => QuranDetailsScreen(),
        HadethDisplayScreen.routeName : (_) => HadethDisplayScreen()
      },
      initialRoute: onboarding == null? OnBoardingScreen.routeName : HomeScreen.routeName,
    );
  }
}


