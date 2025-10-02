import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/core/style/text_style.dart';
import 'package:islami_app/model/time_dm.dart';

import '../../core/style/colors.dart';

class TimeTabScreen extends StatefulWidget {
  const TimeTabScreen({super.key});

  @override
  State<TimeTabScreen> createState() => _TimeTabScreenState();
}

class _TimeTabScreenState extends State<TimeTabScreen> {
  @override
  void initState() {
    super.initState();
    TimeDM().getData("${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}", 'assiut').then((val){setState(() {});});
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/time_bg.png"),
            fit: BoxFit.cover,

          ),
        ),
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.black.withAlpha(70),
                    AppColors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
                      color: AppColors.gold,
                      width: MediaQuery.of(context).size.width*0.6,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.brown,
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: AssetImage("assets/images/time_container.png"),
                          fit: BoxFit.cover
                        )
                      ),
                      child: TimeDM.dateMeladi == null ||
                          TimeDM.dateHigri == null ||
                          TimeDM.prays == null ? Center(
                        child: CircularProgressIndicator(color: AppColors.gray,),
                      ): Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5
                              ),
                              child: Row(
                                children: [
                                  Text(
                                      "${TimeDM.dateMeladi!["date"].split("-")[0]} ${TimeDM.dateMeladi!["month"]["en"].substring(0,3)}\n${TimeDM.dateMeladi!["date"].split("-")[2]}",
                                    style: AppTextStyle.smallLabel(color: AppColors.white),
                                    textAlign: TextAlign.start,
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 5,
                                      children: [
                                        Text(
                                            "Pray Time",
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.largeLabel(color: AppColors.gray),
                                        ),
                                        Text(
                                          TimeDM.dateMeladi!["weekday"]["en"],
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.mediumTitle(color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                      "${TimeDM.dateHigri!["date"].split("-")[0]} ${TimeDM.dateHigri!["month"]["en"].substring(0,3)}\n${TimeDM.dateHigri!["date"].split("-")[2]}",
                                      style: AppTextStyle.smallLabel(color: AppColors.white),
                                    textAlign: TextAlign.end
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: TimeDM.prays == null? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.gold,
                            ),
                          ) :
                          CarouselSlider(
                              items: TimeDM.prays!.keys.map((e){
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [AppColors.black, AppColors.gold],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          e,
                                          style: AppTextStyle.mediumTitle(color: AppColors.white)
                                      ),
                                      Text(
                                          prayTime(TimeDM.prays![e]),
                                          style: AppTextStyle.largeTitle(color: AppColors.white)
                                      ),
                                      Text(
                                          TimeDM.prays![e] == prayTime(TimeDM.prays![e]) ? "AM" : "PM",
                                          style: AppTextStyle.mediumTitle(color: AppColors.white)
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                viewportFraction: 0.31,
                                enlargeCenterPage: true,
                              )),),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width*0.06,
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Next Pray - 02:22",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.mediumBody(color: AppColors.black),
                                    ),
                                  ),
                                  ImageIcon(AssetImage("assets/icons/Volume Slash.png"))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container())
                ],
              ),
            ),
          ),
            ));
  }

  String prayTime(String time){
    int hour = int.parse(time.split(":")[0]);
    if(hour <= 12)
      {
        return time;
      }
    else
      {
        hour -= 12;
        if(hour <= 9)
          {
            return "0$hour:${time.split(":")[1]}";
          }
        else
          {
            return "$hour:${time.split(":")[1]}";
          }
      }
  }

}
