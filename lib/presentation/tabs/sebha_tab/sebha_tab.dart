import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/constant/asssets.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/white_spaces.dart';
import 'package:islami_app/presentation/tabs/sebha_tab/cubit/sebha_contract.dart';
import 'package:islami_app/presentation/tabs/sebha_tab/cubit/sebha_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';


class SebhaTabScreen extends StatefulWidget {
  const SebhaTabScreen({super.key});

  @override
  State<SebhaTabScreen> createState() => _SebhaTabScreenState();
}

class _SebhaTabScreenState extends State<SebhaTabScreen> {
  final SebhaCubit _cubit = getIt();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppAssets.sebhaBackground),fit: BoxFit.cover)
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
        child: BlocProvider.value(
          value: _cubit,
          child: BlocBuilder<SebhaCubit,SebhaState>(
            builder:(_,state) => SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppAssets.islamiLogo,
                      color: AppColors.gold500,
                      width: context.widthSize*0.6,
                    ),
                  ),
                  (context.heightSize * 0.03).verticalSpace,
                  Text(
                      "سَبِّحِ اسْمَ رَبِّكَ الأعلى ",
                    style: context.textStyle.titleLarge,
                  ),
                  (context.heightSize * 0.03).verticalSpace,
                  Image.asset(
                    AppAssets.sebhaPart1,
                    width: context.widthSize*0.3,
                  ),
                  InkWell(
                    onTap: (){
                      _cubit.doAction(ClickOnSebha(state.turns, state.counter, state.zekr));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        AnimatedRotation(
                            turns: state.turns,
                            duration: Duration(milliseconds: 450),
                          child: Image.asset(
                            AppAssets.sebhaBody,
                            width: context.widthSize*0.8,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                state.azkar[state.zekr%4],
                              style: context.textStyle.headlineLarge!.copyWith(
                                fontFamily: "moshaf"
                              ),

                            ),
                            Text(
                                state.counter.toString(),
                              style: context.textStyle.headlineLarge!.copyWith(
                                fontFamily: "moshaf"
                              ),

                            ),
                          ],
                        ),
                      ]
                    ),
                  ),
                  (context.heightSize * 0.03).verticalSpace,
                  FilledButton(onPressed: (){
                    _cubit.doAction(ResetCounter());
                  }, child: Text("Reset counter")),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
