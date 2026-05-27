import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/model/sura-dm.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';

class ReciterScreen extends StatefulWidget {
  const ReciterScreen({super.key});
  static const String routeName = "Reciter Screen";

  @override
  State<ReciterScreen> createState() => _ReciterScreenState();
}

class _ReciterScreenState extends State<ReciterScreen> {

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((e){
      setState(() {
        print(e);
      });
    });

    player.onDurationChanged.listen((newDuration){
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition){
      setState(() {
        position = newPosition;
      });
    });
  }

  final player = AudioPlayer();


  String? idSoundPlayed;
  String? idSoundMuted;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  Widget build(BuildContext context) {
    var item = ModalRoute.of(context)!.settings.arguments as dynamic;
    List<String>? surasURL = List.generate(item["moshaf"][0]["surah_total"], (index){
      final surahNumber = (index + 1).toString().padLeft(3, '0');
      return "${item["moshaf"][0]["server"]}$surahNumber.mp3";
    });

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 40,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold500,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("assets/images/img_left_corner.png"),
                Expanded(child:
                Text(
                  item["name"],
                  style: context.textStyle.titleMedium,
                  textAlign: TextAlign.center,
                )),
                Image.asset("assets/images/img_right_corner.png"),
              ],
            ),
            // Expanded(child:
            // ListView.separated(
            //     itemBuilder: (_,index)=>reciterListItem(SuraDM.suras[
            //       int.parse(item["moshaf"][0]["surah_list"].split(",")[index]) - 1
            //     ].nameEN, index, surasURL[index]),
            //     separatorBuilder: (_,index)=>SizedBox(height: 16,),
            //     itemCount: item["moshaf"][0]["surah_total"])),
            Image.asset(
              "assets/images/Mosque-02.png",
              color: AppColors.gold500,)
          ],
        ),
      ),
    );


  }

  Widget reciterListItem(String title, int id, String url) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.17,
      decoration: BoxDecoration(
          color: AppColors.gold500,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: idSoundPlayed == "reciter$id" ?AssetImage("assets/images/sound-wave.png") : AssetImage("assets/images/Mosque-02.png"),
            alignment: Alignment.bottomCenter,
            opacity: 0.5,
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.textStyle.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              InkWell(
                onTap: (){
                  playOrPause(url, id, "reciter");
                },
                child: ImageIcon(
                  idSoundPlayed == "reciter$id"? AssetImage("assets/icons/Pause.png") : AssetImage("assets/icons/play.png"),
                  size: 32,
                ),
              ),
              InkWell(
                onTap: (){
                  muteVolume(id, "reciter");
                },
                child: ImageIcon(
                  idSoundMuted == "reciter$id"?AssetImage("assets/icons/Volume mute.png") :AssetImage("assets/icons/Volume High.png"),
                  size: 28,
                ),
              ),
            ],
          ),
          if(idSoundPlayed == "reciter$id")
            Slider(
              padding: EdgeInsets.symmetric(vertical: 8),
              min:0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                activeColor: AppColors.gold100,
                onChanged: (value){
                final position = Duration(seconds: value.toInt());
                player.seek(position);
                player.resume();
                }),
          if(idSoundPlayed == "reciter$id")
            Row(
              children: [
                Text(formatTime(position.inSeconds)),
                Spacer(),
                Text(formatTime((duration-position).inSeconds)),
              ],
            ),



        ],
      ),
    );
  }

  Future<void> playOrPause(String url, int id, String type) async{

    if(idSoundPlayed == "$type$id")
    {
      player.pause();
      idSoundPlayed = null;
      setState(() {});
    }
    else
    {
      player.pause();
      idSoundPlayed = "$type$id";
      player.play(UrlSource(url)).then((e){
        setState(() {});
      });
    }

  }

  Future<void> muteVolume(int id, String type)async{
    if(idSoundPlayed == null) {
      return;
    }
    if(idSoundMuted == "$type$id")
    {
      await player.setVolume(1);
      idSoundMuted = null;
    }
    else if(idSoundPlayed=="$type$id")
    {
      await player.setVolume(0);
      idSoundMuted = "$type$id";
    }

    setState(() {});
  }

  String formatTime(int seconds){
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8,'0');

  }





}