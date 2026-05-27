import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/model/sura-dm.dart';
import 'package:islami_app/presentation/display_content/cubit/display_content_contract.dart';

@injectable
class DisplayContentCubit
    extends BaseCubit<DisplayContentState, DisplayContentAction, void> {
  DisplayContentCubit() : super(DisplayContentState());

  @override
  Future<void> doAction(DisplayContentAction action) async {
    switch (action) {
      case GetContentOfSura():
        getContentOfSura(action.sura);
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
      content = "$content ${ayas[i].trim()} {${i + 1}}";
    }
    emit(
      state.copyWith(
        content: Resources.success(data: content),
      ),
    );
  }
}
