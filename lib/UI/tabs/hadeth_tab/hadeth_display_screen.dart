import 'package:flutter/material.dart';
import 'package:islami_app/domain/models/hadeth_dm.dart';

import '../../../presentation/display_content/display_content_screen.dart';

class HadethDisplayScreen extends StatelessWidget {
  const HadethDisplayScreen({super.key});
  static const String routeName = "Hadeth Display Screen";



  @override
  Widget build(BuildContext context) {
    var hadith = ModalRoute.of(context)!.settings.arguments as HadethDM;
    return DisplayContentScreen(
      arguments: {},

    );
  }
}
