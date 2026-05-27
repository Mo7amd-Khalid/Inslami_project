import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/UI/tabs/radio_tab/reciter_screen.dart';
import 'package:islami_app/model/radio-dm.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';

class RadioTabScreen extends StatefulWidget {
  const RadioTabScreen({super.key});

  @override
  State<RadioTabScreen> createState() => _RadioTabScreenState();
}

class _RadioTabScreenState extends State<RadioTabScreen> {
  int currentIndex = 0;

 @override
  void initState() {
    super.initState();
    RadioDM.getRadioChannels().then((v){
      setState((){});
    });
    RadioDM.getReciters().then((v){
      setState((){});
    });
  }
  final player = AudioPlayer();

 String? idSoundPlayed;
 String? idSoundMuted;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/radio-background.png"),fit: BoxFit.cover)
        ),
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin:Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withAlpha(70),
                    AppColors.black,
                  ],
                )
            ),
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 20,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/img_header.png",
                            color: AppColors.gold500,
                            width: size.width*0.6,
                          ),
                        ),
                        DefaultTabController(
                          initialIndex: 0,
                            length: 2,
                            child: TabBar(
                              onTap: (index){
                                currentIndex = index;
                                setState(() {});
                              },
                              labelPadding: EdgeInsets.zero,
                              indicator: BoxDecoration(),
                                dividerHeight: 0,
                                tabs: [
                              tabItem("Radio", currentIndex == 0),
                              tabItem("Reciters", currentIndex == 1),
                            ])),
                        Expanded(
                          child: RadioDM.radios == null || RadioDM.reciters == null? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.gold500,
                            ),
                          ): CustomScrollView(
                            slivers: [
                              if(currentIndex == 0)
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                          (_,index) => Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                            child: radioListItem(
                                                RadioDM.radios![index]["name"],
                                                RadioDM.radios![index]["id"] ,
                                                RadioDM.radios![index]["url"] ,),
                                          ),
                                    childCount: RadioDM.radios!.length,
                              ),
                              ),

                              if(currentIndex == 1)
                                SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, ReciterScreen.routeName, arguments: RadioDM.reciters![index]);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.gold500,
                                          child: Text(
                                              RadioDM.reciters![index]["name"],
                                            style: context.textStyle.titleMedium,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: RadioDM.reciters!.length,
                                  ),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20.0,
                                    crossAxisSpacing: 30.0,
                                  ),
                                )
                            ],
                          ),
                        ),

                      ]
                  )
              )
          ),
        )
    );
  }

  Widget tabItem(String title, bool isSelected){
    return Container(
      decoration: BoxDecoration(
          color: isSelected?AppColors.gold500:AppColors.black,
          borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 8
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: context.textStyle.titleMedium,
      ),
    );
  }

  Widget radioListItem(String title, int id, String url){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.15,
      decoration: BoxDecoration(
          color: AppColors.gold500,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: idSoundPlayed == "radio$id" ?AssetImage("assets/images/sound-wave.png") : AssetImage("assets/images/Mosque-02.png"),
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
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              InkWell(
                onTap: (){
                  playOrPause(url, id, "radio");
                },
                child: ImageIcon(
                  idSoundPlayed == "radio$id"? AssetImage("assets/icons/Pause.png") : AssetImage("assets/icons/play.png"),
                  size: 32,
                ),
              ),
              InkWell(
                onTap: (){
                  muteVolume(id, "radio");
                },
                child: ImageIcon(
                  idSoundMuted == "radio$id"?AssetImage("assets/icons/Volume mute.png") :AssetImage("assets/icons/Volume High.png"),
                  size: 28,
                ),
              ),
            ],
          )
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
        await player.play(UrlSource(url)).then((e){
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
}
