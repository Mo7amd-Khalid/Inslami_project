import 'package:flutter/material.dart';
import 'package:islami_app/UI/tabs/quran_tab/quran_details_screen.dart';
import 'package:islami_app/UI/tabs/quran_tab/sura_card.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../../../core/style/colors.dart';
import '../../../core/style/text_style.dart';
import '../../../model/sura-dm.dart';
import 'most_recent_card.dart';

class QuranTabScreen extends StatefulWidget {
  const QuranTabScreen({super.key});

  @override
  State<QuranTabScreen> createState() => _QuranTabScreenState();
}

class _QuranTabScreenState extends State<QuranTabScreen> {

  List<SuraDM> mostRecent = [];
  List<SuraDM>? searchItems;

  var searchController = TextEditingController();

  bool searchItemExist = false;
  @override
  void initState() {
    _getMostRecentData();
    SuraDM.getSurasInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/quran_screen.png"),fit: BoxFit.cover),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                TextFormField(
                  controller: searchController,
                  onChanged: (input)
                  {
                    _searchedFunc(input);
                  },
                  cursorColor: AppColors.white,
                  style: TextStyle(
                      color: AppColors.white
                  ),
                  decoration: InputDecoration(
                    prefixIcon: ImageIcon(
                      AssetImage("assets/icons/quran.png"),
                      color: AppColors.gold,
                    ),
                    suffixIcon: searchItems == null ?
                    null :
                    IconButton(
                        onPressed: (){
                          searchController.clear();
                          searchItems = null;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: AppColors.gold,)),
                    hintText: "Sura Name",
                    hintStyle: TextStyle(
                        color: AppColors.white
                    ),
                    enabledBorder: myOutLineInputBorder(),
                    focusedBorder: myOutLineInputBorder(),
                  ),

                ),
                Expanded(
                  child: searchItems == null?
                  CustomScrollView(
                    slivers: [
                      if(mostRecent.isNotEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                                "Most Recent",
                                style: AppTextStyle.smallLabel(color: AppColors.white)
                            ),
                          ),
                        ),

                      if(mostRecent.isNotEmpty)
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 180,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_,index) => MostRecentCard(
                                  sura: mostRecent[index],
                                  onClick: _storeSuraNumber,
                                ),
                                separatorBuilder: (_,_) => SizedBox(width: 15,),
                                itemCount: mostRecent.length),
                          ),
                        ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                              "Suras List",
                              style: AppTextStyle.smallLabel(color: AppColors.white)
                          ),
                        ),
                      ),
                      SliverList.separated(
                        itemBuilder: (_,index) => SuraCard(sura: SuraDM.suras[index],onClick: _storeSuraNumber,),
                        separatorBuilder: (_,_)=> Divider(
                          color: AppColors.white,
                          indent: 50,
                          endIndent: 50,
                        ),
                        itemCount: SuraDM.suras.length,
                      )

                    ],
                  ) :
                  searchItems!.isEmpty?
                  Center(child: Text("No Item Found",style: AppTextStyle.largeLabel(color: AppColors.white),)) :
                  ListView.separated(
                      itemBuilder: (_,index) =>SuraCard(sura: searchItems![index], onClick: _storeSuraNumber),
                      separatorBuilder: (_,_)=>Divider(
                        color: AppColors.white,
                        indent: 50,
                        endIndent: 50,
                      ),
                      itemCount: searchItems!.length),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder myOutLineInputBorder({Color borderColor = AppColors.gold}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }

  Future<void> _getMostRecentData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mostRecent = [];
    var mostRecentNumbers = preferences.getStringList("mostRecent") ?? [];

    mostRecentNumbers.forEach((e){
      mostRecent.add(SuraDM.suras.elementAt(int.parse(e) - 1));
    });
    setState(() {});
  }

  Future<void> _storeSuraNumber(int suraNumber) async{
    Navigator.pushNamed(context,
        QuranDetailsScreen.routeName,
        arguments: SuraDM.suras.elementAt(suraNumber-1));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var mostRecentList = preferences.getStringList("mostRecent")??[];
    if(mostRecentList.contains(suraNumber.toString()))
    {
      mostRecentList.remove(suraNumber.toString());
    }
    mostRecentList = [suraNumber.toString(), ...mostRecentList];
    await preferences.setStringList("mostRecent", mostRecentList);
    _getMostRecentData();
  }

  void _searchedFunc(String input) {
    if(input.isEmpty)
      {
        searchItems = null;
      }
    else
      {
        searchItems = SuraDM.suras.where((e){
          return e.nameAR.contains(input);
        }).toList();
        if(searchItems!.isEmpty)
          {
            searchItems = SuraDM.suras.where((e){
              return e.nameEN.toLowerCase().contains(input.toLowerCase());
            }).toList();
          }
        searchItems ??= [];
      }

    setState(() {});
  }
}
