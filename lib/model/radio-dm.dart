import 'package:dio/dio.dart';

class RadioDM{
  static List<dynamic>? radios;
  static List<dynamic>? reciters;


  static Future<void> getRadioChannels() async{
    var response = await Dio().get(
        "https://mp3quran.net/api/v3/radios",
      queryParameters: {"language" : "en"}
    );
    radios = response.data["radios"];
  }

  static Future<void> getReciters() async{
    var response = await Dio().get(
      "https://www.mp3quran.net/api/v3/reciters",
        queryParameters: {"language" : "en"}
    );
    reciters = response.data["reciters"];
  }
}