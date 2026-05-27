import 'package:flutter/material.dart';
import 'package:islami_app/core/utils/context_func.dart';
import '../../core/theme/app_colors.dart';
import '../../model/sura-dm.dart';



class MostRecentCard extends StatelessWidget {
  const MostRecentCard({required this.sura,required this.onClick, super.key});
  final SuraDM sura;
  final Future<void> Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.gold600,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sura.nameEN, style: context.textStyle.titleMedium!.copyWith(color: AppColors.white),),
                Text(sura.nameAR, style: context.textStyle.titleMedium!.copyWith(color: AppColors.white),),
                Text(sura.numberOfAyats, style: context.textStyle.titleMedium!.copyWith(color: AppColors.white),),
              ],
            ),
            Image.asset("assets/images/img_most_recent.png"),

          ],
        ),
      ),
    );
  }
}
