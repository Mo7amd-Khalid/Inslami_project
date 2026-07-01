import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/domain/models/all_azkar_dm.dart';
import 'package:islami_app/domain/models/prayer_dm.dart';
import 'package:islami_app/domain/repository/repo.dart';
import 'package:islami_app/presentation/tabs/prayers_and_azkar_tab/cubit/prayers_and_azkar_contract.dart';


@injectable
class PrayersAndAzkarCubit extends BaseCubit<PrayerAndAzkarStates, PrayersAndAzkarActions, PrayersAndAzkarNavigation>{
  PrayersAndAzkarCubit(this._repo) : super(PrayerAndAzkarStates());
  final RepositoryContract _repo;

  @override
  Future<void> doAction(PrayersAndAzkarActions action) async{
    switch(action){
      case GetPrayerData():
        _getPrayerData(action.method, action.school);
      case GetAzkarData():
        _getAzkarData();
      case GoToDisplayAzkarScreen():
        goToDisplayAzkarScreen(action.azkar);
    }
  }

  Future<void> _getPrayerData(int? method, int? school) async{
    emit(state.copyWith(prayerData: Resources.loading()));
    var response = await _repo.getPrayerTimes(method, school);
    switch(response) {
      case Success<PrayerData>():
        emit(state.copyWith(prayerData: Resources.success(data: response.data, message: response.message)));
      case Failure<PrayerData>():
        emit(state.copyWith(prayerData: Resources.failure(exception: response.exception, message: response.message)));
    }
  }

  void _getAzkarData() async{
    emit(state.copyWith(allAzkar: Resources.loading()));
    var response = await _repo.getAllAzkar();
    switch(response) {
      case Success<List<AllAzkarDm>>():
        emit(state.copyWith(allAzkar: Resources.success(data: response.data)));
      case Failure<List<AllAzkarDm>>():
        emit(state.copyWith(allAzkar: Resources.failure(exception: response.exception, message: response.message)));
    }
  }

  void goToDisplayAzkarScreen(AllAzkarDm azkar) {
    emitNavigation(NavigateToDisplayAzkarScreen(azkar: azkar));
  }


}