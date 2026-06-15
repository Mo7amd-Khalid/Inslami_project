import 'package:flutter/material.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';


class SuraCard extends StatelessWidget{
  final SurahDm sura;
  final Future<void> Function() onClick;
  const SuraCard({super.key, required this.sura, required this.onClick});

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
                sura.id.toString(),
                style: context.textStyle.titleMedium,
              ),
            ],
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sura.nameEn!,
                    style: context.textStyle.titleMedium,
                  ),
                  Text(
                    sura.versesCount.toString(),
                    style: context.textStyle.titleMedium,
                  ),
                ],
              )),
          Text(
            sura.nameAr!,
            style: context.textStyle.titleMedium,
          ),
        ],
      ),
    );
  }


}