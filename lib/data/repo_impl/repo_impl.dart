import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/data/datasource/contrarct/local_datasource.dart';
import 'package:islami_app/data/network/results.dart';
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
}