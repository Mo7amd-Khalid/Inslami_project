import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/repository/repo.dart';
import 'package:islami_app/model/sura-dm.dart';
import 'package:islami_app/presentation/display_content/cubit/display_content_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class DisplayContentCubit
    extends BaseCubit<DisplayContentState, DisplayContentAction, void> {
  DisplayContentCubit(this._repo, this._preferences) : super(DisplayContentState());

  final RepositoryContract _repo;
  final SharedPreferences _preferences;

  @override
  Future<void> doAction(DisplayContentAction action) async {
    switch (action) {
      case GetContentOfSura():
        getContentOfSura(action.sura);
      case ChangeSelectedAya():
        changeSelectedAya(action.selectedAya);
      case ChangeAppBarStatus():
        changeAppBarStatus(action.appBarStatus);
      case SaveBookMark():
        saveBookMark(action.context, action.ayaNumber);
      case GetBookMarks():
        getBookMarks(action.context);
      case RemoveBookMark():
        removeBookMark(action.context, action.ayaNumber);
    }
  }

  void getContentOfSura(SuraDM sura) async {
    emit(state.copyWith(
      content: Resources.loading(),
      titleAr: Resources.success(data: sura.nameAR),
      titleEn: Resources.success(data: sura.nameEN),),);
    String content = "";
    content = await rootBundle.loadString(
      "assets/Suras/${sura.suraNumber}.txt",
    );
    List<String> ayas = content.trim().split("\n");
    content = "";
    for (int i = 0; i < ayas.length; i++) {
      ayas[i] = "${ayas[i].trim()} {${i + 1}} ";
    }
    emit(
      state.copyWith(
        content: Resources.success(data: ayas),
      ),
    );
  }

  void changeSelectedAya(int selectedAya) {
    emit(state.copyWith(selectedAya: Resources.success(data: selectedAya)));
  }

  void changeAppBarStatus(bool status) {
    emit(state.copyWith(appBarStatus: Resources.success(data: status)));
  }

  void saveBookMark(BuildContext context, int ayaNumber) async{
    String newBookmark = "$ayaNumber ${state.titleEn.data}";
    List<String> allBookmarks = _preferences.getStringList(AppKeywords.bookMarksKeyword) ?? [];
    allBookmarks.add(newBookmark);
    await _repo.saveDataInSharedPreferences(context, AppKeywords.bookMarksKeyword, allBookmarks);
    getBookMarks(context);
  }

  void getBookMarks(BuildContext context) {
    List<String> allBookmarks = _preferences.getStringList(AppKeywords.bookMarksKeyword) ?? [];;
    List<int> suraBookmark = [];
    for(String bookmark in allBookmarks)
      {
        if(bookmark.split(" ")[1] == state.titleEn.data!)
        {
          suraBookmark.add(int.parse(bookmark.split(" ")[0]));
        }
      }
    emit(state.copyWith(bookMarks: Resources.success(data: suraBookmark)));
  }

  void removeBookMark(BuildContext context, int ayaNumber) async{
    String oldBookmark = "$ayaNumber ${state.titleEn.data}";
    List<String> allBookmarks = _preferences.getStringList(AppKeywords.bookMarksKeyword) ?? [];
    allBookmarks.remove(oldBookmark);
    await _repo.saveDataInSharedPreferences(context, AppKeywords.bookMarksKeyword, allBookmarks);
    getBookMarks(context);
  }
}
