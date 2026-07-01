import 'package:flutter/material.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/models/all_azkar_dm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import '../../network/results.dart';

abstract class LocalDatasource {
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
  Future<Results<List<QuranDm>>> loadAllAyat(String path);
  Future<Results<List<SurahDm>>> getSurahDetails(String path);
  Future<Results<List<AllAzkarDm>>> getAllAzkar();
}