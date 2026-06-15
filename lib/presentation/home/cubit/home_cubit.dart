import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/presentation/home/cubit/home_contract.dart';
import '../../../core/utils/resources.dart';

@singleton
class HomeCubit extends BaseCubit<HomeStates, HomeActions, HomeNavigation>{
  HomeCubit() : super(HomeStates());

  @override
  Future<void> doAction(HomeActions action) async{
    switch(action) {
      case ChangeCurrentIndex():
        changeCurrentIndex(action.newIndex);
      case LoadAllAyat():
        loadAllAyat();
    }
  }

  void changeCurrentIndex(int newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }

  void loadAllAyat() async{
    final testFile = await rootBundle.loadString(
      'assets/json_files/merged_quran_updated.json',
    );
    final List<dynamic> testQuran = json.decode(testFile);
    List<QuranDm> quran = testQuran.map((json) => QuranDm.fromJson(json)).toList();
    emit(state.copyWith(quran: Resources.success(data: quran),));
  }


}