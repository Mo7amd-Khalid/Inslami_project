import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/padding.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:islami_app/presentation/home/cubit/home_cubit.dart';
import 'package:islami_app/presentation/tabs/quran_tab/cubit/quran_cubit.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';
import '../../core/utils/resources.dart';
import '../widgets/display_ayat_widget.dart';
import 'cubit/display_ayat_contract.dart';
import 'cubit/display_ayat_cubit.dart';

class DisplayAyatScreen extends StatefulWidget {
  const DisplayAyatScreen({required this.arguments, super.key});

  final Map<String, dynamic> arguments;

  @override
  State<DisplayAyatScreen> createState() => _DisplayAyatScreenState();
}

class _DisplayAyatScreenState extends State<DisplayAyatScreen> {
  final DisplayContentCubit _displayContentCubit = getIt();
  final HomeCubit _homeCubit = getIt();
  final QuranCubit _quranCubit = getIt();
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _displayContentCubit.doAction(GetBookMarks(context));
    _displayContentCubit.doAction(ChangeAppBarStatus(false));
    _controller = PageController(
      initialPage: ((widget.arguments[AppKeywords.surahPageArgument] as int)) - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _displayContentCubit,
      child: BlocBuilder<DisplayContentCubit, DisplayContentState>(
        builder:
            (_, state) => GestureDetector(
              onTap: () {
                _displayContentCubit.doAction(
                  ChangeAppBarStatus(!state.appBarStatus.data!),
                );
              },
              child: Scaffold(
                backgroundColor: AppColors.gold50,
                appBar:
                    state.appBarStatus.data!
                        ? AppBar(
                          scrolledUnderElevation: 0,
                          backgroundColor: AppColors.gold600,
                          foregroundColor: AppColors.white,
                          title: Text(
                            (widget.arguments[AppKeywords.surahNameArgument] as String),
                            style: context.textStyle.titleMedium!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          centerTitle: true,
                        )
                        : null,
                body: switch (_homeCubit.state.quran.state) {
                  States.initial => Center(child: CircularProgressIndicator()),
                  States.loading => Center(child: CircularProgressIndicator()),
                  States.success => PageView.builder(
                    controller: _controller,
                    reverse: true,
                    itemBuilder: (_, index) {
                      SurahDm surahDetails = _quranCubit.state.suras.data!.firstWhere((SurahDm surah) => surah.nameEn == (widget.arguments["surahName"] as String));
                      return DisplayAyatWidget(
                        page: _homeCubit.state.quran.data![index],
                        surahInfo: surahDetails,
                        cubit: _displayContentCubit,
                      ).horizontalPadding(12);
                    },
                    itemCount: _homeCubit.state.quran.data!.length,
                  ),
                  States.failure => Text("Error"),
                },
              ),
            ),
      ),
    );
  }
}
