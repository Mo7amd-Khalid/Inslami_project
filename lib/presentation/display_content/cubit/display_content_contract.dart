import 'package:flutter/material.dart';
import 'package:islami_app/core/utils/resources.dart';

class DisplayContentState {
  String selectedAyah;
  Resources<bool> appBarStatus;
  Resources<List<String>> bookMarks;


  DisplayContentState({
    this.selectedAyah = "",
    this.appBarStatus = const Resources.initial(),
    this.bookMarks = const Resources.initial(),
  });

  DisplayContentState copyWith({
    Resources<String>? surahNameEn,
    Resources<String>? surahNameAr,
    String? selectedAyah,
    Resources<bool>? appBarStatus,
    Resources<List<String>>? bookMarks,
  }) {
    return DisplayContentState(
      selectedAyah: selectedAyah ?? this.selectedAyah,
      appBarStatus: appBarStatus ?? this.appBarStatus,
      bookMarks: bookMarks ?? this.bookMarks,
    );
  }
}

sealed class DisplayContentAction {}


class ChangeSelectedAya extends DisplayContentAction {
  String selectedAya;

  ChangeSelectedAya(this.selectedAya);
}

class ChangeAppBarStatus extends DisplayContentAction {
  bool appBarStatus;

  ChangeAppBarStatus(this.appBarStatus);
}

class SaveBookMark extends DisplayContentAction {
  BuildContext context;
  int ayahNumber;
  String ayah;
  int pageNumber;
  String surahName;

  SaveBookMark(this.context, this.ayahNumber, this.ayah, this.pageNumber, this.surahName);
}

class RemoveBookMark extends DisplayContentAction {
  BuildContext context;
  int ayaNumber;
  String ayah;
  int pageNumber;
  String surahName;

  RemoveBookMark(this.context, this.ayaNumber, this.ayah, this.pageNumber, this.surahName);
}

class GetBookMarks extends DisplayContentAction {
  BuildContext context;

  GetBookMarks(this.context);
}
