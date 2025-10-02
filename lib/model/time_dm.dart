import 'package:dio/dio.dart';

class TimeDM{
  static Map<dynamic, dynamic>? prays;
  static Map<dynamic, dynamic>? dateHigri;
  static Map<dynamic, dynamic>? dateMeladi;


  Future<void> getData(String date, String city) async{
    var response = await Dio().get(
        "https://api.aladhan.com/v1/timingsByCity/$date",
        queryParameters: {'city' : city, 'country' : 'egypt'}
    );
    prays = response.data["data"]["timings"];
    dateHigri = response.data["data"]["date"]["hijri"];
    dateMeladi = response.data["data"]["date"]["gregorian"];


  }

}