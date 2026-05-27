import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/model/sura-dm.dart';

class DisplayContentState {
  Resources<String> content;
  Resources<String> titleEn;
  Resources<String> titleAr;

  DisplayContentState({
    this.content = const Resources.initial(),
    this.titleEn = const Resources.initial(),
    this.titleAr = const Resources.initial(),
  });

  DisplayContentState copyWith({
    Resources<String>? content,
    Resources<String>? titleEn,
    Resources<String>? titleAr,
  })
  {
    return DisplayContentState(
      content: content ?? this.content,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
    );
  }
}

sealed class DisplayContentAction {}
class GetContentOfSura extends DisplayContentAction {
  SuraDM sura;
  GetContentOfSura(this.sura);
}