import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/presentation/tabs/sebha_tab/cubit/sebha_contract.dart';

@injectable
class SebhaCubit extends BaseCubit<SebhaState, SebhaAction, void>{
  SebhaCubit() : super(SebhaState());

  @override
  Future<void> doAction(SebhaAction action) async{
    switch(action) {
      case ClickOnSebha():
        clickOnSebha(action.turns, action.counter, action.zekr);
      case ResetCounter():
        resetCounter();
    }
  }

  void clickOnSebha(double turns, int counter, int zekr) {
    turns += (12 / 360);
    if(counter < 132) {
      if(counter != 0 && counter % 33 == 0)
      {
        zekr++;
      }
      counter++;

    }
    else
    {
      counter = 0;
      zekr = 0;
    }
    emit(state.copyWith(turns: turns, counter: counter, zekr: zekr));
  }

  void resetCounter() {
    emit(state.copyWith(turns: 0.0, counter: 0, zekr: 0));
  }

}