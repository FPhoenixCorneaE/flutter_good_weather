import 'dart:convert';

/// code : "200"
/// updateTime : "2023-12-11T09:40+08:00"
/// fxLink : "https://www.qweather.com"
/// summary : "未来两小时无降水"
/// minutely : [{"fxTime":"2023-12-11T09:40+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T09:45+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T09:50+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T09:55+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:00+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:05+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:10+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:15+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:20+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:25+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:30+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:35+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:40+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:45+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:50+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T10:55+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:00+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:05+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:10+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:15+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:20+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:25+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:30+08:00","precip":"0.00","type":"snow"},{"fxTime":"2023-12-11T11:35+08:00","precip":"0.00","type":"snow"}]
/// refer : {"sources":["QWeather"],"license":["CC BY-SA 4.0"]}

MinutelyWeatherBean minutelyWeatherBeanFromJson(String str) => MinutelyWeatherBean.fromJson(json.decode(str));

String minutelyWeatherBeanToJson(MinutelyWeatherBean data) => json.encode(data.toJson());

class MinutelyWeatherBean {
  MinutelyWeatherBean({
    String? code,
    String? updateTime,
    String? fxLink,
    String? summary,
    List<Minutely>? minutely,
    Refer? refer,
  }) {
    _code = code;
    _updateTime = updateTime;
    _fxLink = fxLink;
    _summary = summary;
    _minutely = minutely;
    _refer = refer;
  }

  MinutelyWeatherBean.fromJson(dynamic json) {
    _code = json['code'];
    _updateTime = json['updateTime'];
    _fxLink = json['fxLink'];
    _summary = json['summary'];
    if (json['minutely'] != null) {
      _minutely = [];
      json['minutely'].forEach((v) {
        _minutely?.add(Minutely.fromJson(v));
      });
    }
    _refer = json['refer'] != null ? Refer.fromJson(json['refer']) : null;
  }

  String? _code;
  String? _updateTime;
  String? _fxLink;
  String? _summary;
  List<Minutely>? _minutely;
  Refer? _refer;

  MinutelyWeatherBean copyWith({
    String? code,
    String? updateTime,
    String? fxLink,
    String? summary,
    List<Minutely>? minutely,
    Refer? refer,
  }) =>
      MinutelyWeatherBean(
        code: code ?? _code,
        updateTime: updateTime ?? _updateTime,
        fxLink: fxLink ?? _fxLink,
        summary: summary ?? _summary,
        minutely: minutely ?? _minutely,
        refer: refer ?? _refer,
      );

  String? get code => _code;

  String? get updateTime => _updateTime;

  String? get fxLink => _fxLink;

  String? get summary => _summary;

  List<Minutely>? get minutely => _minutely;

  Refer? get refer => _refer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['updateTime'] = _updateTime;
    map['fxLink'] = _fxLink;
    map['summary'] = _summary;
    if (_minutely != null) {
      map['minutely'] = _minutely?.map((v) => v.toJson()).toList();
    }
    if (_refer != null) {
      map['refer'] = _refer?.toJson();
    }
    return map;
  }
}

/// sources : ["QWeather"]
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

/// fxTime : "2023-12-11T09:40+08:00"
/// precip : "0.00"
/// type : "snow"

Minutely minutelyFromJson(String str) => Minutely.fromJson(json.decode(str));

String minutelyToJson(Minutely data) => json.encode(data.toJson());

class Minutely {
  Minutely({
    String? fxTime,
    String? precip,
    String? type,
  }) {
    _fxTime = fxTime;
    _precip = precip;
    _type = type;
  }

  Minutely.fromJson(dynamic json) {
    _fxTime = json['fxTime'];
    _precip = json['precip'];
    _type = json['type'];
  }

  String? _fxTime;
  String? _precip;
  String? _type;

  Minutely copyWith({
    String? fxTime,
    String? precip,
    String? type,
  }) =>
      Minutely(
        fxTime: fxTime ?? _fxTime,
        precip: precip ?? _precip,
        type: type ?? _type,
      );

  String? get fxTime => _fxTime;

  String? get precip => _precip;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fxTime'] = _fxTime;
    map['precip'] = _precip;
    map['type'] = _type;
    return map;
  }
}
