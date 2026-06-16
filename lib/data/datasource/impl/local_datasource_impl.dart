import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/results.dart';
import '../../network/safeCall.dart';
import '../contrarct/local_datasource.dart';


@Injectable(as: LocalDatasource)
class LocalDatasourceImpl implements LocalDatasource {
  LocalDatasourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<Results<void>> saveDataInSharedPreferences(
      BuildContext context,
    String key,
    dynamic value,
  ) async {
    return safeCall(() async {
      if (value is String ||
          value is int ||
          value is bool ||
          value is double ||
          value is List<String>) {
        if (value is String) {
          await _sharedPreferences.setString(key, value);
        } else if (value is int) {
          await _sharedPreferences.setInt(key, value);
        } else if (value is bool) {
          await _sharedPreferences.setBool(key, value);
        } else if (value is double) {
          await _sharedPreferences.setDouble(key, value);
        } else if (value is List<String>) {
          await _sharedPreferences.setStringList(key, value);
        }
        return Success();
      } else {
        return Failure(
          exception: Exception(), message: 'SharedPreferences Error',
        );
      }
    });
  }

  @override
  Future<Results<List<QuranDm>>> loadAllAyat(String path) {
    return safeCall(()async{
      final testFile = await rootBundle.loadString(
        path,
      );
      final List<dynamic> testQuran = json.decode(testFile);
      List<QuranDm> quran = testQuran.map((json) => QuranDm.fromJson(json)).toList();
      if(quran.isEmpty)
        {
          return Failure(exception: Exception("Something went wrong"), message: "Something went wrong");
        }
      return Success(data: quran);
    });
  }

  @override
  Future<Results<List<SurahDm>>> getSurahDetails(String path) {
    return safeCall(()async{
      final jsonString = await rootBundle.loadString(path);
      final List<dynamic> jsonList = json.decode(jsonString);
      List<SurahDm> surahList = jsonList
          .map((json) => SurahDm.fromJson(json))
          .toList();
      if(surahList.isEmpty)
        {
          return Failure(exception: Exception(
            "Something went wrong",
          ), message: "Something went wrong");
        }
      return Success(data: surahList);
    });
  }
}
