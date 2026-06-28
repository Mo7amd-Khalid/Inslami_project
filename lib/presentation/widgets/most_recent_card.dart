import 'package:flutter/material.dart';
import 'package:islami_app/core/constant/assets.dart';
import 'package:islami_app/core/utils/context_func.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import '../../core/theme/app_colors.dart';



class MostRecentCard extends StatelessWidget {
  const MostRecentCard({required this.sura,required this.onClick, super.key});
  final SurahDm sura;
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
                Text(sura.nameEn!, style: context.textStyle.titleMedium!.copyWith(color: AppColors.white),),
                Text(sura.nameAr!, style: context.textStyle.titleMedium!.copyWith(color: AppColors.white),),
                Text(sura.versesCount.toString(), style: context.textStyle.titleMedium!.copyWith(color: AppColors.white),),
              ],
            ),
            Image.asset(AppImages.mostRecentImage),

          ],
        ),
      ),
    );
  }
}
