import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
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
}
