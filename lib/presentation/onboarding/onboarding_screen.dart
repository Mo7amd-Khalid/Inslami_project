import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/utils/context_func.dart';
import 'package:islami_app/core/constant/image.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/presentation/onboarding/cubit/onboarding_contract.dart';
import 'package:islami_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/routes/routes.dart';
import '../../core/theme/app_colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnboardingCubit _onboardingCubit = getIt();

  @override
  void initState() {
    super.initState();
    _onboardingCubit.navigation.listen((event){
      switch(event) {
        case NavigateToHomeScreen():
          Navigator.pushReplacementNamed(context, Routes.homeViews);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _onboardingCubit,
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (_, state) => Scaffold(
          backgroundColor: AppColors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                        AppImages.header,
                      width: MediaQuery.of(context).size.width*0.7,
                      color: AppColors.gold500,
                    ),
                  ),
                  SizedBox(height: 25,),
                  Expanded(
                    flex: 7,
                      child: Image.asset(
                        state.onboarding[state.currentIndex].image,
                      ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      state.onboarding[state.currentIndex].title,
                      style:context.textStyle.bodyLarge,),
                  ),
                  if(state.onboarding[state.currentIndex].content != null)
                    Expanded(
                    flex: 2,
                    child: Text(
                      state.onboarding[state.currentIndex].content!,
                      textAlign: TextAlign.center,
                      style: context.textStyle.bodyLarge,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            if(state.currentIndex!=0) {
                              _onboardingCubit.doAction(ChangeCurrentIndex(state.currentIndex-1));
                            }
                          },
                          child: Text(
                            state.currentIndex != 0? "Back" : "",
                            style: context.textStyle.bodyLarge,
                          )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: AnimatedSmoothIndicator(
                            effect: ExpandingDotsEffect(
                              activeDotColor: AppColors.gold500,
                              expansionFactor: 2,
                              dotHeight: 10,
                              dotWidth: 10

                            ),
                              count: state.onboarding.length,
                            activeIndex: state.currentIndex,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: (){
                            if(state.currentIndex != 4)
                              {
                                _onboardingCubit.doAction(ChangeCurrentIndex(state.currentIndex+1));
                              }
                            else
                              {
                                _onboardingCubit.doAction(GoToHomeScreen(context));
                              }

                          },
                          child: Text(
                              state.currentIndex == 4? "Finish" : "Next",
                            style: context.textStyle.bodyLarge,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
