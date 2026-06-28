import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/domain/mapper/prayer_to_list_of_payers.dart';
import 'package:islami_app/domain/models/prayer_dm.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';

class PrayersTime extends StatelessWidget {
  const PrayersTime({super.key, required this.prayerData});
  final PrayerData prayerData;


  @override
  Widget build(BuildContext context) {
    Map<String, DateTime> prayerTimes = PrayerMapperClass.convertPrayerToLisOfPrayers(prayerData.times);
    Map<String, dynamic> nextPrayer = PrayerMapperClass.getNextPrayerName(prayerTimes);

    return Column(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              "${prayerData.date.gregorian.day} ${prayerData.date.gregorian.month.en}\n${prayerData.date.gregorian.year}",
              style: context.textStyle.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: Column(
                spacing: 5,
                children: [
                  Text(
                    AppKeywords.prayTme,
                    textAlign: TextAlign.center,
                    style: context.textStyle.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    prayerData.date.gregorian.weekday.en,
                    textAlign: TextAlign.center,
                    style: context.textStyle.bodyLarge!.copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(
                "${prayerData.date.hijri.day} ${prayerData.date.hijri.month.ar}\n${prayerData.date.hijri.year}",
                style: context.textStyle.bodyLarge!.copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.end
            ),
          ],
        ),
        Expanded(
          child: CarouselSlider(
              items: prayerTimes.keys.map((key){
                String time = DateFormat("hh:mm").format(prayerTimes[key]!);
                String period = DateFormat("a").format(prayerTimes[key]!);
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
                          key,
                          style: context.textStyle.titleMedium
                      ),
                      Text(
                          time,
                          style: context.textStyle.titleMedium
                      ),
                      Text(
                          period,
                          style: context.textStyle.titleMedium
                      ),
                    ],
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: context.widthSize * 0.001,
                initialPage: nextPrayer["index"],
                autoPlayCurve: Curves.bounceInOut,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeCenterPage: true,
              )),

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Next Prayer : ",
              style: context.textStyle.bodyLarge!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(nextPrayer["name"],
              style: context.textStyle.bodyLarge!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold),
            ),

          ],
        ),
        
      ],
    );

  }
}
