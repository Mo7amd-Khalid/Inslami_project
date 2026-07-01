import 'package:flutter/material.dart';
import 'package:islami_app/core/utils/context_func.dart';
import 'package:islami_app/core/utils/white_spaces.dart';
import 'package:islami_app/domain/models/all_azkar_dm.dart';
import 'package:islami_app/domain/models/zekr_dm.dart';

import '../../core/theme/app_colors.dart';

class DisplayAzkarView extends StatelessWidget {
  const DisplayAzkarView({required this.azkar,super.key});
  final AllAzkarDm azkar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gold50,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.gold600,
        foregroundColor: AppColors.white,
        title: Text(azkar.zekrName),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
          itemBuilder: (_,index) {
            ZekrDm zekr = azkar.content[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
            children: [
              Expanded(child:  zekr.description.isEmpty ?
              Text(
                zekr.content,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                style: context.textStyle.bodyLarge!.copyWith(color: AppColors.gold700),
                textDirection: TextDirection.rtl,
              ) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    zekr.content,
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyle.bodyLarge!.copyWith(color: AppColors.gold700, ),
                    textDirection: TextDirection.rtl,),
                  Text(
                    zekr.description,
                    maxLines: 100,
                    style: context.textStyle.bodyMedium!.copyWith(color: AppColors.gray,fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,),
                ],
              )),
              CircleAvatar(
                child: Text(zekr.count),
                backgroundColor: AppColors.gold600,
              ),
            ],
                      );
          },
          separatorBuilder: (_,_) => (context.heightSize *0.03).verticalSpace,
          itemCount: azkar.content.length),
    );
  }
}
