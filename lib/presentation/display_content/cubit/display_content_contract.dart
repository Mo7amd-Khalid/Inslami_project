import 'package:flutter/material.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/model/sura-dm.dart';

class DisplayContentState {
  Resources<List<String>> content;
  Resources<String> titleEn;
  Resources<String> titleAr;
  Resources<int> selectedAya;
  Resources<bool> appBarStatus;
  Resources<List<int>> bookMarks;

  DisplayContentState({
    this.content = const Resources.initial(),
    this.titleEn = const Resources.initial(),
    this.titleAr = const Resources.initial(),
    this.selectedAya = const Resources.initial(),
    this.appBarStatus = const Resources.initial(),
    this.bookMarks = const Resources.initial(),
  });

  DisplayContentState copyWith({
    Resources<List<String>>? content,
    Resources<String>? titleEn,
    Resources<String>? titleAr,
    Resources<int>? selectedAya,
    Resources<bool>? appBarStatus,
    Resources<List<int>>? bookMarks,
  }) {
    return DisplayContentState(
      content: content ?? this.content,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
      selectedAya: selectedAya ?? this.selectedAya,
      appBarStatus: appBarStatus ?? this.appBarStatus,
      bookMarks: bookMarks ?? this.bookMarks
    );
  }
}

sealed class DisplayContentAction {}

class GetContentOfSura extends DisplayContentAction {
  SuraDM sura;

  GetContentOfSura(this.sura);
}

class ChangeSelectedAya extends DisplayContentAction {
  int selectedAya;

  ChangeSelectedAya(this.selectedAya);
}

class ChangeAppBarStatus extends DisplayContentAction {
  bool appBarStatus;

  ChangeAppBarStatus(this.appBarStatus);
}

class SaveBookMark extends DisplayContentAction {
  BuildContext context;
  int ayaNumber;

  SaveBookMark(this.context, this.ayaNumber);
}
class RemoveBookMark extends DisplayContentAction {
  BuildContext context;
  int ayaNumber;

  RemoveBookMark(this.context, this.ayaNumber);
}

class GetBookMarks extends DisplayContentAction {
  BuildContext context;
  GetBookMarks(this.context);
}
