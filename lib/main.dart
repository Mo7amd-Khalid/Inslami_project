import 'package:flutter/material.dart';
import 'package:islami_app/tabs/quran_tab/quran_details_screen.dart';

import 'home/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName : (_) => HomeScreen(),
        QuranDetailsScreen.routeName : (_) => QuranDetailsScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}

