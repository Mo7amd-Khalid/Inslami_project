import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/constant/assets.dart';
import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/repository/repo.dart';
import 'package:islami_app/presentation/home/cubit/home_contract.dart';
import '../../../core/utils/resources.dart';

@singleton
class HomeCubit extends BaseCubit<HomeStates, HomeActions, HomeNavigation>{
  HomeCubit(this._repo) : super(HomeStates());
  
  final RepositoryContract _repo;
  
  @override
  Future<void> doAction(HomeActions action) async{
    switch(action) {
      case ChangeCurrentIndex():
        changeCurrentIndex(action.newIndex);
      case LoadAllAyat():
        loadAllAyat();
    }
  }

  void changeCurrentIndex(int newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }

  void loadAllAyat() async{
    var response = await _repo.loadAllAyat(AppJsonFiles.ayatPath);
    switch(response) {
      case Success<List<QuranDm>>():
        emit(state.copyWith(quran: Resources.success(data: response.data),));
      case Failure<List<QuranDm>>():
        emit(state.copyWith(quran: Resources.failure(exception: response.exception, message: response.message),));
    }

  }


}