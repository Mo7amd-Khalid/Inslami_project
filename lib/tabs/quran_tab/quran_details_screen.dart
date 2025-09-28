import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../core/style/colors.dart';
import '../../core/style/text_style.dart';
import '../../model/suraDM.dart';

class QuranDetailsScreen extends StatefulWidget {
  QuranDetailsScreen({super.key});
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

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold,
        title: Text(sura.nameEN,style: AppTextStyle.mediumTitle(),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("assets/images/img_left_corner.png"),
                Expanded(child:
                Text(
                  sura.nameAR,
                  style: AppTextStyle.mediumTitle(),
                  textAlign: TextAlign.center,
                )),
                Image.asset("assets/images/img_right_corner.png"),
              ],
            ),
            ayas == null?
            CircularProgressIndicator(
              color: AppColors.gold,
            ) :
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  ayas!,
                  style: AppTextStyle.largeBody().copyWith(
                    height: 2.5,
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/images/Mosque-02.png",
              color: AppColors.gold,)
          ],
        ),
      ),
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
