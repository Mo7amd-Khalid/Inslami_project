import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/di.dart';
import 'package:islami_app/core/utils/padding.dart';
import 'package:islami_app/core/utils/white_spaces.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/cubit/bookmark_contract.dart';
import 'package:islami_app/presentation/tabs/bookmark_tab/cubit/bookmark_cubit.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/context_func.dart';
import '../../widgets/bookmark.dart';
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
    _bookmarkCubit.doAction(GetAllBookmarks());
    _bookmarkCubit.navigation.listen((event) {
      switch (event) {
        case NavigateToSurahScreen():
          Navigator.pushNamed(
            context,
            Routes.displayContentViews,
            arguments: {
              "surahName": event.suraName,
              "surahPage": event.suraPage,
            },
          );
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bookmarkCubit.doAction(GetAllBookmarks());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bookmarkCubit,
      child: BlocBuilder<BookmarkCubit, BookmarkStates>(
        builder:
            (_, state) => SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.mostRecent.data!.isNotEmpty)
                    Text(
                      "Most Recent",
                      style: context.textStyle.titleMedium,
                    ).allPadding(16),
                  if (state.mostRecent.data!.isNotEmpty)
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (_, index) => MostRecentCard(
                              sura: state.mostRecent.data![index],
                              onClick: () async {
                                _bookmarkCubit.doAction(
                                  GoToSurahScreen(
                                    context: context,
                                    suraName:
                                        state.mostRecent.data![index].nameEn!,
                                    suraPage:
                                        state
                                            .mostRecent
                                            .data![index]
                                            .pageNumber!,
                                    surahId: state.mostRecent.data![index].id,
                                  ),
                                );
                              },
                            ),
                        separatorBuilder: (_, _) => SizedBox(width: 15),
                        itemCount: state.mostRecent.data!.length,
                      ),
                    ),
                  if (state.allBookmark.data!.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          "Bookmarks",
                          style: context.textStyle.titleMedium,
                        ).allPadding(16),
                        const Spacer(),
                        if(state.selectionMode)
                          TextButton(onPressed: ()async{
                            await _bookmarkCubit.doAction(DeleteBookmarks(state.selectedBookmark.data??[]));
                            _bookmarkCubit.doAction(ChangeSelectionMode(false));
                          }, child: Text("Delete"))
                      ],
                    ),
                  if (state.allBookmark.data!.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          return InkWell(
                            onLongPress: (){
                              _bookmarkCubit.doAction(ChangeSelectionMode(true));
                              _bookmarkCubit.doAction(AddToSelectedBookmark(state.allBookmark.data![index]));
                            },
                            onTap: () {
                              if(state.selectionMode)
                                {
                                  if((state.selectedBookmark.data??[]).contains(state.allBookmark.data![index]))
                                    {
                                      _bookmarkCubit.doAction(RemoveToSelectedBookmark(state.allBookmark.data![index]));
                                      if((state.selectedBookmark.data ?? []).isEmpty)
                                      {
                                        _bookmarkCubit.doAction(ChangeSelectionMode(false));
                                      }
                                    }
                                  else
                                  {
                                    _bookmarkCubit.doAction(AddToSelectedBookmark(state.allBookmark.data![index]));
                                  }
                                }
                              else
                                {
                                  _bookmarkCubit.doAction(
                                    GoToSurahScreen(
                                      context: context,
                                      suraName:
                                      state.allBookmark.data![index].surahName,
                                      suraPage:
                                      state.allBookmark.data![index].pageNumber,
                                    ),
                                  );
                                }
                            },
                            child: Bookmark(
                              bookmarkData: state.allBookmark.data![index],
                              isSelected: (state.selectedBookmark.data??[]).contains(state.allBookmark.data![index]),
                            ),
                          );
                        },
                        separatorBuilder: (_, _) => 10.verticalSpace,
                        itemCount: state.allBookmark.data!.length,
                      ),
                    ),
                ],
              ).horizontalPadding(12),
            ),
      ),
    );
  }
}
