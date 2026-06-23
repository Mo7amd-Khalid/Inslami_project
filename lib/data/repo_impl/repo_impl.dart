import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/data/datasource/contrarct/local_datasource.dart';
import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/models/radio_dm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:islami_app/domain/repository/repo.dart';

import '../datasource/contrarct/remote_datasource.dart';

@Injectable(as: RepositoryContract)
class RepoImpl extends RepositoryContract {
  RepoImpl(this._localDatasource, this._remoteDatasource);

  final LocalDatasource _localDatasource;
  final RemoteDatasource _remoteDatasource;

  @override
  Future<Results<void>> saveDataInSharedPreferences(
    BuildContext context,
    String key,
    value,
  ) async {
    var response = await _localDatasource.saveDataInSharedPreferences(
      context,
      key,
      value,
    );
    switch (response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(
          exception: response.exception,
          message: response.message,
        );
    }
  }

  @override
  Future<Results<List<QuranDm>>> loadAllAyat(String path) async {
    var response = await _localDatasource.loadAllAyat(path);
    switch (response) {
      case Success<List<QuranDm>>():
        return Success(data: response.data);
      case Failure<List<QuranDm>>():
        return Failure(
          exception: response.exception,
          message: response.message,
        );
    }
  }

  @override
  Future<Results<List<SurahDm>>> getSurahDetails(String path) async {
    var response = await _localDatasource.getSurahDetails(path);
    switch (response) {
      case Success<List<SurahDm>>():
        return Success(data: response.data);
      case Failure<List<SurahDm>>():
        return Failure(
          exception: response.exception,
          message: response.message,
        );
    }
  }

  @override
  Future<Results<RadioDm>> getRadiosChannels() async {
    List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.none)) {
      return Failure(message: "No internet connection", exception: Exception());
    } else {
      var response = await _remoteDatasource.getRadiosChannels();
      switch (response) {
        case Success<RadioDm>():
          return Success(data: response.data);
        case Failure<RadioDm>():
          return Failure(
            exception: response.exception,
            message: response.message,
          );
      }
    }
  }

  @override
  Future<Results<RecitersDm>> getReciters() async{
    List<ConnectivityResult> result =
    await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.none)) {
      return Failure(message: "No internet connection", exception: Exception());
    } else {
      var response = await _remoteDatasource.getReciters();
      switch (response) {
        case Success<RecitersDm>():
          return Success(data: response.data);
        case Failure<RecitersDm>():
          return Failure(
            exception: response.exception,
            message: response.message,
          );
      }
    }
  }
}
