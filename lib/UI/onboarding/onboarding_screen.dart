import 'package:flutter/material.dart';
import 'package:islami_app/UI/home/home_screen.dart';
import 'package:islami_app/core/style/colors.dart';
import 'package:islami_app/core/style/text_style.dart';
import 'package:islami_app/model/onboarding_dm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = "OnBoarding Screen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingDM> onboarding = [
    OnBoardingDM(
        image: "assets/images/onboarding/onboarding 1.png",
        title: "Welcome To Islmi App"),

    OnBoardingDM(
        image: "assets/images/onboarding/onboarding 2.png",
        title: "Welcome To Islami",
        content: "We Are Very Excited To Have You In Our Community"
    ),

    OnBoardingDM(
        image: "assets/images/onboarding/onboarding 3.png",
        title: "Reading the Quran",
        content: "Read, and your Lord is the Most Generous"
    ),

    OnBoardingDM(
        image: "assets/images/onboarding/onboarding 4.png",
        title: "Bearish",
        content: "Praise the name of your Lord, the Most High"
    ),

    OnBoardingDM(
        image: "assets/images/onboarding/onboarding 5.png",
        title: "Holy Quran Radio",
        content: "You can listen to the Holy Quran Radio through the application for free and easily"
    ),


  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                    "assets/images/img_header.png",
                  width: MediaQuery.of(context).size.width*0.7,
                  color: AppColors.gold,
                ),
              ),
              SizedBox(height: 25,),
              Expanded(
                flex: 9,
                  child: Image.asset(
                    onboarding[currentIndex].image,
                  ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  onboarding[currentIndex].title,
                  style: AppTextStyle.largeTitle(),),
              ),
              if(onboarding[currentIndex].content != null)
                Expanded(
                flex: 2,
                child: Text(
                  onboarding[currentIndex].content!,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.mediumTitle(),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(

                      onPressed: currentIndex != 0 ? (){
                        if(currentIndex != 0)
                        {
                          currentIndex--;
                        }
                        setState(() {});
                      } : null,
                      child: Text(
                        currentIndex != 0? "Back" : "",
                        style: AppTextStyle.smallLabel(),
                      )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: AnimatedSmoothIndicator(
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppColors.gold,
                          expansionFactor: 2,
                          dotHeight: 10,
                          dotWidth: 10

                        ),
                          count: onboarding.length,
                        activeIndex: currentIndex,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        if(currentIndex != 4)
                          {
                            currentIndex++;
                          }
                        else
                          {
                            closeOnBoarding(context);
                          }

                        setState(() {});
                      },
                      child: Text(
                          currentIndex == 4? "Finish" : "Next",
                        style: AppTextStyle.smallLabel(),
                      )),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> closeOnBoarding(context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("onboarding", false);
    Navigator.pushNamed(context, HomeScreen.routeName);
    setState(() {});
  }
}
