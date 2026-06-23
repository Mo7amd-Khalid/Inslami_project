import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/domain/models/radio_dm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';
import 'package:retrofit/retrofit.dart';
import '../../core/constant/app_api.dart';

part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: AppApi.radioAndReciterBaseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(AppApi.getRadiosChannels)
  Future<RadioDm> getRadiosChannels();

  @GET(AppApi.getReciters)
  Future<RecitersDm> getReciters();

}
