import 'package:flutter/material.dart';
import 'package:islami_app/model/hadeth_dm.dart';

import '../../widget/content_display_screen.dart';

class HadethDisplayScreen extends StatelessWidget {
  const HadethDisplayScreen({super.key});
  static const String routeName = "Hadeth Display Screen";



  @override
  Widget build(BuildContext context) {
    var hadith = ModalRoute.of(context)!.settings.arguments as HadethDM;
    return ContentDisplayScreen(
      titleAR: hadith.title,
      titleEN: "Hadith ${hadith.hadethNumber}",
      content: hadith.content,

    );
  }
}
