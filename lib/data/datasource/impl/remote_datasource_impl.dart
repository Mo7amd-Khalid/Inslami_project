import 'package:injectable/injectable.dart';
import 'package:islami_app/data/datasource/contrarct/remote_datasource.dart';
import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/data/network/safeCall.dart';
import 'package:islami_app/domain/models/radio_dm.dart';

import '../../../domain/models/reciters_dm.dart';
import '../../network/api_client.dart';

@Injectable(as: RemoteDatasource)
class RemoteDatasourceImpl implements RemoteDatasource{

  RemoteDatasourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<Results<RadioDm>> getRadiosChannels() {
    return safeCall(()async{
      var response = await _apiClient.getRadiosChannels();
      return Success(data: response);
    });
  }

  @override
  Future<Results<RecitersDm>> getReciters() {
    return safeCall(()async{
      var response = await _apiClient.getReciters();
      return Success(data: response);
    });
  }
}