import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/domain/models/prayer_dm.dart';
import 'package:islami_app/domain/models/radio_dm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../../core/constant/app_api.dart';

part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: AppApi.radioAndReciterBaseUrl)
abstract class RadioAndReciterApiClient {
  @factoryMethod
  factory RadioAndReciterApiClient(Dio dio) = _RadioAndReciterApiClient;

  @GET(AppApi.getRadiosChannels)
  Future<RadioDm> getRadiosChannels();

  @GET(AppApi.getReciters)
  Future<RecitersDm> getReciters();
}

@singleton
@RestApi(baseUrl: AppApi.prayersBaseUrl)
abstract class PrayerApiClient {
  @factoryMethod
  factory PrayerApiClient(Dio dio) = _PrayerApiClient;

  @GET(AppApi.getPrayerTimes)
  Future<PrayerDm> getPrayerTimes(
    @Query("api_key") String apiKey,
    @Query("lat") String lat,
    @Query("lon") String long,
    @Query("method") int? method,
    @Query("school") int? school,
  );
}
