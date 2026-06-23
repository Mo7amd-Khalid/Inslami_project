import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';

class RadioTabItem extends StatelessWidget {
  const RadioTabItem({super.key, required this.isSelected, required this.title});
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? AppColors.gold800 : AppColors.black,
          borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 8
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: context.textStyle.bodyLarge,
      ),
    );
  }
}
