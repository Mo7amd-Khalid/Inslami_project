import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';


class SebhaTabScreen extends StatefulWidget {
  const SebhaTabScreen({super.key});

  @override
  State<SebhaTabScreen> createState() => _SebhaTabScreenState();
}

class _SebhaTabScreenState extends State<SebhaTabScreen> {
  double turns = 0.0;

  int counter = 0;
  int zekr = 0;
  List<String> azkar = [
    "سبحان الله",
    "الحمد الله",
    "لا إله إلا الله",
    "الله اكبر",
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/sebha_bg.png"),fit: BoxFit.cover)
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin:Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black.withAlpha(70),
                AppColors.black,
              ],
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 50,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/img_header.png",
                    color: AppColors.gold500,
                    width: size.width*0.6,
                  ),
                ),
                Text(
                    "سَبِّحِ اسْمَ رَبِّكَ الأعلى ",
                  style: context.textStyle.titleMedium,
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/Group 37.png",
                      width: size.width*0.4,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children:[
                        AnimatedRotation(
                            turns: turns,
                            duration: Duration(milliseconds: 450),
                          child: Image.asset(
                            "assets/images/SebhaBody 1.png",
                            width: size.width*0.9,
                            height: size.height*0.42,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            turns += (12 / 360);
                            if(counter < 132) {
                              if(counter != 0 && counter % 33 == 0)
                              {
                                zekr++;
                              }
                              counter++;

                            }
                            else
                              {
                                counter = 0;
                                zekr = 0;
                              }
                            setState(() {});
                          },
                          child: SizedBox(
                            width: size.width*0.9,
                            height: size.height*0.42,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 15,
                              children: [
                                Text(
                                    azkar[zekr%4],
                                  style: context.textStyle.titleMedium!.copyWith(
                                    fontSize: 26
                                  ),
                            
                                ),
                                Text(
                                    counter.toString(),
                                  style: context.textStyle.titleMedium!.copyWith(
                                      fontSize: 26
                                  ),
                            
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
