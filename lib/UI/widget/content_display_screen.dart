import 'package:flutter/material.dart';

import '../../core/style/colors.dart';
import '../../core/style/text_style.dart';

class ContentDisplayScreen extends StatelessWidget {
  const ContentDisplayScreen({required this.titleAR, required this.titleEN, required this.content, super.key});
  final String titleEN;
  final String titleAR;
  final String? content;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold,
        title: Text(titleEN,style: AppTextStyle.mediumTitle(),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("assets/images/img_left_corner.png"),
                Expanded(child:
                Text(
                  titleAR,
                  style: AppTextStyle.mediumTitle(),
                  textAlign: TextAlign.center,
                )),
                Image.asset("assets/images/img_right_corner.png"),
              ],
            ),
            content == null?
            CircularProgressIndicator(
              color: AppColors.gold,
            ) :
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  content!,
                  style: AppTextStyle.largeBody().copyWith(
                    height: 2.5,
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/images/Mosque-02.png",
              color: AppColors.gold,)
          ],
        ),
      ),
    );
  }
}
