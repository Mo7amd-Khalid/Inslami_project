import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/padding.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/cubit/bookmark_contract.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/cubit/bookmark_cubit.dart';

import '../../../core/utils/context_func.dart';
import '../../widgets/most_recent_card.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  final BookmarkCubit _bookmarkCubit = getIt();
  @override
  void initState() {
    _bookmarkCubit.doAction(GetMostResentData());
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bookmarkCubit,
      child: BlocBuilder<BookmarkCubit, BookmarkStates>(
        builder: (_, state) => SafeArea(
          child: CustomScrollView(
            slivers: [
              if(state.mostRecent.data!.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                        "Most Recent",
                        style: context.textStyle.titleMedium
                    ),
                  ),
                ),
              if(state.mostRecent.data!.isNotEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_,index) => MostRecentCard(
                          sura: state.mostRecent.data![index],
                          onClick: ()async{
                            //_quranCubit.doAction(GoToSuraScreen(context, state.mostRecent.data![index]));
                          } ,
                        ),
                        separatorBuilder: (_,_) => SizedBox(width: 15,),
                        itemCount: state.mostRecent.data!.length),
                  ),
                ),
            ],
          ).allPadding(16),
        ),
      ),
    );
  }
}
