import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/constant/asssets.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/context_func.dart';
import 'package:islami_app/core/utils/padding.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/presentation/tabs/hadeth_tab/cubit/hadeth_contract.dart';
import 'package:islami_app/presentation/tabs/hadeth_tab/cubit/hadeth_cubit.dart';
import '../../../core/routes/routes.dart';
import '../../../core/theme/app_colors.dart';

class HadethTabScreen extends StatefulWidget {
  const HadethTabScreen({super.key});

  @override
  State<HadethTabScreen> createState() => _HadethTabScreenState();
}

class _HadethTabScreenState extends State<HadethTabScreen> {
  final HadethCubit _cubit = getIt();

  @override
  void initState() {
    _cubit.doAction(GetAllHadeth());
    _cubit.navigation.listen((event){
      switch(event) {
        case NavigateToHadethDisplayScreen():
          Navigator.pushNamed(context,Routes.displayHadethViews, arguments: event.hadeth);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<HadethCubit, HadethState>(
        builder:(_,state) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.hadethBackground),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppAssets.islamiLogo,
                        color: AppColors.gold500,
                        width: MediaQuery.of(context).size.width*0.6,
                      ),
                    ),
                    Expanded(
                        child: switch(state.allHadeth.state) {
                          States.initial => Center(child: CircularProgressIndicator(),),
                          States.loading => Center(child: CircularProgressIndicator(),),
                          States.success => CarouselSlider(
                              items: state.allHadeth.data!.map((hadeth) => InkWell(
                                onTap: (){
                                  _cubit.doAction(GoToHadethDisplayScreen(hadeth));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: AppColors.gold500,
                                      image: DecorationImage(
                                        image: AssetImage(AppAssets.hadethCardBackground),
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppAssets.hadethCardLeftCorner,
                                            color: AppColors.black,
                                            width: context.widthSize * 0.2,
                                          ),
                                          Expanded(child: Text(
                                            textAlign: TextAlign.center,
                                            hadeth.title,
                                            style: context.textStyle.titleLarge!.copyWith(fontFamily: "moshaf",color: AppColors.black),
                                          )),
                                          Image.asset(
                                            AppAssets.hadethCardRightCorner,
                                            color: AppColors.black,
                                            width: context.widthSize * 0.2,
                                          ),
                                        ],
                                      ).allPadding(10),
                                      Expanded(child: SingleChildScrollView(
                                        child: Text(
                                          hadeth.content,
                                          textAlign: TextAlign.center,
                                          style: context.textStyle.bodyLarge!.copyWith(color: AppColors.black),
                                        ),
                                      ).horizontalPadding(12)),
                                      Image.asset(
                                        AppAssets.hadethCardBottomImage,
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

                          States.failure => throw UnimplementedError(),
                        }
                    ),

                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );
  }



}
