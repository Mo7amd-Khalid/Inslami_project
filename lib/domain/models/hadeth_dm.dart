import 'package:flutter/services.dart';

class HadethDM
{
  int hadethNumber;
  String title;
  String content;

  HadethDM({required this.hadethNumber, required this.title, required this.content});

  static List<HadethDM>? hadeths;

  static Future<void> hadethCollectData() async{
    hadeths = [];
    for(int i = 1; i <= 50; i++ )
      {
        var hadeth = await rootBundle.loadString("assets/hadeeth/h$i.txt");
        var hadethContent = hadeth.trim().split("\n");
        String title = hadethContent[0].trim();
        hadethContent = hadethContent.sublist(1);
        String content = hadethContent.join(" ");
        hadeths!.add(HadethDM(hadethNumber: i, title: title, content: content));
      }
  }
}