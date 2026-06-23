import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/domain/models/radio_dm.dart';
import 'package:islami_app/domain/models/reciters_dm.dart';

class RadioAndRecitersStates{
  Resources<List<Radios>> radiosChannel;
  Resources<List<Radios>> radiosChannelSearchList;
  Resources<List<Reciters>> reciters;
  Resources<List<Reciters>> recitersSearchList;
  int currentTap;
  String playedChannelId;
  String mutedChannelId;
  String searchTitle;
  Duration duration;
  Duration position;

  RadioAndRecitersStates({
    this.currentTap = 0,
    this.playedChannelId = "",
    this.mutedChannelId = "",
    this.searchTitle = "Radio Channels Name",
    this.radiosChannel = const Resources.initial(),
    this.radiosChannelSearchList = const Resources.initial(),
    this.recitersSearchList = const Resources.initial(),
    this.reciters = const Resources.initial(),
    this.duration = Duration.zero,
    this.position = Duration.zero,

  });

  RadioAndRecitersStates copyWith({
    int? currentTap,
    String? playedChannelId,
    String? mutedChannelId,
    String? searchTitle,
    Resources<List<Radios>>? radiosChannelSearchList,
    Resources<List<Radios>>? radiosChannel,
    Resources<List<Reciters>>? reciters,
    Resources<List<Reciters>>? recitersSearchList,
    Duration? duration,
    Duration? position,
  }){
    return RadioAndRecitersStates(
      currentTap: currentTap ?? this.currentTap,
      playedChannelId: playedChannelId ?? this.playedChannelId,
      mutedChannelId: mutedChannelId ?? this.mutedChannelId,
      radiosChannel: radiosChannel ?? this.radiosChannel,
      radiosChannelSearchList: radiosChannelSearchList ?? this.radiosChannelSearchList,
      reciters: reciters ?? this.reciters,
      recitersSearchList: recitersSearchList ?? this.recitersSearchList,
      searchTitle: searchTitle ?? this.searchTitle,
      duration: duration ?? this.duration,
      position: position ?? this.position,
    );
  }
}

sealed class RadioAndRecitersAction{}
class ChangeCurrentTap extends RadioAndRecitersAction{
  int newTap;
  ChangeCurrentTap(this.newTap);
}
class GetRadiosChannels extends RadioAndRecitersAction{}
class GetReciters extends RadioAndRecitersAction{}
class PlayOrPause extends RadioAndRecitersAction{
  String url;
  PlayOrPause(this.url);
}
class MuteVolume extends RadioAndRecitersAction{
  String id;
  MuteVolume(this.id);
}
class GoToReciterScreen extends RadioAndRecitersAction{
  Reciters reciter;
  GoToReciterScreen(this.reciter);
}
class ChangeSearchTitle extends RadioAndRecitersAction{
  String searchTitle;
  ChangeSearchTitle(this.searchTitle);
}
class ChangeSearchList extends RadioAndRecitersAction{
  String inputSearch;
  ChangeSearchList(this.inputSearch);
}
class UpdatePositionOfAudioSlider extends RadioAndRecitersAction{
  Duration position;
  UpdatePositionOfAudioSlider(this.position);
}
class UpdateDurationOfAudioSlider extends RadioAndRecitersAction{
  Duration duration;
  UpdateDurationOfAudioSlider(this.duration);
}
class ChangeSliderValue extends RadioAndRecitersAction{
  int position;
  ChangeSliderValue(this.position);
}

sealed class RadioAndRecitersNavigation{}
class NavigateToReciterScreen extends RadioAndRecitersNavigation{
  Reciters reciter;
  NavigateToReciterScreen(this.reciter);
}