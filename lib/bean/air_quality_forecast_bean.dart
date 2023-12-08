import 'dart:convert';

/// code : "200"
/// updateTime : "2023-12-08T08:42+08:00"
/// fxLink : "https://www.qweather.com/air/shenzhen-101280601.html"
/// daily : [{"fxDate":"2023-12-08","aqi":"56","level":"2","category":"良","primary":"O3"},{"fxDate":"2023-12-09","aqi":"52","level":"2","category":"良","primary":"O3"},{"fxDate":"2023-12-10","aqi":"51","level":"2","category":"良","primary":"O3"},{"fxDate":"2023-12-11","aqi":"56","level":"2","category":"良","primary":"O3"},{"fxDate":"2023-12-12","aqi":"51","level":"2","category":"良","primary":"O3"}]
/// refer : {"sources":["中国环境监测总站 (CNEMC)"],"license":["CC BY-SA 4.0"]}

AirQualityForecastBean airQualityForecastBeanFromJson(String str) => AirQualityForecastBean.fromJson(json.decode(str));

String airQualityForecastBeanToJson(AirQualityForecastBean data) => json.encode(data.toJson());

class AirQualityForecastBean {
  AirQualityForecastBean({
    String? code,
    String? updateTime,
    String? fxLink,
    List<Daily>? daily,
    Refer? refer,
  }) {
    _code = code;
    _updateTime = updateTime;
    _fxLink = fxLink;
    _daily = daily;
    _refer = refer;
  }

  AirQualityForecastBean.fromJson(dynamic json) {
    _code = json['code'];
    _updateTime = json['updateTime'];
    _fxLink = json['fxLink'];
    if (json['daily'] != null) {
      _daily = [];
      json['daily'].forEach((v) {
        _daily?.add(Daily.fromJson(v));
      });
    }
    _refer = json['refer'] != null ? Refer.fromJson(json['refer']) : null;
  }

  String? _code;
  String? _updateTime;
  String? _fxLink;
  List<Daily>? _daily;
  Refer? _refer;

  AirQualityForecastBean copyWith({
    String? code,
    String? updateTime,
    String? fxLink,
    List<Daily>? daily,
    Refer? refer,
  }) =>
      AirQualityForecastBean(
        code: code ?? _code,
        updateTime: updateTime ?? _updateTime,
        fxLink: fxLink ?? _fxLink,
        daily: daily ?? _daily,
        refer: refer ?? _refer,
      );

  String? get code => _code;

  String? get updateTime => _updateTime;

  String? get fxLink => _fxLink;

  List<Daily>? get daily => _daily;

  Refer? get refer => _refer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['updateTime'] = _updateTime;
    map['fxLink'] = _fxLink;
    if (_daily != null) {
      map['daily'] = _daily?.map((v) => v.toJson()).toList();
    }
    if (_refer != null) {
      map['refer'] = _refer?.toJson();
    }
    return map;
  }
}

/// sources : ["中国环境监测总站 (CNEMC)"]
/// license : ["CC BY-SA 4.0"]

Refer referFromJson(String str) => Refer.fromJson(json.decode(str));

String referToJson(Refer data) => json.encode(data.toJson());

class Refer {
  Refer({
    List<String>? sources,
    List<String>? license,
  }) {
    _sources = sources;
    _license = license;
  }

  Refer.fromJson(dynamic json) {
    _sources = json['sources'] != null ? json['sources'].cast<String>() : [];
    _license = json['license'] != null ? json['license'].cast<String>() : [];
  }

  List<String>? _sources;
  List<String>? _license;

  Refer copyWith({
    List<String>? sources,
    List<String>? license,
  }) =>
      Refer(
        sources: sources ?? _sources,
        license: license ?? _license,
      );

  List<String>? get sources => _sources;

  List<String>? get license => _license;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sources'] = _sources;
    map['license'] = _license;
    return map;
  }
}

/// fxDate : "2023-12-08"
/// aqi : "56"
/// level : "2"
/// category : "良"
/// primary : "O3"

Daily dailyFromJson(String str) => Daily.fromJson(json.decode(str));

String dailyToJson(Daily data) => json.encode(data.toJson());

class Daily {
  Daily({
    String? fxDate,
    String? aqi,
    String? level,
    String? category,
    String? primary,
  }) {
    _fxDate = fxDate;
    _aqi = aqi;
    _level = level;
    _category = category;
    _primary = primary;
  }

  Daily.fromJson(dynamic json) {
    _fxDate = json['fxDate'];
    _aqi = json['aqi'];
    _level = json['level'];
    _category = json['category'];
    _primary = json['primary'];
  }

  String? _fxDate;
  String? _aqi;
  String? _level;
  String? _category;
  String? _primary;

  Daily copyWith({
    String? fxDate,
    String? aqi,
    String? level,
    String? category,
    String? primary,
  }) =>
      Daily(
        fxDate: fxDate ?? _fxDate,
        aqi: aqi ?? _aqi,
        level: level ?? _level,
        category: category ?? _category,
        primary: primary ?? _primary,
      );

  String? get fxDate => _fxDate;

  String? get aqi => _aqi;

  String? get level => _level;

  String? get category => _category;

  String? get primary => _primary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fxDate'] = _fxDate;
    map['aqi'] = _aqi;
    map['level'] = _level;
    map['category'] = _category;
    map['primary'] = _primary;
    return map;
  }
}
