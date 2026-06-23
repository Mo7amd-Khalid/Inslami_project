import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule{

  @lazySingleton
  Dio provideDio(){
    Dio dio = Dio();
    Map<String, dynamic> headers = {};
    dio.options = BaseOptions(
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      connectTimeout: const Duration(seconds: 120),
      validateStatus: (state){
        return true;
      },
      headers: headers,
    );
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader:true,
      requestBody:true,
      responseHeader:true,
      responseBody:true,
      error:true,
      maxWidth:100,
      compact:true,
      enabled:kDebugMode,
    ));
    return dio;
  }
}