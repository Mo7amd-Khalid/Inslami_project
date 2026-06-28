import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/models/all_azkar_dm.dart';
import 'package:islami_app/domain/models/prayer_dm.dart';

class PrayerAndAzkarStates {
  Resources<PrayerData> prayerData;
  Resources<List<AllAzkarDm>> allAzkar;

  PrayerAndAzkarStates({this.prayerData = const Resources.initial(), this.allAzkar = const Resources.initial()});

  PrayerAndAzkarStates copyWith({Resources<PrayerData>? prayerData, Resources<List<AllAzkarDm>>? allAzkar}) {
    return PrayerAndAzkarStates(prayerData: prayerData ?? this.prayerData, allAzkar: allAzkar ?? this.allAzkar);
  }
}

sealed class PrayersAndAzkarActions {}

class GetPrayerData extends PrayersAndAzkarActions {
  int? method;
  int? school;

  GetPrayerData({
    this.method,
    this.school,
  });
}

class GetAzkarData extends PrayersAndAzkarActions {

}

class GoToDisplayAzkarScreen extends PrayersAndAzkarActions {
  AllAzkarDm azkar;
  GoToDisplayAzkarScreen({required this.azkar});
}


sealed class PrayersAndAzkarNavigation {}
class NavigateToDisplayAzkarScreen extends PrayersAndAzkarNavigation{
  AllAzkarDm azkar;
  NavigateToDisplayAzkarScreen({required this.azkar});
}
