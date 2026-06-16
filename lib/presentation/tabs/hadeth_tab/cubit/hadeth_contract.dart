import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/models/hadeth_dm.dart';

class HadethState{
  Resources<List<HadethDM>> allHadeth;
  HadethState({this.allHadeth = const Resources.initial()});

  HadethState copyWith({Resources<List<HadethDM>>? allHadeth}){
    return HadethState(allHadeth: allHadeth ?? this.allHadeth);
  }
}

sealed class HadethAction{}
class GetAllHadeth extends HadethAction{}
class GoToHadethDisplayScreen extends HadethAction{
  HadethDM hadeth;
  GoToHadethDisplayScreen(this.hadeth);
}

sealed class HadethNavigation{}
class NavigateToHadethDisplayScreen extends HadethNavigation{
  HadethDM hadeth;
  NavigateToHadethDisplayScreen(this.hadeth);
}