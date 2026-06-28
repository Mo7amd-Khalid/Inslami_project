import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/data/network/results.dart';
import 'package:islami_app/domain/models/radio_dm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';
import 'package:islami_app/domain/repository/repo.dart';
import 'package:islami_app/presentation/tabs/radio_and_reciters_tab/cubit/radio_and_reciters_contract.dart';

@singleton
class RadioAndRecitersCubit extends BaseCubit<RadioAndRecitersStates, RadioAndRecitersAction, RadioAndRecitersNavigation>{
  RadioAndRecitersCubit(this._repo) : super(RadioAndRecitersStates());

  final RepositoryContract _repo;
  final AudioPlayer player = AudioPlayer();

  @override
  Future<void> doAction(RadioAndRecitersAction action) async{
    switch (action) {
      case ChangeCurrentTap():
        changeCurrentTap(action.newTap);
      case GetRadiosChannels():
        getRadiosChannel();
      case GetReciters():
        getReciters();
      case PlayOrPause():
        await playOrPause(action.url);
      case MuteVolume():
        muteVolume(action.id);
      case GoToReciterScreen():
        goToReciterScreen(action.reciter);
      case ChangeSearchTitle():
        changeSearchTitle(action.searchTitle);
      case ChangeSearchList():
        changeSearchList(action.inputSearch);
      case UpdatePositionOfAudioSlider():
        updatePositionOfAudioSlider(action.position);
      case ChangeSliderValue():
        changeSliderValue(action.position);
      case UpdateDurationOfAudioSlider():
        updateDurationOfAudioSlider(action.duration);
    }
  }

  void changeCurrentTap(int newTap) {
    emit(state.copyWith(currentTap: newTap));
  }


  void getRadiosChannel() async{
    emit(state.copyWith(radiosChannel: Resources.loading()));
    var response = await _repo.getRadiosChannels();
    switch (response) {
      case Success<RadioDm>():
        emit(state.copyWith(radiosChannel: Resources.success(data: response.data!.radios)));
      case Failure<RadioDm>():
        emit(state.copyWith(radiosChannel: Resources.failure(exception: response.exception, message: response.message)));
    }
  }

  void getReciters() async{
    emit(state.copyWith(reciters: Resources.loading()));
    var response = await _repo.getReciters();
    switch (response) {
      case Success<RecitersDm>():
        emit(state.copyWith(reciters: Resources.success(data: response.data!.reciters)));
      case Failure<RecitersDm>():
        emit(state.copyWith(reciters: Resources.failure(exception: response.exception, message: response.message)));
    }
  }

  Future<void> playOrPause(String url) async{
    if (state.playedChannelId == url) {
      await player.pause();
      emit(state.copyWith(playedChannelId: ""));
      return;
    }

    await player.stop();
    await player.play(UrlSource(url));
    emit(state.copyWith(playedChannelId: url));
  }

  Future<void> muteVolume(String id) async{
    if(state.playedChannelId.isEmpty)
      {
        return;
      }
    else
    {
      if(state.mutedChannelId == id)
        {
          await player.setVolume(1);
          emit(state.copyWith(mutedChannelId: ""));
        }
      else
        {
          await player.setVolume(0);
          emit(state.copyWith(mutedChannelId: id));
        }
    }

  }

  void goToReciterScreen(Reciters reciter) {
    emitNavigation(NavigateToReciterScreen(reciter));
  }

  void changeSearchTitle(String searchTitle) {
    emit(state.copyWith(searchTitle: searchTitle));
  }

  void changeSearchList(String inputSearch) {
    if(inputSearch.isNotEmpty)
      {
        if(state.currentTap == 0)
        {
          List<Radios> search = [];
          search = state.radiosChannel.data!.where((item) => item.name!.contains(inputSearch)).toList();
          emit(state.copyWith(radiosChannelSearchList: Resources.success(data: search)));
        }
        else
        {
          List<Reciters> search = [];
          search = state.reciters.data!.where((item) => item.name!.contains(inputSearch)).toList();
          emit(state.copyWith(recitersSearchList: Resources.success(data: search)));
        }
      }
    else
      {
        emit(state.copyWith(recitersSearchList: Resources.success(data: null), radiosChannelSearchList: Resources.success(data: null)));
      }

  }

  void updatePositionOfAudioSlider(Duration position){
    emit(state.copyWith(position: position));
  }

  void updateDurationOfAudioSlider(Duration duration){
    emit(state.copyWith(duration: duration));
  }

  void changeSliderValue(int position) {
    final newPosition = Duration(seconds: position);
    player.seek(newPosition);
  }

}
