import 'package:flutter/material.dart';
import 'package:islami_app/core/constant/image.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/bookmark_view.dart';

import '../../../UI/tabs/hadeth_tab/hadeth_tab.dart';
import '../../../UI/tabs/radio_tab/radio_tab.dart';
import '../../../UI/tabs/sebha_tab/sebha_tab.dart';
import '../../../UI/tabs/time_tab/time_tab.dart';
import '../../tabs/quran_tab/quran_tab.dart';

class HomeStates{
  List<Widget> tabs = [
    QuranTabScreen(),
    HadethTabScreen(),
    SebhaTabScreen(),
    RadioTabScreen(),
    TimeTabScreen(),
    BookmarkView(),
  ];
  List<String> backgroundImages = [
    AppImages.quranScreen,
    AppImages.hadithScreen,
    AppImages.sebhaScreen,
    AppImages.radioScreen,
    AppImages.timeScreen,
    AppImages.quranScreen,
  ];
  int currentIndex;

  HomeStates({this.currentIndex = 0});

  HomeStates copyWith({int? currentIndex}){
    return HomeStates(currentIndex: currentIndex ?? this.currentIndex);
  }
}

sealed class HomeActions{}
class ChangeCurrentIndex extends HomeActions{
  int newIndex;
  ChangeCurrentIndex(this.newIndex);
}

sealed class HomeNavigation{}