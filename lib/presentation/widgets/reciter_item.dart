import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';

class ReciterItem extends StatelessWidget {
  const ReciterItem({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.gold800,
      child: Text(
        title,
        style: context.textStyle.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
