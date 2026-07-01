class QuranDm {
  QuranDm({
      this.pageIndex, 
      this.juz, 
      this.surahs,});

  QuranDm.fromJson(dynamic json) {
    pageIndex = json['pageIndex'];
    juz = json['juz'] != null ? json['juz'].cast<String>() : [];
    if (json['surahs'] != null) {
      surahs = [];
      json['surahs'].forEach((v) {
        surahs?.add(Surahs.fromJson(v));
      });
    }
  }
  num? pageIndex;
  List<String>? juz;
  List<Surahs>? surahs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageIndex'] = pageIndex;
    map['juz'] = juz;
    if (surahs != null) {
      map['surahs'] = surahs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Surahs {
  Surahs({
      this.titleAr, 
      this.titleEn, 
      this.ayahs,});

  Surahs.fromJson(dynamic json) {
    titleAr = json['titleAr'];
    titleEn = json['titleEn'];
    if (json['ayahs'] != null) {
      ayahs = [];
      json['ayahs'].forEach((v) {
        ayahs?.add(Ayahs.fromJson(v));
      });
    }
  }
  String? titleAr;
  String? titleEn;
  List<Ayahs>? ayahs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['titleAr'] = titleAr;
    map['titleEn'] = titleEn;
    if (ayahs != null) {
      map['ayahs'] = ayahs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Ayahs {
  Ayahs({
      this.ayahIndex, 
      this.text,});

  Ayahs.fromJson(dynamic json) {
    ayahIndex = json['ayahIndex'];
    text = json['text'];
  }
  num? ayahIndex;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ayahIndex'] = ayahIndex;
    map['text'] = text;
    return map;
  }

}