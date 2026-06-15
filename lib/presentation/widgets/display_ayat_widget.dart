import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/utils/context_func.dart';
import 'package:islami_app/core/utils/generate_bookmark.dart';
import 'package:islami_app/core/utils/surah_type.dart';
import 'package:islami_app/domain/models/QuranDm.dart';
import 'package:islami_app/domain/models/surah_dm.dart';
import 'package:islami_app/presentation/display_content/cubit/display_content_contract.dart';
import 'package:islami_app/presentation/display_content/cubit/display_content_cubit.dart';

class DisplayAyatWidget extends StatelessWidget {
  const DisplayAyatWidget({
    super.key,
    required this.page,
    required this.surahInfo,
    required this.cubit,
  });

  final QuranDm page;
  final SurahDm surahInfo;
  final DisplayContentCubit cubit;

  static const double _verticalPadding = 12;
  static const double _pageNumberBottomPadding = 8;
  static const double _pageNumberSidePadding = 12;
  static const double _pageNumberReservedHeight = 28;
  static const double _minAyahFontSize = 12;
  static const double _maxAyahFontSize = 22;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final ayahFontSize = _getAyahFontSize(context, constraints);
          final firstAyahStyle = _firstAyahStyle(ayahFontSize);
          final ayahStyle = _ayahStyle(ayahFontSize);
          final markerStyle = _markerStyle(context, ayahFontSize);

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          page.surahs!.map((surah) {
                            final firstAyah =
                                surah.ayahs!
                                    .where((ayah) => ayah.ayahIndex == 0)
                                    .toList();
                            final ayat =
                                surah.ayahs!
                                    .where((ayah) => ayah.ayahIndex != 0)
                                    .toList();

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      surahType(surahInfo.revelationType!),
                                      style: context.textStyle.titleMedium!
                                          .copyWith(color: AppColors.gold500),
                                    ), // type
                                    const Spacer(),
                                    Text(
                                      surah.titleAr!,
                                      style: context.textStyle.titleMedium!
                                          .copyWith(color: AppColors.gold500),
                                    ), // surah name
                                    const Spacer(),
                                    Text(
                                      "Juz ${page.juz!.first.toString()}",
                                      style: context.textStyle.titleMedium!
                                          .copyWith(color: AppColors.gold500),
                                    ), //
                                  ],
                                ),
                                ...firstAyah.map(
                                  (ayah) => Text(
                                    ayah.text!.trim(),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    style: firstAyahStyle,
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.justify,
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    children:
                                        ayat.map((ayah) {
                                          String
                                          searchBookmark = generateBookmark(
                                            surahName: surahInfo.nameEn!,
                                            ayah: ayah.text!,
                                            ayahNumber: ayah.ayahIndex!.toInt(),
                                            pageNumber: page.pageIndex!.toInt(),
                                          );
                                          return TextSpan(
                                            children: [
                                              TextSpan(
                                                recognizer:
                                                    LongPressGestureRecognizer()
                                                      ..onLongPress = () async {
                                                        cubit.doAction(
                                                          ChangeSelectedAya(
                                                            searchBookmark,
                                                          ),
                                                        );
                                                        await showModalBottomSheet(
                                                          context: context,
                                                          builder:
                                                              (
                                                                context,
                                                              ) => SafeArea(
                                                                bottom: true,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    ListTile(
                                                                      leading: Icon(
                                                                        (cubit.state.bookMarks.data ??
                                                                                    [])
                                                                                .contains(
                                                                                  searchBookmark,
                                                                                )
                                                                            ? Icons.bookmark
                                                                            : Icons.bookmark_border_rounded,
                                                                      ),
                                                                      title: Text(
                                                                        (cubit.state.bookMarks.data ??
                                                                                    [])
                                                                                .contains(
                                                                                  searchBookmark,
                                                                                )
                                                                            ? "Unsave"
                                                                            : "Save",
                                                                      ),
                                                                      onTap: () {
                                                                        // save bookmark
                                                                        if ((cubit.state.bookMarks.data ??
                                                                                [])
                                                                            .contains(
                                                                              searchBookmark,
                                                                            )) {
                                                                          cubit.doAction(
                                                                            RemoveBookMark(
                                                                              context,
                                                                              ayah.ayahIndex!.toInt(),
                                                                              ayah.text!,
                                                                              page.pageIndex!.toInt(),
                                                                              surahInfo.nameEn!,
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          cubit.doAction(
                                                                            SaveBookMark(
                                                                              context,
                                                                              ayah.ayahIndex!.toInt(),
                                                                              ayah.text!,
                                                                              page.pageIndex!.toInt(),
                                                                              surahInfo.nameEn!,
                                                                            ),
                                                                          );
                                                                        }
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                        );
                                                        cubit.doAction(
                                                          ChangeSelectedAya(""),
                                                        );
                                                      },
                                                text: ayah.text!.trim(),
                                                style: ayahStyle,
                                              ),
                                              TextSpan(
                                                text:
                                                    ' ${toArabicNumber(ayah.ayahIndex!.toInt())} ',
                                                style: markerStyle,
                                              ),
                                            ],
                                            style: ayahStyle.copyWith(
                                              backgroundColor:
                                                  cubit.state.selectedAyah ==
                                                          searchBookmark
                                                      ? AppColors.gray
                                                      : cubit
                                                          .state
                                                          .bookMarks
                                                          .data!
                                                          .contains(
                                                            searchBookmark,
                                                          )
                                                      ? AppColors.gold200
                                                      : Colors.transparent,
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _pageNumberSidePadding,
                bottom: _pageNumberBottomPadding,
                child: Text(
                  page.pageIndex!.toInt().toString(),
                  style: context.textStyle.bodyMedium!.copyWith(
                    color: AppColors.gold800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double _getAyahFontSize(BuildContext context, BoxConstraints constraints) {
    if (!constraints.maxHeight.isFinite || constraints.maxWidth <= 0) {
      return 20;
    }

    final availableHeight =
        constraints.maxHeight -
        (_verticalPadding * 2) -
        _pageNumberReservedHeight;
    var low = _minAyahFontSize;
    var high = _maxAyahFontSize;

    for (var i = 0; i < 14; i++) {
      final middle = (low + high) / 2;
      final pageHeight = _measurePageHeight(
        context,
        constraints.maxWidth,
        middle,
      );

      if (pageHeight <= availableHeight) {
        low = middle;
      } else {
        high = middle;
      }
    }

    return low;
  }

  double _measurePageHeight(
    BuildContext context,
    double width,
    double ayahFontSize,
  ) {
    var height = 0.0;
    final headerStyle = context.textStyle.titleMedium!.copyWith(
      color: AppColors.gold500,
    );
    final firstAyahStyle = _firstAyahStyle(ayahFontSize);
    final ayahStyle = _ayahStyle(ayahFontSize);
    final markerStyle = _markerStyle(context, ayahFontSize);

    for (final surah in page.surahs!) {
      final typeHeight = _measureText(
        surahInfo.revelationType!,
        width / 2,
        headerStyle,
        TextDirection.ltr,
      );
      final titleHeight = _measureText(
        surah.titleAr!,
        width / 2,
        headerStyle,
        TextDirection.rtl,
      );
      height += typeHeight > titleHeight ? typeHeight : titleHeight;

      final firstAyah =
          surah.ayahs!.where((ayah) => ayah.ayahIndex == 0).toList();
      final ayat = surah.ayahs!.where((ayah) => ayah.ayahIndex != 0).toList();

      for (final ayah in firstAyah) {
        height += _measureText(
          ayah.text!.trim(),
          width,
          firstAyahStyle,
          TextDirection.rtl,
          textAlign: TextAlign.center,
        );
      }

      if (ayat.isNotEmpty) {
        height += _measureRichText(
          width,
          ayat.map((ayah) {
            return TextSpan(
              children: [
                TextSpan(text: ayah.text!.trim(), style: ayahStyle),
                TextSpan(
                  text: ' ${toArabicNumber(ayah.ayahIndex!.toInt())} ',
                  style: markerStyle,
                ),
              ],
              style: ayahStyle,
            );
          }).toList(),
        );
      }
    }

    return height;
  }

  double _measureText(
    String text,
    double width,
    TextStyle style,
    TextDirection textDirection, {
    TextAlign textAlign = TextAlign.start,
  }) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: textAlign,
      textDirection: textDirection,
    )..layout(maxWidth: width);

    return painter.height;
  }

  double _measureRichText(double width, List<InlineSpan> children) {
    final painter = TextPainter(
      text: TextSpan(children: children),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
    )..layout(maxWidth: width);

    return painter.height;
  }

  TextStyle _firstAyahStyle(double fontSize) {
    return TextStyle(fontSize: fontSize + 2, color: Colors.black, height: 2);
  }

  TextStyle _ayahStyle(double fontSize) {
    return TextStyle(fontSize: fontSize + 4, color: Colors.black, height: 2);
  }

  TextStyle _markerStyle(BuildContext context, double fontSize) {
    return context.textStyle.headlineSmall!.copyWith(
      fontSize: fontSize + 8,
      fontFamily: 'moshaf',
      color: AppColors.gold800,
      height: 2,
    );
  }

  String toArabicNumber(int number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    return number
        .toString()
        .split('')
        .map((e) => arabic[english.indexOf(e)])
        .join();
  }
}
