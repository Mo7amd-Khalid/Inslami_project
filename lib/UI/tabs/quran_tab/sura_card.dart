import 'package:flutter/material.dart';

import '../../../core/style/colors.dart';
import '../../../core/style/text_style.dart';
import '../../../model/suraDM.dart';


class SuraCard extends StatelessWidget{
  final SuraDM sura;
  final Function(int) onClick;
  SuraCard({required this.sura, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClick(sura.suraNumber);

      },
      child: Row(
        spacing: 10,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/img_sur_number_frame.png",
                color: AppColors.white,
                width: MediaQuery.of(context).size.width*0.15,
              ),
              Text(
                sura.suraNumber.toString(),
                style: AppTextStyle.smallLabel(color: AppColors.white),
              ),
            ],
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sura.nameEN,
                    style: AppTextStyle.smallLabel(color: AppColors.white),
                  ),
                  Text(
                    sura.numberOfAyats,
                    style: AppTextStyle.smallLabel(color: AppColors.white),
                  ),
                ],
              )),
          Text(
            sura.nameAR,
            style: AppTextStyle.smallLabel(color: AppColors.white),
          ),
        ],
      ),
    );
  }


}