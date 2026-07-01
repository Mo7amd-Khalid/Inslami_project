class PrayerDm {
  final int code;
  final String status;
  final PrayerData? data;
  final String? message;

  PrayerDm({
    required this.code,
    required this.status,
    this.data,
    this.message
  });

  factory PrayerDm.fromJson(Map<String, dynamic> json) {
    return PrayerDm(
      code: json['code'],
      status: json['status'],
      data: PrayerData.fromJson(json['data']),
      message: json['message']
    );
  }
}

class PrayerData {
  final PrayerTimes times;
  final PrayerDate date;
  final Qibla qibla;
  final ProhibitedTimes prohibitedTimes;
  final Timezone timezone;

  PrayerData({
    required this.times,
    required this.date,
    required this.qibla,
    required this.prohibitedTimes,
    required this.timezone,
  });

  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      times: PrayerTimes.fromJson(json['times']),
      date: PrayerDate.fromJson(json['date']),
      qibla: Qibla.fromJson(json['qibla']),
      prohibitedTimes: ProhibitedTimes.fromJson(json['prohibited_times']),
      timezone: Timezone.fromJson(json['timezone']),
    );
  }
}

class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstThird;
  final String lastThird;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstThird,
    required this.lastThird,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      firstThird: json['Firstthird'],
      lastThird: json['Lastthird'],
    );
  }
}

class PrayerDate {
  final String readable;
  final String timestamp;
  final HijriDate hijri;
  final GregorianDate gregorian;

  PrayerDate({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory PrayerDate.fromJson(Map<String, dynamic> json) {
    return PrayerDate(
      readable: json['readable'],
      timestamp: json['timestamp'],
      hijri: HijriDate.fromJson(json['hijri']),
      gregorian: GregorianDate.fromJson(json['gregorian']),
    );
  }
}

class HijriDate {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final HijriMonth month;
  final String year;

  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: HijriMonth.fromJson(json['month']),
      year: json['year'],
    );
  }
}

class GregorianDate {
  final String date;
  final String format;
  final String day;
  final GregorianWeekday weekday;
  final GregorianMonth month;
  final String year;

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) {
    return GregorianDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: GregorianWeekday.fromJson(json['weekday']),
      month: GregorianMonth.fromJson(json['month']),
      year: json['year'],
    );
  }
}

class Weekday {
  final String en;
  final String ar;

  Weekday({
    required this.en,
    required this.ar,
  });

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(
      en: json['en'],
      ar: json['ar'],
    );
  }
}

class GregorianWeekday {
  final String en;

  GregorianWeekday({
    required this.en,
  });

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) {
    return GregorianWeekday(
      en: json['en'],
    );
  }
}

class HijriMonth {
  final int number;
  final String en;
  final String ar;
  final int days;

  HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
    required this.days,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) {
    return HijriMonth(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
      days: json['days'],
    );
  }
}

class GregorianMonth {
  final int number;
  final String en;

  GregorianMonth({
    required this.number,
    required this.en,
  });

  factory GregorianMonth.fromJson(Map<String, dynamic> json) {
    return GregorianMonth(
      number: json['number'],
      en: json['en'],
    );
  }
}

class Qibla {
  final Direction direction;
  final Distance distance;

  Qibla({
    required this.direction,
    required this.distance,
  });

  factory Qibla.fromJson(Map<String, dynamic> json) {
    return Qibla(
      direction: Direction.fromJson(json['direction']),
      distance: Distance.fromJson(json['distance']),
    );
  }
}

class Direction {
  final double degrees;
  final String from;
  final bool clockwise;

  Direction({
    required this.degrees,
    required this.from,
    required this.clockwise,
  });

  factory Direction.fromJson(Map<String, dynamic> json) {
    return Direction(
      degrees: (json['degrees'] as num).toDouble(),
      from: json['from'],
      clockwise: json['clockwise'],
    );
  }
}

class Distance {
  final double value;
  final String unit;

  Distance({
    required this.value,
    required this.unit,
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      value: (json['value'] as num).toDouble(),
      unit: json['unit'],
    );
  }
}

class ProhibitedTimes {
  final TimeRange sunrise;
  final TimeRange noon;
  final TimeRange sunset;

  ProhibitedTimes({
    required this.sunrise,
    required this.noon,
    required this.sunset,
  });

  factory ProhibitedTimes.fromJson(Map<String, dynamic> json) {
    return ProhibitedTimes(
      sunrise: TimeRange.fromJson(json['sunrise']),
      noon: TimeRange.fromJson(json['noon']),
      sunset: TimeRange.fromJson(json['sunset']),
    );
  }
}

class TimeRange {
  final String start;
  final String end;

  TimeRange({
    required this.start,
    required this.end,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      start: json['start'],
      end: json['end'],
    );
  }
}

class Timezone {
  final String name;
  final String utcOffset;
  final String abbreviation;

  Timezone({
    required this.name,
    required this.utcOffset,
    required this.abbreviation,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      name: json['name'],
      utcOffset: json['utc_offset'],
      abbreviation: json['abbreviation'],
    );
  }
}