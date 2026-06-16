import 'package:flutter/material.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/utils/padding.dart';
import 'package:islami_app/domain/models/hadeth_dm.dart';

import '../../core/utils/context_func.dart';


class HadethDisplayScreen extends StatelessWidget {
  const HadethDisplayScreen({super.key, required this.hadith});
  final HadethDM hadith;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gold50,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.gold600,
        foregroundColor: AppColors.white,
        title: Text(
          hadith.title,
          style: context.textStyle.titleMedium!.copyWith(
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: RichText(
            textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: hadith.content,
                    style: context.textStyle.bodyLarge!.copyWith(
                      color: AppColors.gold800,
                      height: 2,
                    )
              )),
        ),
      ).allPadding(12),
    );
  }
}
