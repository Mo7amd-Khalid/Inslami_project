import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/data/datasource/contrarct/local_datasource.dart';
import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:islami_app/domain/repository/repo.dart';

@Injectable(as: RepositoryContract)
class RepoImpl extends RepositoryContract{

  RepoImpl(this._localDatasource);
  final LocalDatasource _localDatasource;

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
  Future<Results<List<QuranDm>>> loadAllAyat(String path) async{
    var response = await _localDatasource.loadAllAyat(path);
    switch(response) {
      case Success<List<QuranDm>>():
        return Success(data: response.data,);
      case Failure<List<QuranDm>>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<List<SurahDm>>> getSurahDetails(String path) async{
    var response = await _localDatasource.getSurahDetails(path);
    switch(response) {
      case Success<List<SurahDm>>():
        return Success(data: response.data);
      case Failure<List<SurahDm>>():
        return Failure(exception: response.exception, message: response.message);
    }
  }
}