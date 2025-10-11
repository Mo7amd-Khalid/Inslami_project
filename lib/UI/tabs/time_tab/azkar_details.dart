import 'package:flutter/material.dart';
import 'package:islami_app/model/azkar_dm.dart';

import '../../../core/style/colors.dart';
import '../../../core/style/text_style.dart';

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
        foregroundColor: AppColors.gold,
        title: Text(list[0].category ,style: AppTextStyle.mediumTitle(),),
        centerTitle: true,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
          itemBuilder: (_,index) => Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.gold,
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
                        style: AppTextStyle.largeBody(color: AppColors.black).copyWith(
                          fontSize: 18
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.black,
                      radius: 26,
                      child: Text(list[index].count,style: AppTextStyle.mediumBody(),),
                    ),
                  ],
                ),
                if(list[index].description != "")
                  Text(
                    list[index].description.trim(),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: AppTextStyle.largeBody(color: AppColors.gray),
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
