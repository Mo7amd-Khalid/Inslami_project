import 'dart:convert';

import 'package:flutter/services.dart';

class AzkarDM{

  String category;
  String count;
  String description;
  String content;

  AzkarDM({required this.category, required this.count, required this.description, required this.content});


  static List<AzkarDM> eveningAzkar = [];
  static List<AzkarDM> morningAzkar = [];
  static List<AzkarDM> prayingAzkar = [];
  static List<AzkarDM> tasabeehAzkar = [];
  static List<AzkarDM> wakingUpAzkar = [];
  static List<AzkarDM> sleepingAzkar = [];

  static Future<void> getAzkarData()async{
    var response = await rootBundle.loadString("assets/azkar/azkar.json_files");
    var data = await jsonDecode(response);
    for(var item in data["أذكار الصباح"])
      {
        morningAzkar.add(AzkarDM(
          category: item["category"],
            count: item["count"],
            description: item["description"],
            content: item["content"]));
      }

    for(var item in data["أذكار المساء"])
    {
      eveningAzkar.add(AzkarDM(
          category: item["category"],
          count: item["count"],
          description: item["description"],
          content: item["content"]));
    }

    for(var item in data["أذكار بعد السلام من الصلاة المفروضة"])
    {
      prayingAzkar.add(AzkarDM(
          category: item["category"],
          count: item["count"],
          description: item["description"],
          content: item["content"]));
    }

    for(var item in data["تسابيح"])
    {
      tasabeehAzkar.add(AzkarDM(
          category: item["category"],
          count: item["count"],
          description: item["description"],
          content: item["content"]));
    }

    for(var item in data["أذكار النوم"])
    {
      sleepingAzkar.add(AzkarDM(
          category: item["category"],
          count: item["count"],
          description: item["description"],
          content: item["content"]));
    }

    for(var item in data["أذكار الاستيقاظ"])
    {
      wakingUpAzkar.add(AzkarDM(
          category: item["category"],
          count: item["count"],
          description: item["description"],
          content: item["content"]));
    }

  }
}