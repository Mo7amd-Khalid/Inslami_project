import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/constant/asssets.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/data/network/results.dart';
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
    var response = await _repo.getSurahDetails(AppAssets.surahPath);
    switch(response) {
      case Success<List<SurahDm>>():
        emit(state.copyWith(suras: Resources.success(data: response.data)));
      case Failure<List<SurahDm>>():
        emit(state.copyWith(suras: Resources.failure(exception: response.exception, message: response.message)));
    }
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