import 'package:flutter/material.dart';
import 'package:islami_app/domain/models/bookmark_dm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';

import '../../../../core/utils/resources.dart';

class BookmarkStates {
  Resources<List<SurahDm>> mostRecent;
  Resources<List<BookmarkDm>> allBookmark;
  Resources<List<BookmarkDm>> selectedBookmark;
  bool selectionMode;

  BookmarkStates({
    this.mostRecent = const Resources.initial(),
    this.allBookmark = const Resources.initial(),
    this.selectedBookmark = const Resources.initial(),
    this.selectionMode = false,
  });

  BookmarkStates copyWith({
    Resources<List<SurahDm>>? mostRecent,
    Resources<List<BookmarkDm>>? allBookmark,
    Resources<List<BookmarkDm>>? selectedBookmark,
    bool? selectionMode,
  }) {
    return BookmarkStates(
      mostRecent: mostRecent ?? this.mostRecent,
      allBookmark: allBookmark ?? this.allBookmark,
      selectedBookmark: selectedBookmark ?? this.selectedBookmark,
      selectionMode: selectionMode ?? this.selectionMode
    );
  }
}

sealed class BookmarkActions {}

class GetMostResentData extends BookmarkActions {}

class GoToSurahScreen extends BookmarkActions {
  String suraName;
  int suraPage;
  int? surahId;
  BuildContext context;

  GoToSurahScreen({
    required this.context,
    required this.suraName,
    required this.suraPage,
    this.surahId,
  });
}

class GetAllBookmarks extends BookmarkActions {}

class AddToSelectedBookmark extends BookmarkActions {
  BookmarkDm bookmark;
  AddToSelectedBookmark(this.bookmark);
}
class RemoveToSelectedBookmark extends BookmarkActions {
  BookmarkDm bookmark;
  RemoveToSelectedBookmark(this.bookmark);
}

class ChangeSelectionMode extends BookmarkActions {
  bool selectionMode;
  ChangeSelectionMode(this.selectionMode);
}

class DeleteBookmarks extends BookmarkActions{
  List<BookmarkDm> deletedList;
  DeleteBookmarks(this.deletedList);
}

sealed class BookmarkNavigations {}

class NavigateToSurahScreen extends BookmarkNavigations {
  String suraName;
  int suraPage;

  NavigateToSurahScreen(this.suraName, this.suraPage);
}
