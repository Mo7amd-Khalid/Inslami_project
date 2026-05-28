import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/repository/repo.dart';
import 'package:islami_app/model/sura-dm.dart';
import 'package:islami_app/presentation/tabs/quran_tab/cubit/quran_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class QuranCubit extends BaseCubit<QuranState, QuranActions, QuranNavigation> {
  QuranCubit(this._preferences, this._repo) : super(QuranState());

  final SharedPreferences _preferences;
  final RepositoryContract _repo;

  @override
  Future<void> doAction(QuranActions action) async {
    switch (action) {
      case GetSurasList():
        getSurasList();
      case GetMostResentData():
        getMostResentData();
      case GoToSuraScreen():
        goToSuraScreen(action.context, action.sura);
      case StoreInMostRecentData():
        storeInMostRecentData(action.context, action.suraNumber);
      case UpdateSearchList():
        updateSearchList(action.input);

    }
  }

  void getSurasList() {
    List<SuraDM> suras = [];
    for (int i = 0; i < state.englishSuraName.length; i++) {
      suras.add(SuraDM(
          suraNumber: i + 1,
          nameAR: state.arabicSuraName[i],
          nameEN: state.englishSuraName[i],
          numberOfAyats: state.ayatsNumber[i]));
    }
    emit(state.copyWith(suras: Resources.success(data: suras)));
  }

  void getMostResentData() {
    var data = _preferences.getStringList(AppKeywords.mostRecentKeyword) ?? [];
    List<SuraDM> mostRecent = [];
    for (String suraNumber in data) {
      mostRecent.add(state.suras.data![int.parse(suraNumber) - 1]);
    }
    emit(state.copyWith(mostRecent: Resources.success(data: mostRecent)));
  }

  void storeInMostRecentData(BuildContext context, int suraNumber) async{
    var data = _preferences.getStringList(AppKeywords.mostRecentKeyword) ?? [];
    if(data.contains(suraNumber.toString()))
      {
        data.remove(suraNumber.toString());
      }
    data = [suraNumber.toString(),...data];
    await _repo.saveDataInSharedPreferences(context, AppKeywords.mostRecentKeyword, data);
    getMostResentData();

  }

  void goToSuraScreen(BuildContext context, SuraDM sura) async{
    storeInMostRecentData(context, sura.suraNumber);
    emitNavigation(NavigateToSuraScreen(sura));
  }

  void updateSearchList(String input) {
    List<SuraDM>? search = [];
    if(input.isNotEmpty)
      {
        search = state.suras.data!.where((sura){
          return sura.nameAR.contains(input);
        }).toList();

        if(search.isEmpty)
          {
            search = state.suras.data!.where((sura){
              return sura.nameEN.contains(input);
            }).toList();
          }
      }
    else
      {
        search = null;
      }
    emit(state.copyWith(search: Resources.success(data: search)));

  }




}