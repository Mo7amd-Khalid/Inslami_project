import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/models/hadeth_dm.dart';
import 'package:islami_app/presentation/tabs/hadeth_tab/cubit/hadeth_contract.dart';

@injectable
class HadethCubit extends BaseCubit<HadethState, HadethAction, HadethNavigation>{
  HadethCubit() : super(HadethState());

  @override
  Future<void> doAction(HadethAction action) async{
    switch(action)
    {
      case GetAllHadeth():
        getAllHadeth();
      case GoToHadethDisplayScreen():
        goToHadethDisplayScreen(action.hadeth);
    }
  }

  void getAllHadeth() async{
    emit(state.copyWith(allHadeth: Resources.loading()));
    List<HadethDM> allHadeth = [];

    for(int i = 1; i <= 50; i++)
      {
        var hadeth = await rootBundle.loadString("assets/hadeeth/h$i.txt");
        var hadethContent = hadeth.trim().split("\n");
        String title = hadethContent[0].trim();
        hadethContent = hadethContent.sublist(1);
        String content = hadethContent.join(" ");
        allHadeth.add(HadethDM(hadethNumber: i, title: title, content: content));
      }
    emit(state.copyWith(allHadeth: Resources.success(data: allHadeth)));

  }

  void goToHadethDisplayScreen(HadethDM hadeth) {
    emitNavigation(NavigateToHadethDisplayScreen(hadeth));
  }


}