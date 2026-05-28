import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/cubit/bookmark_contract.dart';
import 'package:islami_app/presentation/tabs/quran_tab/cubit/quran_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/keywords.dart';
import '../../../../core/utils/resources.dart';
import '../../../../model/sura-dm.dart';

@injectable
class BookmarkCubit extends BaseCubit<BookmarkStates, BookmarkActions, BookmarkNavigations>{
  BookmarkCubit(this._preferences) : super(BookmarkStates());

  final SharedPreferences _preferences;
  final QuranCubit _quranCubit = getIt();
  @override
  Future<void> doAction(BookmarkActions action) async{

    switch(action) {
      case GetMostResentData():
        getMostRecentData();
    }
  }

  void getMostRecentData() {
    var data = _preferences.getStringList(AppKeywords.mostRecentKeyword) ?? [];
    List<SuraDM> mostRecent = [];
    for (String suraNumber in data) {
      mostRecent.add(_quranCubit.state.suras.data![int.parse(suraNumber) - 1]);
    }
    emit(state.copyWith(mostRecent: Resources.success(data: mostRecent)));
  }

}