import 'package:intl/intl.dart';
import 'package:islami_app/domain/models/prayer_dm.dart';

abstract class PrayerMapperClass{
  static final List<String> _prayerNames = [
    "Fajr",
    "Dhuhr",
    "Asr",
    "Maghrib",
    "Isha",
  ];
  static Map<String, DateTime> convertPrayerToLisOfPrayers(PrayerTimes times){
    Map<String, DateTime> prayers = {};

    if(times.fajr.isNotEmpty){
      prayers[_prayerNames[0]] = DateFormat("HH:mm").parse(times.fajr);
    }
    if(times.dhuhr.isNotEmpty){
      prayers[_prayerNames[1]] = DateFormat("HH:mm").parse(times.dhuhr);
    }
    if(times.asr.isNotEmpty){
      prayers[_prayerNames[2]] = DateFormat("HH:mm").parse(times.asr);
    }
    if(times.maghrib.isNotEmpty){
      prayers[_prayerNames[3]] = DateFormat("HH:mm").parse(times.maghrib);
    }
    if(times.isha.isNotEmpty){
      prayers[_prayerNames[4]] = DateFormat("HH:mm").parse(times.isha);
    }

    return prayers;
  }

  static Map<String, dynamic> getNextPrayerName(Map<String, DateTime> prayerTimes){
    Map<String, dynamic> nextPrayer = {};
    String prayerName = prayerTimes.keys.firstWhere((prayerName) {
      DateTime timeNow =DateFormat("HH:mm").parse(DateFormat("HH:mm").format(DateTime.now()));
      return prayerTimes[prayerName]!.millisecondsSinceEpoch > timeNow.millisecondsSinceEpoch;
    });
    int index = _prayerNames.indexOf(prayerName);
    nextPrayer["name"] = prayerName;
    nextPrayer["index"] = index;
    return nextPrayer;
  }

}