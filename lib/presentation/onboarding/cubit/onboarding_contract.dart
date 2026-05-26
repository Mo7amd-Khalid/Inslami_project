import 'package:flutter/material.dart';

import '../../../core/constant/image.dart';
import '../../../model/onboarding_dm.dart';

class OnboardingState{
  List<OnBoardingDM> onboarding = [
    OnBoardingDM(
        image: AppImages.onboarding1,
        title: "Welcome To Islmi App"),

    OnBoardingDM(
        image: AppImages.onboarding2,
        title: "Welcome To Islami",
        content: "We Are Very Excited To Have You In Our Community"
    ),

    OnBoardingDM(
        image: AppImages.onboarding3,
        title: "Reading the Quran",
        content: "Read, and your Lord is the Most Generous"
    ),

    OnBoardingDM(
        image: AppImages.onboarding4,
        title: "Bearish",
        content: "Praise the name of your Lord, the Most High"
    ),

    OnBoardingDM(
        image: AppImages.onboarding5,
        title: "Holy Quran Radio",
        content: "You can listen to the Holy Quran Radio through the application for free and easily"
    ),


  ];
  int currentIndex;

  OnboardingState({this.currentIndex = 0});
  OnboardingState copyWith({int? currentIndex}){
    return OnboardingState(currentIndex: currentIndex ?? this.currentIndex);
  }

}

sealed class OnboardingActions {}
class ChangeCurrentIndex extends OnboardingActions{
  int newIndex;
  ChangeCurrentIndex(this.newIndex);
}
class GoToHomeScreen extends OnboardingActions{
  BuildContext context;
  GoToHomeScreen(this.context);
}

sealed class OnboardingNavigation {}
class NavigateToHomeScreen extends OnboardingNavigation{}