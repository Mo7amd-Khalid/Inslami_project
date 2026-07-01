import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/domain/models/prayer_dm.dart';
import 'package:islami_app/domain/models/radio_dm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';

abstract class RemoteDatasource {
  Future<Results<RadioDm>> getRadiosChannels();
  Future<Results<RecitersDm>> getReciters();

  Future<Results<PrayerDm>> getPrayerTimes(String lat, String long, int? method, int? school);
}