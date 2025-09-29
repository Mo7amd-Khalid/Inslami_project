import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/UI/tabs/hadeth_tab/hadeth_display_screen.dart';
import 'package:islami_app/core/style/colors.dart';
import 'package:islami_app/core/style/text_style.dart';
import 'package:islami_app/model/hadeth_dm.dart';

class HadethTabScreen extends StatefulWidget {
  const HadethTabScreen({super.key});

  @override
  State<HadethTabScreen> createState() => _HadethTabScreenState();
}

class _HadethTabScreenState extends State<HadethTabScreen> {

  @override
  void initState() {
    super.initState();
    HadethDM.hadethCollectData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/hadith_bg.png"),
              fit: BoxFit.cover,

          ),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.black.withAlpha(70),
                AppColors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/img_header.png",
                  color: AppColors.gold,
                  width: MediaQuery.of(context).size.width*0.6,
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:16.0),
                    child: CarouselSlider(
                        items: HadethDM.hadeths.map((hadeth) => InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, HadethDisplayScreen.routeName, arguments: hadeth);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: AppColors.gold,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/HadithCardBackGround.png"),
                              )
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/img_left_corner.png",
                                        color: AppColors.black,
                                      ),
                                      Expanded(child: Text(
                                        textAlign: TextAlign.center,
                                          hadeth.title,
                                        style: AppTextStyle.largeLabel(color: AppColors.black),
                                      )),
                                      Image.asset("assets/images/img_right_corner.png",color: AppColors.black,),
                                    ],
                                  ),
                                ),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                      hadeth.content,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.largeBody(color: AppColors.black).copyWith(
                                      height: 2,
                                    ),
                          
                                  ),
                                )),
                                Image.asset(
                                  "assets/images/Mosque_Hadeth.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,)
                              ],
                            ),
                          
                          ),
                        )).toList(),
                        options: CarouselOptions(
                            height: double.infinity, 
                            enableInfiniteScroll: true, 
                            viewportFraction: 0.83, 
                            animateToClosest: true, 
                            enlargeCenterPage: true, 
                            initialPage: 0
                        )),
                  )
              ),

            ],
          ),
        ),
      )
    );
  }
}
