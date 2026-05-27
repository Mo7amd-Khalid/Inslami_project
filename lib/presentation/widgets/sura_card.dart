import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';
import '../../model/sura-dm.dart';


class SuraCard extends StatelessWidget{
  final SuraDM sura;
  final Future<void> Function() onClick;
  const SuraCard({required this.sura, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
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
                style: context.textStyle.titleMedium,
              ),
            ],
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sura.nameEN,
                    style: context.textStyle.titleMedium,
                  ),
                  Text(
                    sura.numberOfAyats,
                    style: context.textStyle.titleMedium,
                  ),
                ],
              )),
          Text(
            sura.nameAR,
            style: context.textStyle.titleMedium,
          ),
        ],
      ),
    );
  }


}