import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/constant/assets.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/routes/routes.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/presentation/tabs/prayers_and_azkar_tab/cubit/prayers_and_azkar_contract.dart';
import 'package:islami_app/presentation/tabs/prayers_and_azkar_tab/cubit/prayers_and_azkar_cubit.dart';
import 'package:islami_app/presentation/widgets/prayers_time.dart';
import 'package:islami_app/presentation/widgets/zekr_widget.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';

class PrayersAndAzkarTabScreen extends StatefulWidget {
  const PrayersAndAzkarTabScreen({super.key});

  @override
  State<PrayersAndAzkarTabScreen> createState() =>
      _PrayersAndAzkarTabScreenState();
}

class _PrayersAndAzkarTabScreenState extends State<PrayersAndAzkarTabScreen> {
  final PrayersAndAzkarCubit _cubit = getIt();

  @override
  void initState() {
    super.initState();
    _cubit.doAction(GetPrayerData());
    _cubit.doAction(GetAzkarData());
    _cubit.navigation.listen((event) {
      switch (event) {
        case NavigateToDisplayAzkarScreen():
          Navigator.pushNamed(
            context,
            Routes.azkarView,
            arguments: event.azkar,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<PrayersAndAzkarCubit, PrayerAndAzkarStates>(
        builder:
            (_, state) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppImages.islamiLogo,
                        color: AppColors.gold500,
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ),
                    Expanded(
                      child: CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                height: context.heightSize * 0.32,
                                decoration: BoxDecoration(
                                  color: AppColors.gold700,
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.timeContainer),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: switch (state.prayerData.state) {
                                  States.initial || States.loading => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.gold800,
                                    ),
                                  ),
                                  States.success => PrayersTime(
                                    prayerData: state.prayerData.data!,
                                  ),
                                  States.failure => Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.prayerData.message!,
                                          style: context.textStyle.labelLarge!
                                              .copyWith(color: AppColors.black),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            _cubit.doAction(GetPrayerData());
                                          },
                                          child: Text(AppKeywords.tryAgain),
                                        ),
                                      ],
                                    ),
                                  ),
                                },
                              ),
                            ),
                          ),
                          SliverPadding(
                            sliver: SliverToBoxAdapter(
                              child: Text(
                                "Azkar",
                                style: context.textStyle.titleMedium,
                              ),
                            ),
                            padding: EdgeInsets.only(bottom: 20),
                          ),

                          SliverPadding(
                            padding: EdgeInsets.only(bottom: 20),
                            sliver: switch (state.allAzkar.state) {
                              States.initial ||
                              States.loading => SliverToBoxAdapter(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.gold800,
                                  ),
                                ),
                              ),
                              States.success => SliverGrid(
                                delegate: SliverChildBuilderDelegate((
                                  context,
                                  index,
                                ) {
                                  return InkWell(
                                    onTap: (){
                                      _cubit.doAction(
                                        GoToDisplayAzkarScreen(
                                          azkar: state.allAzkar.data![index],
                                        ),
                                      );
                                    },
                                    child: ZekrWidget(
                                      image:
                                          state.allAzkar.data![index].zekrImage,
                                      title: state.allAzkar.data![index].zekrName,
                                    ),
                                  );
                                }, childCount: state.allAzkar.data!.length),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 items per row
                                      crossAxisSpacing:
                                          context.widthSize * 0.05,
                                      mainAxisSpacing:
                                          context.heightSize * 0.03,
                                      childAspectRatio:
                                          context.heightSize * 0.001,
                                    ),
                              ),
                              States.failure => throw UnimplementedError(),
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
