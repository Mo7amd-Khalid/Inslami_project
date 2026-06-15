import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/routes/routes.dart';
import 'package:islami_app/core/utils/resources.dart';
import 'package:islami_app/presentation/tabs/quran_tab/cubit/quran_contract.dart';
import 'package:islami_app/presentation/tabs/quran_tab/cubit/quran_cubit.dart';
import 'package:islami_app/presentation/widgets/sura_card.dart';
import '../../../core/constant/image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';

class QuranTabScreen extends StatefulWidget {
  const QuranTabScreen({super.key});

  @override
  State<QuranTabScreen> createState() => _QuranTabScreenState();
}

class _QuranTabScreenState extends State<QuranTabScreen> {

  final QuranCubit _quranCubit = getIt();

  var searchController = TextEditingController();

  @override
  void initState() {
    _quranCubit.doAction(GetSurahList());
    _quranCubit.navigation.listen((event){
      switch(event) {
        case NavigateToSuraScreen():
          Navigator.pushNamed(context, Routes.displayContentViews, arguments: {
            "surahName" : event.sura.nameEn,
            "surahPage" : event.sura.pageNumber,
          },);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _quranCubit,
      child: BlocBuilder<QuranCubit, QuranState>(
        builder:(_,state) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 20,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.header,
                    color: AppColors.gold300,
                    width: MediaQuery.of(context).size.width*0.6,
                  ),
                ),
                TextFormField(
                  controller: searchController,
                  onChanged: (input)
                  {
                    _quranCubit.doAction(UpdateSearchList(input));
                  },
                  cursorColor: AppColors.white,
                  style: TextStyle(
                      color: AppColors.white
                  ),
                  decoration: InputDecoration(
                    prefixIcon: ImageIcon(
                      AssetImage(AppImages.quranIcon),
                      color: AppColors.gold300,
                    ),
                    suffixIcon: state.search.data == null ?
                    null :
                    IconButton(
                        onPressed: (){
                          searchController.clear();
                          _quranCubit.doAction(UpdateSearchList(searchController.text));
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: AppColors.gold300,)),
                    hintText: "Sura Name",
                    hintStyle: TextStyle(
                        color: AppColors.white
                    ),
                    enabledBorder: myOutLineInputBorder(),
                    focusedBorder: myOutLineInputBorder(),
                  ),

                ),
                state.search.data == null?
                    switch(state.suras.state) {
                      States.initial => CircularProgressIndicator(),
                      States.loading => Center(child: CircularProgressIndicator()),
                      States.success => Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                    "Suras List",
                                    style: context.textStyle.titleMedium
                                ),
                              ),
                            ),
                            SliverList.separated(
                              itemBuilder: (_,index) => SuraCard(
                                  sura: state.suras.data![index],
                                  onClick: ()async{
                                    _quranCubit.doAction(GoToSuraScreen(context, state.suras.data![index]));
                                  }),
                              separatorBuilder: (_,_)=> Divider(
                                color: AppColors.white,
                                indent: 50,
                                endIndent: 50,
                              ),
                              itemCount: state.suras.data!.length,
                            )

                          ],
                        ),
                      ),
                      States.failure => Text("Error"),
                    }
                 :
                state.search.data!.isEmpty?
                Center(child: Text("No Item Found",style: context.textStyle.labelLarge,)) :
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (_,index) =>SuraCard(
                        sura: state.search.data![index],
                        onClick: ()async{
                          _quranCubit.doAction(GoToSuraScreen(context, state.search.data![index]));
                        },),
                      separatorBuilder: (_,_)=>Divider(
                        color: AppColors.white,
                        indent: 50,
                        endIndent: 50,
                      ),
                      itemCount: state.search.data!.length),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder myOutLineInputBorder({Color borderColor = AppColors.gold500}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }

}
