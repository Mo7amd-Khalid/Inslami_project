import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/presentation/home/cubit/home_contract.dart';

@injectable
class HomeCubit extends BaseCubit<HomeStates, HomeActions, HomeNavigation>{
  HomeCubit() : super(HomeStates());

  @override
  Future<void> doAction(HomeActions action) async{
    switch(action) {
      case ChangeCurrentIndex():
        changeCurrentIndex(action.newIndex);
    }
  }

  void changeCurrentIndex(int newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }


}