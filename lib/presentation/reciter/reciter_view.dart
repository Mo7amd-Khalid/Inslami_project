import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/constant/asssets.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/context_func.dart';
import 'package:islami_app/core/utils/generateSurahUrl.dart';
import 'package:islami_app/core/utils/white_spaces.dart';
import 'package:islami_app/presentation/tabs/quran_tab/cubit/quran_cubit.dart';
import 'package:islami_app/presentation/tabs/radio_and_reciters_tab/cubit/radio_and_reciters_contract.dart';
import 'package:islami_app/presentation/tabs/radio_and_reciters_tab/cubit/radio_and_reciters_cubit.dart';
import 'package:islami_app/presentation/widgets/radio_list_item.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/reciters_dm.dart';

class ReciterView extends StatefulWidget {
  ReciterView({super.key, required this.reciter});

  final Reciters reciter;

  @override
  State<ReciterView> createState() => _ReciterViewState();
}

class _ReciterViewState extends State<ReciterView> {
  final RadioAndRecitersCubit _radioAndRecitersCubit = getIt();

  final QuranCubit _quranCubit = getIt();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    super.initState();
    _radioAndRecitersCubit.player.onPlayerStateChanged.listen((e){
    });

    _radioAndRecitersCubit.player.onDurationChanged.listen((newDuration){
      _radioAndRecitersCubit.doAction(UpdateDurationOfAudioSlider(newDuration));
    });

    _radioAndRecitersCubit.player.onPositionChanged.listen((newPosition){
      _radioAndRecitersCubit.doAction(UpdatePositionOfAudioSlider(newPosition));
    });
    _radioAndRecitersCubit.player.onPlayerComplete.listen((event){
      _radioAndRecitersCubit.doAction(MuteVolume(_radioAndRecitersCubit.state.mutedChannelId));
      _radioAndRecitersCubit.doAction(PlayOrPause(_radioAndRecitersCubit.state.playedChannelId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.reciter.name!)),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.radioBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider.value(
          value: _radioAndRecitersCubit,
          child: BlocBuilder<RadioAndRecitersCubit, RadioAndRecitersStates>(
            builder: (_, state) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.black.withAlpha(70), AppColors.black],
                ),
              ),
              child: ListView.separated(
               padding: EdgeInsets.all(8),
                itemBuilder:
                    (_, index) => Column(
                      spacing: 20,
                      children: [
                        Text(
                            widget.reciter.moshaf![index].name!,
                          style: context.textStyle.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: context.heightSize *0.16,
                          child: ListView.separated(
                              itemBuilder: (_, surahIndex) {
                                int surahId = int.parse(widget.reciter.moshaf![index].surahList!.split(",")[surahIndex]);
                                String url = generateSurahUri(widget.reciter.moshaf![index].server!, widget.reciter.moshaf![index].surahList!.split(",")[surahIndex]);
                                return RadioListItem(
                                  cubit: _radioAndRecitersCubit,
                                  isRadio: false,
                                    title: _quranCubit.state.suras.data!.firstWhere((surah) => surah.id == surahId).nameEn!,
                                    isSoundPlayed: state.playedChannelId == url,
                                    isSoundMute: state.mutedChannelId == url,
                                    playOrPause: () => _radioAndRecitersCubit.doAction(PlayOrPause(url)),
                                    muteVolume: () => _radioAndRecitersCubit.doAction(MuteVolume(url)));
                              },
                              separatorBuilder: (_, index) => 10.horizontalSpace,
                              itemCount: widget.reciter.moshaf![index].surahTotal!.toInt(),
                            scrollDirection: Axis.horizontal,
                          ),
                        )

                      ],
                    ),
                separatorBuilder: (_, index) => 10.verticalSpace,
                itemCount: widget.reciter.moshaf!.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
