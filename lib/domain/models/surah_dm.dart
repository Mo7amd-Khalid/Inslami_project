class SurahDm {
  SurahDm({
    this.id,
    this.pageNumber,
    this.nameAr,
    this.nameEn,
    this.revelationType,
    this.versesCount,
  });

  SurahDm.fromJson(dynamic json) {
    id = json['id'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    revelationType = json['revelationType'];
    versesCount = json['versesCount'];
    pageNumber = json['pageIndex'];
  }

  int? id;
  int? pageNumber;
  String? nameAr;
  String? nameEn;
  String? revelationType;
  num? versesCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nameAr'] = nameAr;
    map['nameEn'] = nameEn;
    map['revelationType'] = revelationType;
    map['versesCount'] = versesCount;
    map['pageIndex'] = pageNumber;
    return map;
  }
}
