import 'package:flutter/material.dart';

import '../../core/style/colors.dart';
import '../tabs/hadeth_tab/hadeth_tab.dart';
import '../tabs/quran_tab/quran_tab.dart';
import '../tabs/radio_tab.dart';
import '../tabs/sebha_tab.dart';
import '../tabs/time_tab.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "Home Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  List<Widget> tabs = [
    QuranTabScreen(),
    HadethTabScreen(),
    SebhaTabScreen(),
    RadioTabScreen(),
    TimeTabScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColors.gold,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.white,
          onTap: (index){
          currentIndex = index;
          setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: boxDecoration(currentIndex == 0),
                    child: ImageIcon(AssetImage("assets/icons/quran.png"))),
              label: "Quran"
            ),
            BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: boxDecoration(currentIndex == 1),
                    child: ImageIcon(AssetImage("assets/icons/hadeth.png"))),
              label: "Hadeth"
            ),
            BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: boxDecoration(currentIndex == 2),
                    child: ImageIcon(AssetImage("assets/icons/sebha.png"))),
              label: "Sebha"
            ),
            BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: boxDecoration(currentIndex == 3),
                    child: ImageIcon(AssetImage("assets/icons/radio.png"))),
                label: "Radio"
            ),
            BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: boxDecoration(currentIndex == 4),
                    child: ImageIcon(AssetImage("assets/icons/time.png"))),
                label: "Time"
            ),
          ]),
    );
  }

  BoxDecoration boxDecoration(bool selected){
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.black.withAlpha(selected ? 60 : 0)
    );
  }
}
