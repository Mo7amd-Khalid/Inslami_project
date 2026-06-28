import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/constant/assets.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/core/utils/white_spaces.dart';
import 'package:islami_app/presentation/widgets/radio_list_item.dart';
import 'package:islami_app/presentation/widgets/radio_tab_item.dart';
import 'package:islami_app/presentation/widgets/reciter_item.dart';
import '../../../core/routes/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';
import 'cubit/radio_and_reciters_contract.dart';
import 'cubit/radio_and_reciters_cubit.dart';

class RadioAndRecitersTab extends StatefulWidget {
  const RadioAndRecitersTab({super.key});

  @override
  State<RadioAndRecitersTab> createState() => _RadioAndRecitersTabScreenState();
}

class _RadioAndRecitersTabScreenState extends State<RadioAndRecitersTab> {
  final RadioAndRecitersCubit _cubit = getIt();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _cubit.doAction(GetRadiosChannels());
    _cubit.doAction(GetReciters());
    _cubit.navigation.listen((event) {
      switch (event) {
        case NavigateToReciterScreen():
          Navigator.pushNamed(
            context,
            Routes.reciterViews,
            arguments: event.reciter,
          );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<RadioAndRecitersCubit, RadioAndRecitersStates>(
        builder:
            (_, state) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 20,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppImages.islamiLogo,
                        color: AppColors.gold500,
                        width: context.widthSize * 0.6,
                      ),
                    ),
                    DefaultTabController(
                      initialIndex: state.currentTap,
                      length: 2,
                      child: TabBar(
                        onTap: (index) {
                          _cubit.doAction(ChangeCurrentTap(index));
                          if (index == 0) {
                            _cubit.doAction(ChangeSearchTitle("Radio Channels Name"));
                          } else {
                            _cubit.doAction(ChangeSearchTitle("Reciter Name"));
                          }
                        },
                        labelPadding: EdgeInsets.zero,
                        indicator: BoxDecoration(),
                        dividerHeight: 0,
                        tabs: [
                          RadioTabItem(
                            isSelected: state.currentTap == 0,
                            title: AppKeywords.radio,
                          ),
                          RadioTabItem(
                            isSelected: state.currentTap == 1,
                            title: AppKeywords.reciters,
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: searchController,
                      onChanged: (input)
                      {
                        _cubit.doAction(ChangeSearchList(input));
                      },
                      cursorColor: AppColors.white,
                      style: TextStyle(
                          color: AppColors.white
                      ),
                      decoration: InputDecoration(
                        prefixIcon: ImageIcon(
                          AssetImage(AppImages.quranIcon),
                          color: AppColors.gold300,
                        ),
                        suffixIcon: (state.recitersSearchList.data == null && state.radiosChannelSearchList.data == null) ? null :  IconButton(
                            onPressed: (){
                              searchController.clear();
                              _cubit.doAction(ChangeSearchList(""));
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: AppColors.gold300,)),
                        hintText: state.searchTitle,
                        hintStyle: TextStyle(
                            color: AppColors.white
                        ),
                        enabledBorder: myOutLineInputBorder(),
                        focusedBorder: myOutLineInputBorder(),
                      ),

                    ),
                    Expanded(
                      child:
                          state.currentTap == 0
                              ? switch (state.radiosChannel.state) {
                                States.initial || States.loading => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                States.success => state.radiosChannelSearchList.data == null ?
                                RefreshIndicator(
                                  onRefresh: ()async{
                                    _cubit.doAction(GetRadiosChannels());
                                  },
                                  child: ListView.separated(
                                      itemBuilder: (_, index) => Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                                          child: RadioListItem(
                                                            isRadio: true,
                                                            playOrPause: () => _cubit.doAction(PlayOrPause(state.radiosChannel.data![index].url!)),
                                                            muteVolume: () => _cubit.doAction(MuteVolume(state.radiosChannel.data![index].url!)),
                                                            title: state.radiosChannel.data![index].name!,
                                                            isSoundMute: state.mutedChannelId == state.radiosChannel.data![index].url,
                                                            isSoundPlayed: state.playedChannelId == state.radiosChannel.data![index].url,
                                                          ),
                                                        ),
                                      separatorBuilder: (_, _) => 10.verticalSpace,
                                      itemCount: state.radiosChannel.data!.length),
                                ) :
                                state.radiosChannelSearchList.data!.isEmpty ?
                                Center(child: Text(AppKeywords.noItemsFound,style: context.textStyle.titleMedium,),) :
                                ListView.separated(
                                    itemBuilder: (_, index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: RadioListItem(
                                        isRadio: true,
                                        playOrPause: () => _cubit.doAction(PlayOrPause(state.radiosChannelSearchList.data![index].url!)),
                                        muteVolume: () => _cubit.doAction(MuteVolume(state.radiosChannelSearchList.data![index].url!)),
                                        title: state.radiosChannelSearchList.data![index].name!,
                                        isSoundMute: state.mutedChannelId == state.radiosChannelSearchList.data![index].url,
                                        isSoundPlayed: state.playedChannelId == state.radiosChannelSearchList.data![index].url,
                                      ),
                                    ),
                                    separatorBuilder: (_, _) => 10.verticalSpace,
                                    itemCount: state.radiosChannelSearchList.data!.length),
                                States.failure => Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(state.radiosChannel.message!),
                                    FilledButton(onPressed: (){
                                      _cubit.doAction(GetRadiosChannels());
                                    }, child: Text("Try again"))
                                  ],
                                ),
                              }
                              : switch (state.reciters.state) {
                                States.initial => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                States.loading => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                States.success => state.recitersSearchList.data == null ?
                                RefreshIndicator(
                                  onRefresh: ()async{
                                    _cubit.doAction(GetReciters());
                                  },
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: context.widthSize *0.05,
                                    mainAxisSpacing: context.heightSize *0.02,
                                    children: List.generate(state.reciters.data!.length, (index) => InkWell(
                                                      onTap: (){
                                                        _cubit.doAction(GoToReciterScreen(state.reciters.data![index]));
                                                      },
                                                      child: ReciterItem(title: state.reciters.data![index].name!),
                                                    )),)) :
                          state.recitersSearchList.data!.isEmpty ?
                          Center(child: Text(AppKeywords.noItemsFound,style: context.textStyle.titleMedium,),) :
                          GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: context.widthSize *0.05,
                            mainAxisSpacing: context.heightSize *0.02,
                            children: List.generate(state.recitersSearchList.data!.length, (index) => InkWell(
                              onTap: (){
                                _cubit.doAction(GoToReciterScreen(state.recitersSearchList.data![index]));
                              },
                              child: ReciterItem(title: state.recitersSearchList.data![index].name!),
                            )),)
                          ,
                                States.failure => Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(state.reciters.message!),
                                                FilledButton(onPressed: (){
                                                  _cubit.doAction(GetReciters());
                                                }, child: Text("Try again"))
                                              ],
                                            ),
                              },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
  OutlineInputBorder myOutLineInputBorder({Color borderColor = AppColors.gold500}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }
}

