import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../model/sura-dm.dart';
import '../../widget/content_display_screen.dart';




class QuranDetailsScreen extends StatefulWidget {
  const QuranDetailsScreen({super.key});
  static const String routeName = "Quran Details Screen";

  @override
  State<QuranDetailsScreen> createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  late SuraDM sura;

  String? ayas;

  @override
  Widget build(BuildContext context) {
    sura = ModalRoute.of(context)?.settings.arguments as SuraDM;
    if(ayas == null)
      {
        getSuraAyas(sura.suraNumber);
      }

    return ContentDisplayScreen(
      titleEN: sura.nameEN,
      titleAR: sura.nameAR,
      content: ayas,
    );
  }

  Future<void> getSuraAyas(int suraNumber) async{
        String content = await rootBundle.loadString("assets/Suras/$suraNumber.txt");
        List<String> ayas = content.trim().split("\n");
        content = "";
        for(int i = 0; i < ayas.length; i++)
          {
            content = "$content ${ayas[i].trim()} {${i+1}}";
          }
        this.ayas = content;
        setState(() {});
  }
}
