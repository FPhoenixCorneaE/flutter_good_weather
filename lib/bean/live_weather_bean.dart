/// code : "200"
/// updateTime : "2023-01-18T14:02+08:00"
/// fxLink : "http://hfx.link/2ax1"
/// now : {"obsTime":"2023-01-18T13:56+08:00","temp":"3","feelsLike":"-2","icon":"100","text":"晴","wind360":"219","windDir":"西南风","windScale":"3","windSpeed":"16","humidity":"23","precip":"0.0","pressure":"1018","vis":"14","cloud":"0","dew":"-16"}
/// refer : {"sources":["QWeather","NMC","ECMWF"],"license":["CC BY-SA 4.0"]}

class LiveWeatherBean {
  LiveWeatherBean({
      String? code, 
      String? updateTime, 
      String? fxLink, 
      Now? now, 
      Refer? refer,}){
    _code = code;
    _updateTime = updateTime;
    _fxLink = fxLink;
    _now = now;
    _refer = refer;
}

  LiveWeatherBean.fromJson(dynamic json) {
    _code = json['code'];
    _updateTime = json['updateTime'];
    _fxLink = json['fxLink'];
    _now = json['now'] != null ? Now.fromJson(json['now']) : null;
    _refer = json['refer'] != null ? Refer.fromJson(json['refer']) : null;
  }
  String? _code;
  String? _updateTime;
  String? _fxLink;
  Now? _now;
  Refer? _refer;
LiveWeatherBean copyWith({  String? code,
  String? updateTime,
  String? fxLink,
  Now? now,
  Refer? refer,
}) => LiveWeatherBean(  code: code ?? _code,
  updateTime: updateTime ?? _updateTime,
  fxLink: fxLink ?? _fxLink,
  now: now ?? _now,
  refer: refer ?? _refer,
);
  String? get code => _code;
  String? get updateTime => _updateTime;
  String? get fxLink => _fxLink;
  Now? get now => _now;
  Refer? get refer => _refer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['updateTime'] = _updateTime;
    map['fxLink'] = _fxLink;
    if (_now != null) {
      map['now'] = _now?.toJson();
    }
    if (_refer != null) {
      map['refer'] = _refer?.toJson();
    }
    return map;
  }

}

/// sources : ["QWeather","NMC","ECMWF"]
/// license : ["CC BY-SA 4.0"]

class Refer {
  Refer({
      List<String>? sources, 
      List<String>? license,}){
    _sources = sources;
    _license = license;
}

  Refer.fromJson(dynamic json) {
    _sources = json['sources'] != null ? json['sources'].cast<String>() : [];
    _license = json['license'] != null ? json['license'].cast<String>() : [];
  }
  List<String>? _sources;
  List<String>? _license;
Refer copyWith({  List<String>? sources,
  List<String>? license,
}) => Refer(  sources: sources ?? _sources,
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

/// obsTime : "2023-01-18T13:56+08:00"
/// temp : "3"
/// feelsLike : "-2"
/// icon : "100"
/// text : "晴"
/// wind360 : "219"
/// windDir : "西南风"
/// windScale : "3"
/// windSpeed : "16"
/// humidity : "23"
/// precip : "0.0"
/// pressure : "1018"
/// vis : "14"
/// cloud : "0"
/// dew : "-16"

class Now {
  Now({
      String? obsTime, 
      String? temp, 
      String? feelsLike, 
      String? icon, 
      String? text, 
      String? wind360, 
      String? windDir, 
      String? windScale, 
      String? windSpeed, 
      String? humidity, 
      String? precip, 
      String? pressure, 
      String? vis, 
      String? cloud, 
      String? dew,}){
    _obsTime = obsTime;
    _temp = temp;
    _feelsLike = feelsLike;
    _icon = icon;
    _text = text;
    _wind360 = wind360;
    _windDir = windDir;
    _windScale = windScale;
    _windSpeed = windSpeed;
    _humidity = humidity;
    _precip = precip;
    _pressure = pressure;
    _vis = vis;
    _cloud = cloud;
    _dew = dew;
}

  Now.fromJson(dynamic json) {
    _obsTime = json['obsTime'];
    _temp = json['temp'];
    _feelsLike = json['feelsLike'];
    _icon = json['icon'];
    _text = json['text'];
    _wind360 = json['wind360'];
    _windDir = json['windDir'];
    _windScale = json['windScale'];
    _windSpeed = json['windSpeed'];
    _humidity = json['humidity'];
    _precip = json['precip'];
    _pressure = json['pressure'];
    _vis = json['vis'];
    _cloud = json['cloud'];
    _dew = json['dew'];
  }
  String? _obsTime;
  String? _temp;
  String? _feelsLike;
  String? _icon;
  String? _text;
  String? _wind360;
  String? _windDir;
  String? _windScale;
  String? _windSpeed;
  String? _humidity;
  String? _precip;
  String? _pressure;
  String? _vis;
  String? _cloud;
  String? _dew;
Now copyWith({  String? obsTime,
  String? temp,
  String? feelsLike,
  String? icon,
  String? text,
  String? wind360,
  String? windDir,
  String? windScale,
  String? windSpeed,
  String? humidity,
  String? precip,
  String? pressure,
  String? vis,
  String? cloud,
  String? dew,
}) => Now(  obsTime: obsTime ?? _obsTime,
  temp: temp ?? _temp,
  feelsLike: feelsLike ?? _feelsLike,
  icon: icon ?? _icon,
  text: text ?? _text,
  wind360: wind360 ?? _wind360,
  windDir: windDir ?? _windDir,
  windScale: windScale ?? _windScale,
  windSpeed: windSpeed ?? _windSpeed,
  humidity: humidity ?? _humidity,
  precip: precip ?? _precip,
  pressure: pressure ?? _pressure,
  vis: vis ?? _vis,
  cloud: cloud ?? _cloud,
  dew: dew ?? _dew,
);
  String? get obsTime => _obsTime;
  String? get temp => _temp;
  String? get feelsLike => _feelsLike;
  String? get icon => _icon;
  String? get text => _text;
  String? get wind360 => _wind360;
  String? get windDir => _windDir;
  String? get windScale => _windScale;
  String? get windSpeed => _windSpeed;
  String? get humidity => _humidity;
  String? get precip => _precip;
  String? get pressure => _pressure;
  String? get vis => _vis;
  String? get cloud => _cloud;
  String? get dew => _dew;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['obsTime'] = _obsTime;
    map['temp'] = _temp;
    map['feelsLike'] = _feelsLike;
    map['icon'] = _icon;
    map['text'] = _text;
    map['wind360'] = _wind360;
    map['windDir'] = _windDir;
    map['windScale'] = _windScale;
    map['windSpeed'] = _windSpeed;
    map['humidity'] = _humidity;
    map['precip'] = _precip;
    map['pressure'] = _pressure;
    map['vis'] = _vis;
    map['cloud'] = _cloud;
    map['dew'] = _dew;
    return map;
  }

}