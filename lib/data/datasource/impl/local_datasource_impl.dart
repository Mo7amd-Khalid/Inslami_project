import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/constant/assets.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/models/all_azkar_dm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/models/zekr_dm.dart';
import '../../network/results.dart';
import '../../network/safeCall.dart';
import '../contrarct/local_datasource.dart';


@Injectable(as: LocalDatasource)
class LocalDatasourceImpl implements LocalDatasource {
  LocalDatasourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context,
      String key,
      dynamic value,) async {
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
    return safeCall(() async {
      final testFile = await rootBundle.loadString(
        path,
      );
      final List<dynamic> testQuran = json.decode(testFile);
      List<QuranDm> quran = testQuran
          .map((json) => QuranDm.fromJson(json))
          .toList();
      if (quran.isEmpty) {
        return Failure(exception: Exception("Something went wrong"),
            message: "Something went wrong");
      }
      return Success(data: quran);
    });
  }

  @override
  Future<Results<List<SurahDm>>> getSurahDetails(String path) {
    return safeCall(() async {
      final jsonString = await rootBundle.loadString(path);
      final List<dynamic> jsonList = json.decode(jsonString);
      List<SurahDm> surahList = jsonList
          .map((json) => SurahDm.fromJson(json))
          .toList();
      if (surahList.isEmpty) {
        return Failure(exception: Exception(
          "Something went wrong",
        ), message: "Something went wrong");
      }
      return Success(data: surahList);
    });
  }

  @override
  Future<Results<List<AllAzkarDm>>> getAllAzkar() {
    return safeCall(() async {
      final jsonString = await rootBundle.loadString(AppJsonFiles.allAzkarPath);
      final dynamic data = json.decode(jsonString);
      List<AllAzkarDm> allAzkar = [];
      List<ZekrDm> morningAzkar = [];
      List<ZekrDm> eveningAzkar = [];
      List<ZekrDm> afterPrayingAzkar = [];
      List<ZekrDm> tasabeeh = [];
      List<ZekrDm> sleepingAzkar = [];
      List<ZekrDm> wakingUpAzkar = [];
      for (var item in data["أذكار الصباح"]) {
        morningAzkar.add(ZekrDm(
            category: item["category"],
            count: item["count"],
            description: item["description"],
            content: item["content"]));
      }
      allAzkar.add(AllAzkarDm(
        content: morningAzkar,
        zekrImage: AppImages.morningAzkar,
        zekrName: AppKeywords.morningAzkar
      ));


      for (var item in data["أذكار المساء"]) {
        eveningAzkar.add(ZekrDm(
            category: item["category"],
            count: item["count"],
            description: item["description"],
            content: item["content"]));
      }
      allAzkar.add(AllAzkarDm(
          content: eveningAzkar,
          zekrImage: AppImages.eveningAzkar,
          zekrName: AppKeywords.eveningAzkar
      ));

      for (var item in data["أذكار بعد السلام من الصلاة المفروضة"]) {
        afterPrayingAzkar.add(ZekrDm(
            category: item["category"],
            count: item["count"],
            description: item["description"],
            content: item["content"]));
      }
      allAzkar.add(AllAzkarDm(
          content: afterPrayingAzkar,
          zekrImage: AppImages.afterPrayingAzkar,
          zekrName: AppKeywords.afterPrayingAzkar
      ));



      for (var item in data["تسابيح"]) {
        tasabeeh.add(ZekrDm(
            category: item["category"],
            count: item["count"],
            description: item["description"],
            content: item["content"]));
      }
      allAzkar.add(AllAzkarDm(
          content: tasabeeh,
          zekrImage: AppImages.tasabeeh,
          zekrName: AppKeywords.tasabeeh
      ));


      for (var item in data["أذكار النوم"]) {
        sleepingAzkar.add(ZekrDm(
            category: item["category"],
            count: item["count"],
            description: item["description"],
            content: item["content"]));
      }
      allAzkar.add(AllAzkarDm(
          content: sleepingAzkar,
          zekrImage: AppImages.sleepingAzkar,
          zekrName: AppKeywords.sleepingAzkar
      ));


      for (var item in data["أذكار الاستيقاظ"]) {
        wakingUpAzkar.add(ZekrDm(
            category: item["category"],
            count: item["count"],
            description: item["description"],
            content: item["content"]));
      }
      allAzkar.add(AllAzkarDm(
          content: wakingUpAzkar,
          zekrImage: AppImages.wakingUpAzkar,
          zekrName: AppKeywords.wakingUpAzkar
      ));


      if (allAzkar.isEmpty) {
        return Failure(exception: Exception(
          "Something went wrong",
        ), message: "Something went wrong");
      }

      return Success(data: allAzkar);
    });
  }
}
