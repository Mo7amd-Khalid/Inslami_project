import '../../../../core/utils/resources.dart';
import '../../../../model/sura-dm.dart';

class BookmarkStates{
  Resources<List<SuraDM>> mostRecent;

  BookmarkStates({this.mostRecent = const Resources.initial()});

  BookmarkStates copyWith({Resources<List<SuraDM>>? mostRecent}){
    return BookmarkStates(mostRecent: mostRecent ?? this.mostRecent);
  }

}

sealed class BookmarkActions{}

class GetMostResentData extends BookmarkActions {}

sealed class BookmarkNavigations{}