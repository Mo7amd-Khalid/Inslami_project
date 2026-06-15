import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/constant/image.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/presentation/home/cubit/home_contract.dart';
import 'package:islami_app/presentation/home/cubit/home_cubit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeCubit _homeCubit = getIt();

  @override
  void initState() {
    _homeCubit.doAction(LoadAllAyat());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (_,state) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(state.backgroundImages[state.currentIndex]),fit: BoxFit.cover),
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
                  child: state.tabs[state.currentIndex]
              )
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            backgroundColor: AppColors.gold600,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.white,
              onTap: (index){
              _homeCubit.doAction(ChangeCurrentIndex(index));
              },
              items: [
                BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: boxDecoration(state.currentIndex == 0),
                        child: ImageIcon(AssetImage(AppImages.quranIcon))),
                  label: "Quran"
                ),
                BottomNavigationBarItem(
                    icon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: boxDecoration(state.currentIndex == 1),
                        child: ImageIcon(AssetImage(AppImages.hadethIcon))),
                  label: "Hadeth"
                ),
                BottomNavigationBarItem(
                    icon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: boxDecoration(state.currentIndex == 2),
                        child: ImageIcon(AssetImage(AppImages.sebhaIcon))),
                  label: "Sebha"
                ),
                BottomNavigationBarItem(
                    icon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: boxDecoration(state.currentIndex == 3),
                        child: ImageIcon(AssetImage(AppImages.radioIcon))),
                    label: "Radio"
                ),
                BottomNavigationBarItem(
                    icon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: boxDecoration(state.currentIndex == 4),
                        child: ImageIcon(AssetImage(AppImages.timeIcon))),
                    label: "Time"
                ),
                BottomNavigationBarItem(
                    icon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: boxDecoration(state.currentIndex == 5),
                        child: ImageIcon(AssetImage(AppImages.bookmarkIcon))),
                    label: "Bookmark"
                ),
              ]),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration(bool selected){
    return BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.black.withAlpha(selected ? 60 : 0)
    );
  }
}
