import 'dart:convert';

/// code : "200"
/// updateTime : "2023-04-03T14:20+08:00"
/// fxLink : "https://www.qweather.com/severe-weather/shanghai-101020100.html"
/// warning : [{"id":"10102010020230403103000500681616","sender":"上海中心气象台","pubTime":"2023-04-03T10:30+08:00","title":"上海中心气象台发布大风蓝色预警[Ⅳ级/一般]","startTime":"2023-04-03T10:30+08:00","endTime":"2023-04-04T10:30+08:00","status":"active","level":"","severity":"Minor","severityColor":"Blue","type":"1006","typeName":"大风","urgency":"","certainty":"","text":"上海中心气象台2023年04月03日10时30分发布大风蓝色预警[Ⅳ级/一般]：受江淮气旋影响，预计明天傍晚以前本市大部地区将出现6级阵风7-8级的东南大风，沿江沿海地区7级阵风8-9级，请注意防范大风对高空作业、交通出行、设施农业等的不利影响。","related":""}]
/// refer : {"sources":["12379"],"license":["QWeather Developers License"]}

DisasterWarningBean disasterWarningBeanFromJson(String str) => DisasterWarningBean.fromJson(json.decode(str));

String disasterWarningBeanToJson(DisasterWarningBean data) => json.encode(data.toJson());

class DisasterWarningBean {
  DisasterWarningBean({
    String? code,
    String? updateTime,
    String? fxLink,
    List<Warning>? warning,
    Refer? refer,
  }) {
    _code = code;
    _updateTime = updateTime;
    _fxLink = fxLink;
    _warning = warning;
    _refer = refer;
  }

  DisasterWarningBean.fromJson(dynamic json) {
    _code = json['code'];
    _updateTime = json['updateTime'];
    _fxLink = json['fxLink'];
    if (json['warning'] != null) {
      _warning = [];
      json['warning'].forEach((v) {
        _warning?.add(Warning.fromJson(v));
      });
    }
    _refer = json['refer'] != null ? Refer.fromJson(json['refer']) : null;
  }

  String? _code;
  String? _updateTime;
  String? _fxLink;
  List<Warning>? _warning;
  Refer? _refer;

  DisasterWarningBean copyWith({
    String? code,
    String? updateTime,
    String? fxLink,
    List<Warning>? warning,
    Refer? refer,
  }) =>
      DisasterWarningBean(
        code: code ?? _code,
        updateTime: updateTime ?? _updateTime,
        fxLink: fxLink ?? _fxLink,
        warning: warning ?? _warning,
        refer: refer ?? _refer,
      );

  String? get code => _code;

  String? get updateTime => _updateTime;

  String? get fxLink => _fxLink;

  List<Warning>? get warning => _warning;

  Refer? get refer => _refer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['updateTime'] = _updateTime;
    map['fxLink'] = _fxLink;
    if (_warning != null) {
      map['warning'] = _warning?.map((v) => v.toJson()).toList();
    }
    if (_refer != null) {
      map['refer'] = _refer?.toJson();
    }
    return map;
  }
}

/// sources : ["12379"]
/// license : ["QWeather Developers License"]

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

/// id : "10102010020230403103000500681616"
/// sender : "上海中心气象台"
/// pubTime : "2023-04-03T10:30+08:00"
/// title : "上海中心气象台发布大风蓝色预警[Ⅳ级/一般]"
/// startTime : "2023-04-03T10:30+08:00"
/// endTime : "2023-04-04T10:30+08:00"
/// status : "active"
/// level : ""
/// severity : "Minor"
/// severityColor : "Blue"
/// type : "1006"
/// typeName : "大风"
/// urgency : ""
/// certainty : ""
/// text : "上海中心气象台2023年04月03日10时30分发布大风蓝色预警[Ⅳ级/一般]：受江淮气旋影响，预计明天傍晚以前本市大部地区将出现6级阵风7-8级的东南大风，沿江沿海地区7级阵风8-9级，请注意防范大风对高空作业、交通出行、设施农业等的不利影响。"
/// related : ""

Warning warningFromJson(String str) => Warning.fromJson(json.decode(str));

String warningToJson(Warning data) => json.encode(data.toJson());

class Warning {
  Warning({
    String? id,
    String? sender,
    String? pubTime,
    String? title,
    String? startTime,
    String? endTime,
    String? status,
    String? level,
    String? severity,
    String? severityColor,
    String? type,
    String? typeName,
    String? urgency,
    String? certainty,
    String? text,
    String? related,
  }) {
    _id = id;
    _sender = sender;
    _pubTime = pubTime;
    _title = title;
    _startTime = startTime;
    _endTime = endTime;
    _status = status;
    _level = level;
    _severity = severity;
    _severityColor = severityColor;
    _type = type;
    _typeName = typeName;
    _urgency = urgency;
    _certainty = certainty;
    _text = text;
    _related = related;
  }

  Warning.fromJson(dynamic json) {
    _id = json['id'];
    _sender = json['sender'];
    _pubTime = json['pubTime'];
    _title = json['title'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _status = json['status'];
    _level = json['level'];
    _severity = json['severity'];
    _severityColor = json['severityColor'];
    _type = json['type'];
    _typeName = json['typeName'];
    _urgency = json['urgency'];
    _certainty = json['certainty'];
    _text = json['text'];
    _related = json['related'];
  }

  String? _id;
  String? _sender;
  String? _pubTime;
  String? _title;
  String? _startTime;
  String? _endTime;
  String? _status;
  String? _level;
  String? _severity;
  String? _severityColor;
  String? _type;
  String? _typeName;
  String? _urgency;
  String? _certainty;
  String? _text;
  String? _related;

  Warning copyWith({
    String? id,
    String? sender,
    String? pubTime,
    String? title,
    String? startTime,
    String? endTime,
    String? status,
    String? level,
    String? severity,
    String? severityColor,
    String? type,
    String? typeName,
    String? urgency,
    String? certainty,
    String? text,
    String? related,
  }) =>
      Warning(
        id: id ?? _id,
        sender: sender ?? _sender,
        pubTime: pubTime ?? _pubTime,
        title: title ?? _title,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        status: status ?? _status,
        level: level ?? _level,
        severity: severity ?? _severity,
        severityColor: severityColor ?? _severityColor,
        type: type ?? _type,
        typeName: typeName ?? _typeName,
        urgency: urgency ?? _urgency,
        certainty: certainty ?? _certainty,
        text: text ?? _text,
        related: related ?? _related,
      );

  String? get id => _id;

  String? get sender => _sender;

  String? get pubTime => _pubTime;

  String? get title => _title;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get status => _status;

  String? get level => _level;

  String? get severity => _severity;

  String? get severityColor => _severityColor;

  String? get type => _type;

  String? get typeName => _typeName;

  String? get urgency => _urgency;

  String? get certainty => _certainty;

  String? get text => _text;

  String? get related => _related;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sender'] = _sender;
    map['pubTime'] = _pubTime;
    map['title'] = _title;
    map['startTime'] = _startTime;
    map['endTime'] = _endTime;
    map['status'] = _status;
    map['level'] = _level;
    map['severity'] = _severity;
    map['severityColor'] = _severityColor;
    map['type'] = _type;
    map['typeName'] = _typeName;
    map['urgency'] = _urgency;
    map['certainty'] = _certainty;
    map['text'] = _text;
    map['related'] = _related;
    return map;
  }
}
