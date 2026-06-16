import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/utils/generate_bookmark.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/repository/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'display_ayat_contract.dart';

@injectable
class DisplayContentCubit
    extends BaseCubit<DisplayContentState, DisplayContentAction, void> {
  DisplayContentCubit(this._repo, this._preferences)
    : super(DisplayContentState());

  final RepositoryContract _repo;
  final SharedPreferences _preferences;

  @override
  Future<void> doAction(DisplayContentAction action) async {
    switch (action) {
      case ChangeSelectedAya():
        changeSelectedAya(action.selectedAya);
      case ChangeAppBarStatus():
        changeAppBarStatus(action.appBarStatus);
      case SaveBookMark():
        saveBookMark(action.context, action.ayahNumber, action.ayah, action.pageNumber, action.surahName);
      case GetBookMarks():
        getBookMarks(action.context);
      case RemoveBookMark():
        removeBookMark(action.context, action.ayaNumber, action.ayah, action.pageNumber, action.surahName);

    }
  }


  void changeSelectedAya(String selectedAya) {
    emit(state.copyWith(selectedAyah: selectedAya));
  }

  void changeAppBarStatus(bool status) {
    emit(state.copyWith(appBarStatus: Resources.success(data: status)));
  }

  void saveBookMark(BuildContext context, int ayahNumber, String ayah, int pageNumber, String surahName) async {
    String newBookmark = generateBookmark(
      ayahNumber: ayahNumber,
      surahName: surahName,
      ayah: ayah,
      pageNumber: pageNumber,
    );
    List<String> allBookmarks =
        _preferences.getStringList(AppKeywords.bookMarksKeyword) ?? [];
    allBookmarks.add(newBookmark);
    await _repo.saveDataInSharedPreferences(
      context,
      AppKeywords.bookMarksKeyword,
      allBookmarks,
    );
    getBookMarks(context);
  }

  void getBookMarks(BuildContext context) {
    List<String> allBookmarks =
        _preferences.getStringList(AppKeywords.bookMarksKeyword) ?? [];
    emit(state.copyWith(bookMarks: Resources.success(data: allBookmarks)));
  }

  void removeBookMark(BuildContext context, int ayahNumber, String ayah, int pageNumber, String surahName) async {
    String oldBookmark = generateBookmark(
      ayahNumber: ayahNumber,
      surahName: surahName,
      ayah: ayah,
      pageNumber: pageNumber
    );
    ;
    List<String> allBookmarks =
        _preferences.getStringList(AppKeywords.bookMarksKeyword) ?? [];
    allBookmarks.remove(oldBookmark);
    await _repo.saveDataInSharedPreferences(
      context,
      AppKeywords.bookMarksKeyword,
      allBookmarks,
    );
    getBookMarks(context);
  }

}
