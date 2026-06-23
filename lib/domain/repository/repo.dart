import 'package:flutter/material.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';

import '../../data/network/results.dart';
import '../models/radio_dm.dart';

abstract class RepositoryContract{
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
  Future<Results<List<QuranDm>>> loadAllAyat(String path);
  Future<Results<List<SurahDm>>> getSurahDetails(String path);

  Future<Results<RadioDm>> getRadiosChannels();
  Future<Results<RecitersDm>> getReciters();

}