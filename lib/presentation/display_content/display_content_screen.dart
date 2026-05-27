import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/presentation/display_content/cubit/display_content_contract.dart';
import 'package:islami_app/presentation/display_content/cubit/display_content_cubit.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';

class DisplayContentScreen extends StatefulWidget {
  const DisplayContentScreen({required this.arguments, super.key});
  final Map<String, dynamic> arguments;

  @override
  State<DisplayContentScreen> createState() => _DisplayContentScreenState();
}

class _DisplayContentScreenState extends State<DisplayContentScreen> {
  final DisplayContentCubit _displayContentCubit = getIt();

  @override
  void initState() {
    super.initState();
    if(widget.arguments["sura"] != null)
      {
        _displayContentCubit.doAction(GetContentOfSura(widget.arguments["sura"]));
      }
    else
      {
        // hadeth content
      }

  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _displayContentCubit,
      child: BlocBuilder<DisplayContentCubit, DisplayContentState>(
        builder:(_, state) => Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.black,
            foregroundColor: AppColors.gold500,
            title: Text(state.titleEn.data!,style: context.textStyle.titleMedium,),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/img_left_corner.png"),
                          Expanded(child:
                          Text(
                            state.titleAr.data!,
                            style: context.textStyle.titleMedium,
                            textAlign: TextAlign.center,
                          )),
                          Image.asset("assets/images/img_right_corner.png"),
                        ],
                      ),
                      switch(state.content.state) {
                        States.initial => throw UnimplementedError(),
                        States.loading => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.gold500,
                          ),
                        ),
                        States.success => Text(
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          state.content.data!,
                          style: context.textStyle.titleMedium!.copyWith(
                            height: 2.5,
                          ),
                        ),
                        States.failure => Text(
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          state.content.data!,
                          style: context.textStyle.titleMedium!.copyWith(
                            height: 2.5,
                          ),
                        ),
                      },
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/images/Mosque-02.png",
                  color: AppColors.gold500,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
