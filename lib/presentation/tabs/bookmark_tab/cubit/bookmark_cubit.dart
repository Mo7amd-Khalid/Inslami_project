import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/generate_bookmark.dart';
import 'package:islami_app/domain/models/bookmark_dm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/cubit/bookmark_contract.dart';
import 'package:islami_app/presentation/tabs/quran_tab/cubit/quran_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/keywords.dart';
import '../../../../core/utils/resources.dart';

@injectable
class BookmarkCubit
    extends BaseCubit<BookmarkStates, BookmarkActions, BookmarkNavigations> {
  BookmarkCubit(this._preferences) : super(BookmarkStates());

  final SharedPreferences _preferences;
  final QuranCubit _quranCubit = getIt();

  @override
  Future<void> doAction(BookmarkActions action) async {
    switch (action) {
      case GetMostResentData():
        getMostRecentData();
      case GetAllBookmarks():
        getAllBookmarks();
      case GoToSurahScreen():
        goToSurahScreen(
          action.suraName,
          action.suraPage,
          action.surahId,
          action.context,
        );
      case AddToSelectedBookmark():
        addToSelectedBookmark(action.bookmark);
      case ChangeSelectionMode():
        changeSelectionMode(action.selectionMode);
      case RemoveToSelectedBookmark():
        removeFromSelectedBookmark(action.bookmark);
      case DeleteBookmarks():
        deleteFromBookMark(action.deletedList);
    }
  }

  void getMostRecentData() {
    var data = _preferences.getStringList(AppKeywords.mostRecentKeyword) ?? [];
    List<SurahDm> mostRecent = [];
    for (String suraNumber in data) {
      mostRecent.add(_quranCubit.state.suras.data![int.parse(suraNumber) - 1]);
    }
    emit(state.copyWith(mostRecent: Resources.success(data: mostRecent)));
  }

  void getAllBookmarks() {
    var data = _preferences.getStringList(AppKeywords.bookMarksKeyword) ?? [];
    List<BookmarkDm> allBookmarks =
        data.map((bookmark) {
          List<String> bookmarkData = bookmark.split("\n");
          return BookmarkDm(
            surahName: bookmarkData[1],
            ayah: bookmarkData[2],
            ayahNumber: int.parse(bookmarkData[0]),
            pageNumber: int.parse(bookmarkData[3]),
          );
        }).toList();
    final reversedBookmark = allBookmarks.reversed.toList();
    emit(
      state.copyWith(allBookmark: Resources.success(data: reversedBookmark)),
    );
  }

  void goToSurahScreen(
    String surahName,
    int surahPage,
    int? surahId,
    BuildContext context,
  ) {
    if (surahId != null) {
      _quranCubit.storeInMostRecentData(context, surahId);
    }
    emitNavigation(NavigateToSurahScreen(surahName, surahPage));
    getMostRecentData();
  }

  void addToSelectedBookmark(BookmarkDm bookmark) {
    List<BookmarkDm> selectedBookmarks = state.selectedBookmark.data ?? [];
    selectedBookmarks.add(bookmark);
    emit(
      state.copyWith(
        selectedBookmark: Resources.success(data: selectedBookmarks),
      ),
    );
  }

  void removeFromSelectedBookmark(BookmarkDm bookmark) {
    List<BookmarkDm> selectedBookmarks = state.selectedBookmark.data ?? [];
    selectedBookmarks.remove(bookmark);
    emit(
      state.copyWith(
        selectedBookmark: Resources.success(data: selectedBookmarks),
      ),
    );
  }

  void deleteFromBookMark(List<BookmarkDm> deletedList) async {
    List<BookmarkDm> allBookmarks = state.allBookmark.data ?? [];
    for (BookmarkDm item in deletedList) {
      allBookmarks.remove(item);
    }
    emit(
      state.copyWith(
        allBookmark: Resources.success(data: allBookmarks),
        selectedBookmark: Resources.success(data: []),
      ),
    );
    List<String> newBookMarks = [];
    for (BookmarkDm item in allBookmarks) {
      String newBookmark = generateBookmark(
        ayahNumber: item.ayahNumber,
        surahName: item.surahName,
        ayah: item.ayah,
        pageNumber: item.pageNumber,
      );
      newBookMarks.add(newBookmark);
    }
    await _preferences.setStringList(
      AppKeywords.bookMarksKeyword,
      newBookMarks,
    );
  }

  void changeSelectionMode(bool selectionMode) {
    emit(state.copyWith(selectionMode: selectionMode));
  }
}
