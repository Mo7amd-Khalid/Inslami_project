import 'package:flutter/material.dart';
import 'package:islami_app/core/constant/asssets.dart';
import 'package:islami_app/core/utils/padding.dart';
import 'package:islami_app/core/utils/white_spaces.dart';
import 'package:islami_app/presentation/tabs/radio_and_reciters_tab/cubit/radio_and_reciters_contract.dart';
import 'package:islami_app/presentation/tabs/radio_and_reciters_tab/cubit/radio_and_reciters_cubit.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';

class RadioListItem extends StatelessWidget {
  RadioListItem({super.key,this.cubit,required this.isRadio,required this.title, required this.isSoundPlayed, required this.isSoundMute, required this.playOrPause, required this.muteVolume});

  final bool isRadio;
  final String title;
  final bool isSoundPlayed;
  final bool isSoundMute;
  final Future<void> Function() playOrPause;
  final Future<void> Function() muteVolume;
  final RadioAndRecitersCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthSize *0.8,
      height: context.heightSize*0.16,
      decoration: BoxDecoration(
          color: AppColors.gold800,
          borderRadius: BorderRadius.circular(20),
          image: (!isRadio && isSoundPlayed) ? null : DecorationImage(
            image: isSoundPlayed ? AssetImage(AppAssets.soundWave) : AssetImage(AppAssets.hadethCardBottomImage),
            alignment: Alignment.bottomCenter,
          )
      ),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.textStyle.titleMedium,
            textAlign: TextAlign.center,
          ),
          30.horizontalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              InkWell(
                onTap: (){
                  playOrPause();
                },
                child: ImageIcon(
                  isSoundPlayed ? AssetImage(AppAssets.pauseIcon) : AssetImage(AppAssets.playIcon),
                  size: 32,
                ),
              ),
              InkWell(
                onTap: (){
                  muteVolume();
                },
                child: ImageIcon(
                  isSoundMute ?AssetImage(AppAssets.muteIcon) :AssetImage(AppAssets.volumeIcon),
                  size: 28,
                ),
              ),
            ],
          ),
          if(!isRadio && isSoundPlayed)
            Row(
              spacing: 15,
              children: [
                Text(formatTime(cubit!.state.position.inSeconds)),
                Expanded(
                  child: Slider(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      min:0,
                      max: cubit!.state.duration.inSeconds.toDouble(),
                      value: cubit!.state.position.inSeconds.toDouble(),
                      activeColor: AppColors.gold100,
                      onChanged: (value){
                        cubit!.doAction(ChangeSliderValue(value.toInt()));
                      }),
                ),
                Text(formatTime(cubit!.state.duration.inSeconds)),

              ],
            ).horizontalPadding(6),


        ],
      ),
    );
  }
  String formatTime(int seconds){
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8,'0');

  }
}
