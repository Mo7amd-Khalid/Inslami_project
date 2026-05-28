import 'package:flutter/gestures.dart';
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
    _displayContentCubit.doAction(ChangeAppBarStatus(false));
    if(widget.arguments["sura"] != null)
      {
        _displayContentCubit.doAction(GetContentOfSura(widget.arguments["sura"]));
        _displayContentCubit.doAction(GetBookMarks(context));
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
        builder:(_, state) => GestureDetector(
          onTap: (){
            _displayContentCubit.doAction(ChangeAppBarStatus(!state.appBarStatus.data!));
          },
          child: Scaffold(
            backgroundColor: AppColors.gold50,
            appBar: state.appBarStatus.data!? AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.gold600,
              foregroundColor: AppColors.white,
              title: Text(state.titleEn.data!,style: context.textStyle.titleMedium!.copyWith(color: AppColors.white),),
              centerTitle: true,
            ) : null,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/img_left_corner.png",color: AppColors.gold600,width: context.widthSize * 0.2,),
                        Expanded(child:
                        Text(
                          state.titleAr.data!,
                          style: context.textStyle.titleMedium!.copyWith(color: AppColors.gold600),
                          textAlign: TextAlign.center,
                        )),
                        Image.asset("assets/images/img_right_corner.png", color: AppColors.gold600,width: context.widthSize * 0.2,),
                      ],
                    ),
                    switch(state.content.state) {
                      States.initial => throw UnimplementedError(),
                      States.loading => Center(
                        child: CircularProgressIndicator(
                          color: AppColors.gold500,
                        ),
                      ),
                      States.success => RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                              children: List.generate(
                                  state.content.data!.length,
                                      (index) {
                                        return TextSpan(
                                    style: context.textStyle.bodyLarge!.copyWith(
                                      fontSize: 20,
                                      wordSpacing: 3,
                                      height: context.heightSize *0.003,
                                      color: AppColors.black,
                                      fontFamily: "moshaf",
                                      backgroundColor:
                                      state.selectedAya.data == index?
                                      AppColors.gray :
                                      (state.bookMarks.data ?? []).contains(index) ?
                                      AppColors.gold200 :
                                      Colors.transparent
                                    ),
                                    recognizer: LongPressGestureRecognizer()..onLongPress = ()async{
                                      _displayContentCubit.doAction(ChangeSelectedAya(index));
                                      await showModalBottomSheet(context: context, builder: (context) => SafeArea(
                                        bottom: true,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: Icon((state.bookMarks.data ?? []).contains(index) ? Icons.bookmark : Icons.bookmark_border_rounded),
                                              title: Text((state.bookMarks.data ?? []).contains(index) ? "Unsave" : "Save"),
                                              onTap: () {
                                                if((state.bookMarks.data ?? []).contains(index))
                                                  {
                                                    _displayContentCubit.doAction(RemoveBookMark(context, index));
                                                  }
                                                else
                                                  {
                                                    _displayContentCubit.doAction(SaveBookMark(context, index));
                                                  }
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ));
                                      _displayContentCubit.doAction(ChangeSelectedAya(-1));
                                    },
                                    text: state.content.data![index],
                                  );
                                      })
                          )),
                      States.failure => Text(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        "Error!",
                        style: context.textStyle.titleMedium!.copyWith(
                          height: 2.5,
                        ),
                      ),
                    },
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
