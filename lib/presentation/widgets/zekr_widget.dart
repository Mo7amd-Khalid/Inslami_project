import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';

class ZekrWidget extends StatelessWidget {
  const ZekrWidget({super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.gold500,
            width: 2,
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset(image,),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textStyle.titleMedium,
          )
        ],
      ),
    );
  }
}
