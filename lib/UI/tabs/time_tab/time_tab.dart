import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/UI/tabs/time_tab/azkar_details.dart';
import 'package:islami_app/model/azkar_dm.dart';
import 'package:islami_app/model/time_dm.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';


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
    AzkarDM.getAzkarData().then((e){
      setState(() {});
    });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/img_header.png",
                      color: AppColors.gold500,
                      width: MediaQuery.of(context).size.width*0.6,
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20
                          ),
                          sliver: SliverToBoxAdapter(
                            child: Container(
                              height: size.height*0.32,
                              decoration: BoxDecoration(
                                  color: AppColors.gold50,
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/time_container.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                              child: TimeDM.dateMeladi == null ||
                                  TimeDM.dateHigri == null ||
                                  TimeDM.prays == null ? Center(
                                child: CircularProgressIndicator(color: AppColors.black,),
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
                                            style: context.textStyle.titleMedium,
                                            textAlign: TextAlign.start,
                                          ),
                                          Expanded(
                                            child: Column(
                                              spacing: 5,
                                              children: [
                                                Text(
                                                  "Pray Time",
                                                  textAlign: TextAlign.center,
                                                  style: context.textStyle.titleMedium,
                                                ),
                                                Text(
                                                  TimeDM.dateMeladi!["weekday"]["en"],
                                                  textAlign: TextAlign.center,
                                                  style: context.textStyle.titleMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                              "${TimeDM.dateHigri!["date"].split("-")[0]} ${TimeDM.dateHigri!["month"]["en"].substring(0,3)}\n${TimeDM.dateHigri!["date"].split("-")[2]}",
                                              style: context.textStyle.titleMedium,
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
                                        color: AppColors.gold50,
                                      ),
                                    ) :
                                    CarouselSlider(
                                        items: TimeDM.prays!.keys.map((e){
                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [AppColors.black, AppColors.gold500],
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
                                                    style: context.textStyle.titleMedium
                                                ),
                                                Text(
                                                    prayTime(TimeDM.prays![e]),
                                                    style: context.textStyle.titleMedium
                                                ),
                                                Text(
                                                    TimeDM.prays![e] == prayTime(TimeDM.prays![e]) ? "AM" : "PM",
                                                    style: context.textStyle.titleMedium
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          viewportFraction: 0.31,
                                          enlargeCenterPage: true,
                                        )),),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              "Azkar",
                              style: context.textStyle.titleMedium,
                            ),
                          ), padding: EdgeInsets.only(
                          bottom: 20
                        ),
                        ),

                        SliverPadding(
                          padding: EdgeInsets.only(
                            bottom: 20
                        ),
                          sliver: SliverToBoxAdapter(
                            child: azkarItem(
                                rightImage: "assets/images/morning_azkar_icon.png",
                                rightText: "Morning Azkar",
                                leftImage: "assets/images/evening-azkar-icon 1.png",
                                leftText: "Evening Azkar",
                              leftList: AzkarDM.eveningAzkar,
                              rightList: AzkarDM.morningAzkar
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            bottom: 20
                        ),
                          sliver: SliverToBoxAdapter(
                            child: azkarItem(
                                rightImage: "assets/images/tasabeh.png",
                                rightText: "Tasabeeh",
                                leftImage: "assets/images/praying azkar.png",
                                leftText: "Azkar after praying",
                              rightList: AzkarDM.tasabeehAzkar,
                              leftList: AzkarDM.prayingAzkar,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            bottom: 20
                        ),
                          sliver: SliverToBoxAdapter(
                            child: azkarItem(
                                rightImage: "assets/images/waking up azkar.png",
                                rightText: "Waking up Azkar",
                                leftImage: "assets/images/sleeping azkar.png",
                                leftText: "Sleeping Azkar",
                              rightList: AzkarDM.wakingUpAzkar,
                              leftList: AzkarDM.sleepingAzkar,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  ,


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

  Widget azkarItem({
    required String rightImage,
    required String rightText,
    required String leftImage,
    required String leftText,
    required List<dynamic>? rightList,
    required List<dynamic>? leftList,
}){
    return Row(
      spacing: 20,
      children: [
        Expanded(
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, AzkarDetails.routeName, arguments: leftList);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.gold500,
                      width: 2,
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Image.asset(leftImage,),
                    Text(
                      leftText,
                      textAlign: TextAlign.center,
                      style: context.textStyle.titleMedium,
                    )
                  ],
                ),
              ),
            )),
        Expanded(
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, AzkarDetails.routeName, arguments: rightList);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.gold500,
                      width: 2,
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Image.asset(rightImage),
                    Text(
                      rightText,
                      textAlign: TextAlign.center,
                      style: context.textStyle.titleMedium,
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }

}
