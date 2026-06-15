import 'package:flutter/material.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/domain/models/bookmark_dm.dart';

import '../../core/utils/context_func.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key, required this.bookmarkData, this.isSelected = false});
  final BookmarkDm bookmarkData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? AppColors.gold800 : Colors.transparent,
      ),
      child: ListTile(
        title: Text(bookmarkData.ayah,style: context.textStyle.titleMedium, overflow: TextOverflow.ellipsis,),
        leading: Icon(Icons.bookmark),
        subtitle: Text("Surah ${bookmarkData.surahName} - Ayah ${bookmarkData.ayahNumber}"),
      ),
    );
  }
}
