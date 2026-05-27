import 'package:flutter/material.dart';
import 'package:islami_app/model/azkar_dm.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';


class AzkarDetails extends StatelessWidget {
  const AzkarDetails({super.key});
  static const String routeName = "Azkar Details";

  @override
  Widget build(BuildContext context) {
    var list = ModalRoute.of(context)!.settings.arguments as List<AzkarDM>;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold500,
        title: Text(list[0].category ,style: context.textStyle.titleMedium,),
        centerTitle: true,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
          itemBuilder: (_,index) => Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.gold500,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Text(
                        list[index].content,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.start,
                        style: context.textStyle.titleMedium!.copyWith(
                          fontSize: 18
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.black,
                      radius: 26,
                      child: Text(list[index].count,style: context.textStyle.titleMedium,),
                    ),
                  ],
                ),
                if(list[index].description != "")
                  Text(
                    list[index].description.trim(),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: context.textStyle.titleMedium,
                  ),

              ],
            ),
          ),
          separatorBuilder: (_,_) => SizedBox(
            height: 20,
          ),
          itemCount: list.length)
    );
  }
}
