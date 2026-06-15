import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:islami_app/domain/repository/repo.dart';
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
      case GoToSuraScreen():
        goToSuraScreen(action.context, action.sura);
      case StoreInMostRecentData():
        storeInMostRecentData(action.context, action.suraNumber);
      case UpdateSearchList():
        updateSearchList(action.input);
      case GetSurahList():
        getSurahList();

    }
  }

  Future<void> getSurahList() async{
    final jsonString = await rootBundle.loadString('assets/json_files/surah.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    List<SurahDm> surahList = jsonList
        .map((json) => SurahDm.fromJson(json))
        .toList();
    emit(state.copyWith(suras: Resources.success(data: surahList)));
  }

  void storeInMostRecentData(BuildContext context, int suraNumber) async{
    var data = _preferences.getStringList(AppKeywords.mostRecentKeyword) ?? [];
    if(data.contains(suraNumber.toString()))
      {
        data.remove(suraNumber.toString());
      }
    data = [suraNumber.toString(),...data];
    await _repo.saveDataInSharedPreferences(context, AppKeywords.mostRecentKeyword, data);
  }

  void goToSuraScreen(BuildContext context, SurahDm sura) async{
    storeInMostRecentData(context, sura.id!);
    emitNavigation(NavigateToSuraScreen(sura));
  }

  void updateSearchList(String input) {
    List<SurahDm>? search = [];
    if(input.isNotEmpty)
      {
        search = state.suras.data!.where((sura){
          return sura.nameAr!.toLowerCase().contains(input);
        }).toList();

        if(search.isEmpty)
          {
            search = state.suras.data!.where((sura){
              return sura.nameEn!.toLowerCase().contains(input);
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