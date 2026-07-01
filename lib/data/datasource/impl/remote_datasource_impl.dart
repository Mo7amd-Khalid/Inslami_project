import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/data/datasource/contrarct/remote_datasource.dart';
import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/data/network/safeCall.dart';
import 'package:islami_app/domain/models/prayer_dm.dart';
import 'package:islami_app/domain/models/radio_dm.dart';

import '../../../domain/models/reciters_dm.dart';
import '../../network/api_client.dart';

@Injectable(as: RemoteDatasource)
class RemoteDatasourceImpl implements RemoteDatasource{

  RemoteDatasourceImpl(this._radioAndReciterApiClient, this._prayerApiClient);
  final RadioAndReciterApiClient _radioAndReciterApiClient;
  final PrayerApiClient _prayerApiClient;

  @override
  Future<Results<RadioDm>> getRadiosChannels() {
    return safeCall(()async{
      var response = await _radioAndReciterApiClient.getRadiosChannels();
      return Success(data: response);
    });
  }

  @override
  Future<Results<RecitersDm>> getReciters() {
    return safeCall(()async{
      var response = await _radioAndReciterApiClient.getReciters();
      return Success(data: response);
    });
  }

  @override
  Future<Results<PrayerDm>> getPrayerTimes(String lat, String long, int? method, int? school) {
    return safeCall(()async{
      final apiKey = dotenv.env['API_KEY'];
      var response = await _prayerApiClient.getPrayerTimes(apiKey!, lat, long, method, school);

      if(response.code == 200)
        {
          return Success(data: response, message: response.status);
        }
      else
        {
          return Failure(exception: Exception(response.message), message: response.message);
        }
    });
  }
}