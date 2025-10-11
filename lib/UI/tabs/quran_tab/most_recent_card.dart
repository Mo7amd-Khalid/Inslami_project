import 'package:flutter/material.dart';

import '../../../core/style/colors.dart';
import '../../../core/style/text_style.dart';
import '../../../model/sura-dm.dart';



class MostRecentCard extends StatelessWidget {
  const MostRecentCard({required this.sura,required this.onClick, super.key});
  final SuraDM sura;
  final Function(int) onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClick(sura.suraNumber);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sura.nameEN, style: AppTextStyle.mediumTitle(color: AppColors.black),),
                Text(sura.nameAR, style: AppTextStyle.mediumTitle(color: AppColors.black),),
                Text(sura.numberOfAyats, style: AppTextStyle.mediumTitle(color: AppColors.black),),
              ],
            ),
            Image.asset("assets/images/img_most_recent.png"),

          ],
        ),
      ),
    );
  }
}
