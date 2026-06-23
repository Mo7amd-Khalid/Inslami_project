import 'package:flutter/material.dart';
import 'package:islami_app/core/constant/image.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/bookmark_view.dart';
import 'package:islami_app/presentation/tabs/radio_and_reciters_tab/radio_and_reciters_tab.dart';

import '../../tabs/hadeth_tab/hadeth_tab.dart';
import '../../tabs/sebha_tab/sebha_tab.dart';
import '../../../UI/tabs/time_tab/time_tab.dart';
import '../../tabs/quran_tab/quran_tab.dart';

class HomeStates{
  List<Widget> tabs = [
    QuranTabScreen(),
    HadethTabScreen(),
    SebhaTabScreen(),
    RadioAndRecitersTab(),
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
  Resources<List<QuranDm>> quran;

  HomeStates({this.currentIndex = 0, this.quran = const Resources.initial()});

  HomeStates copyWith({int? currentIndex, Resources<List<QuranDm>>? quran}){
    return HomeStates(currentIndex: currentIndex ?? this.currentIndex, quran: quran ?? this.quran);
  }
}

sealed class HomeActions{}
class ChangeCurrentIndex extends HomeActions{
  int newIndex;
  ChangeCurrentIndex(this.newIndex);
}
class LoadAllAyat extends HomeActions{}

sealed class HomeNavigation{}