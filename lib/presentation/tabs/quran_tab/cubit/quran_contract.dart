import 'package:flutter/material.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/models/surah_dm.dart';

class QuranState {
  Resources<List<SurahDm>> suras;
  Resources<List<SurahDm>> mostRecent;
  Resources<List<SurahDm>> search;
  Resources<String> contentOfSura;

  QuranState({
    this.suras = const Resources.initial(),
    this.mostRecent = const Resources.initial(),
    this.search = const Resources.initial(),
    this.contentOfSura = const Resources.initial(),
  });

  QuranState copyWith({
    Resources<List<SurahDm>>? suras,
    Resources<List<SurahDm>>? mostRecent,
    Resources<List<SurahDm>>? search,
    Resources<String>? contentOfSura,
  }) {
    return QuranState(
      suras: suras ?? this.suras,
      mostRecent: mostRecent ?? this.mostRecent,
      search: search ?? this.search,
      contentOfSura: contentOfSura ?? this.contentOfSura,
    );
  }
}

sealed class QuranActions {}

class GetSurahList extends QuranActions {}

class GoToSuraScreen extends QuranActions {
  SurahDm sura;
  BuildContext context;

  GoToSuraScreen(this.context, this.sura);
}

class StoreInMostRecentData extends QuranActions {
  int suraNumber;
  BuildContext context;

  StoreInMostRecentData(this.context, this.suraNumber);
}

class UpdateSearchList extends QuranActions{
  String input;
  UpdateSearchList(this.input);
}


sealed class QuranNavigation {}

class NavigateToSuraScreen extends QuranNavigation {
  SurahDm sura;
  NavigateToSuraScreen(this.sura);
}
