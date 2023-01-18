/// code : "200"
/// updateTime : "2023-01-18T16:35+08:00"
/// fxLink : "http://hfx.link/2ax1"
/// daily : [{"fxDate":"2023-01-18","sunrise":"07:32","sunset":"17:18","moonrise":"03:54","moonset":"13:24","moonPhase":"残月","moonPhaseIcon":"807","tempMax":"4","tempMin":"-6","iconDay":"100","textDay":"晴","iconNight":"150","textNight":"晴","wind360Day":"225","windDirDay":"西南风","windScaleDay":"1-2","windSpeedDay":"3","wind360Night":"0","windDirNight":"北风","windScaleNight":"1-2","windSpeedNight":"3","humidity":"39","precip":"0.0","pressure":"1014","vis":"25","cloud":"0","uvIndex":"2"},{"fxDate":"2023-01-19","sunrise":"07:32","sunset":"17:19","moonrise":"05:08","moonset":"14:14","moonPhase":"残月","moonPhaseIcon":"807","tempMax":"4","tempMin":"-10","iconDay":"100","textDay":"晴","iconNight":"150","textNight":"晴","wind360Day":"315","windDirDay":"西北风","windScaleDay":"3-4","windSpeedDay":"24","wind360Night":"315","windDirNight":"西北风","windScaleNight":"3-4","windSpeedNight":"16","humidity":"21","precip":"0.0","pressure":"1028","vis":"25","cloud":"3","uvIndex":"2"},{"fxDate":"2023-01-20","sunrise":"07:31","sunset":"17:20","moonrise":"06:17","moonset":"15:15","moonPhase":"残月","moonPhaseIcon":"807","tempMax":"-2","tempMin":"-10","iconDay":"100","textDay":"晴","iconNight":"150","textNight":"晴","wind360Day":"180","windDirDay":"南风","windScaleDay":"1-2","windSpeedDay":"3","wind360Night":"180","windDirNight":"南风","windScaleNight":"1-2","windSpeedNight":"3","humidity":"27","precip":"0.0","pressure":"1019","vis":"25","cloud":"1","uvIndex":"2"},{"fxDate":"2023-01-21","sunrise":"07:31","sunset":"17:21","moonrise":"07:18","moonset":"16:26","moonPhase":"残月","moonPhaseIcon":"807","tempMax":"3","tempMin":"-8","iconDay":"100","textDay":"晴","iconNight":"150","textNight":"晴","wind360Day":"225","windDirDay":"西南风","windScaleDay":"1-2","windSpeedDay":"3","wind360Night":"270","windDirNight":"西风","windScaleNight":"1-2","windSpeedNight":"3","humidity":"38","precip":"0.0","pressure":"1020","vis":"25","cloud":"0","uvIndex":"3"},{"fxDate":"2023-01-22","sunrise":"07:30","sunset":"17:23","moonrise":"08:07","moonset":"17:42","moonPhase":"新月","moonPhaseIcon":"800","tempMax":"0","tempMin":"-10","iconDay":"101","textDay":"多云","iconNight":"151","textNight":"多云","wind360Day":"90","windDirDay":"东风","windScaleDay":"1-2","windSpeedDay":"3","wind360Night":"0","windDirNight":"北风","windScaleNight":"1-2","windSpeedNight":"3","humidity":"56","precip":"0.0","pressure":"1029","vis":"25","cloud":"5","uvIndex":"1"},{"fxDate":"2023-01-23","sunrise":"07:30","sunset":"17:24","moonrise":"08:48","moonset":"19:00","moonPhase":"峨眉月","moonPhaseIcon":"801","tempMax":"-3","tempMin":"-12","iconDay":"101","textDay":"多云","iconNight":"150","textNight":"晴","wind360Day":"315","windDirDay":"西北风","windScaleDay":"3-4","windSpeedDay":"16","wind360Night":"0","windDirNight":"北风","windScaleNight":"1-2","windSpeedNight":"3","humidity":"30","precip":"0.0","pressure":"1036","vis":"23","cloud":"0","uvIndex":"3"},{"fxDate":"2023-01-24","sunrise":"07:29","sunset":"17:25","moonrise":"09:21","moonset":"20:15","moonPhase":"峨眉月","moonPhaseIcon":"801","tempMax":"-3","tempMin":"-12","iconDay":"100","textDay":"晴","iconNight":"150","textNight":"晴","wind360Day":"180","windDirDay":"南风","windScaleDay":"1-2","windSpeedDay":"3","wind360Night":"180","windDirNight":"南风","windScaleNight":"1-2","windSpeedNight":"3","humidity":"28","precip":"0.0","pressure":"1030","vis":"25","cloud":"0","uvIndex":"3"}]
/// refer : {"sources":["QWeather","NMC","ECMWF"],"license":["CC BY-SA 4.0"]}

class DailyWeatherBean {
  DailyWeatherBean({
      String? code, 
      String? updateTime, 
      String? fxLink, 
      List<Daily>? daily, 
      Refer? refer,}){
    _code = code;
    _updateTime = updateTime;
    _fxLink = fxLink;
    _daily = daily;
    _refer = refer;
}

  DailyWeatherBean.fromJson(dynamic json) {
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
DailyWeatherBean copyWith({  String? code,
  String? updateTime,
  String? fxLink,
  List<Daily>? daily,
  Refer? refer,
}) => DailyWeatherBean(  code: code ?? _code,
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

/// fxDate : "2023-01-18"
/// sunrise : "07:32"
/// sunset : "17:18"
/// moonrise : "03:54"
/// moonset : "13:24"
/// moonPhase : "残月"
/// moonPhaseIcon : "807"
/// tempMax : "4"
/// tempMin : "-6"
/// iconDay : "100"
/// textDay : "晴"
/// iconNight : "150"
/// textNight : "晴"
/// wind360Day : "225"
/// windDirDay : "西南风"
/// windScaleDay : "1-2"
/// windSpeedDay : "3"
/// wind360Night : "0"
/// windDirNight : "北风"
/// windScaleNight : "1-2"
/// windSpeedNight : "3"
/// humidity : "39"
/// precip : "0.0"
/// pressure : "1014"
/// vis : "25"
/// cloud : "0"
/// uvIndex : "2"

class Daily {
  Daily({
      String? fxDate, 
      String? sunrise, 
      String? sunset, 
      String? moonrise, 
      String? moonset, 
      String? moonPhase, 
      String? moonPhaseIcon, 
      String? tempMax, 
      String? tempMin, 
      String? iconDay, 
      String? textDay, 
      String? iconNight, 
      String? textNight, 
      String? wind360Day, 
      String? windDirDay, 
      String? windScaleDay, 
      String? windSpeedDay, 
      String? wind360Night, 
      String? windDirNight, 
      String? windScaleNight, 
      String? windSpeedNight, 
      String? humidity, 
      String? precip, 
      String? pressure, 
      String? vis, 
      String? cloud, 
      String? uvIndex,}){
    _fxDate = fxDate;
    _sunrise = sunrise;
    _sunset = sunset;
    _moonrise = moonrise;
    _moonset = moonset;
    _moonPhase = moonPhase;
    _moonPhaseIcon = moonPhaseIcon;
    _tempMax = tempMax;
    _tempMin = tempMin;
    _iconDay = iconDay;
    _textDay = textDay;
    _iconNight = iconNight;
    _textNight = textNight;
    _wind360Day = wind360Day;
    _windDirDay = windDirDay;
    _windScaleDay = windScaleDay;
    _windSpeedDay = windSpeedDay;
    _wind360Night = wind360Night;
    _windDirNight = windDirNight;
    _windScaleNight = windScaleNight;
    _windSpeedNight = windSpeedNight;
    _humidity = humidity;
    _precip = precip;
    _pressure = pressure;
    _vis = vis;
    _cloud = cloud;
    _uvIndex = uvIndex;
}

  Daily.fromJson(dynamic json) {
    _fxDate = json['fxDate'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
    _moonrise = json['moonrise'];
    _moonset = json['moonset'];
    _moonPhase = json['moonPhase'];
    _moonPhaseIcon = json['moonPhaseIcon'];
    _tempMax = json['tempMax'];
    _tempMin = json['tempMin'];
    _iconDay = json['iconDay'];
    _textDay = json['textDay'];
    _iconNight = json['iconNight'];
    _textNight = json['textNight'];
    _wind360Day = json['wind360Day'];
    _windDirDay = json['windDirDay'];
    _windScaleDay = json['windScaleDay'];
    _windSpeedDay = json['windSpeedDay'];
    _wind360Night = json['wind360Night'];
    _windDirNight = json['windDirNight'];
    _windScaleNight = json['windScaleNight'];
    _windSpeedNight = json['windSpeedNight'];
    _humidity = json['humidity'];
    _precip = json['precip'];
    _pressure = json['pressure'];
    _vis = json['vis'];
    _cloud = json['cloud'];
    _uvIndex = json['uvIndex'];
  }
  String? _fxDate;
  String? _sunrise;
  String? _sunset;
  String? _moonrise;
  String? _moonset;
  String? _moonPhase;
  String? _moonPhaseIcon;
  String? _tempMax;
  String? _tempMin;
  String? _iconDay;
  String? _textDay;
  String? _iconNight;
  String? _textNight;
  String? _wind360Day;
  String? _windDirDay;
  String? _windScaleDay;
  String? _windSpeedDay;
  String? _wind360Night;
  String? _windDirNight;
  String? _windScaleNight;
  String? _windSpeedNight;
  String? _humidity;
  String? _precip;
  String? _pressure;
  String? _vis;
  String? _cloud;
  String? _uvIndex;
Daily copyWith({  String? fxDate,
  String? sunrise,
  String? sunset,
  String? moonrise,
  String? moonset,
  String? moonPhase,
  String? moonPhaseIcon,
  String? tempMax,
  String? tempMin,
  String? iconDay,
  String? textDay,
  String? iconNight,
  String? textNight,
  String? wind360Day,
  String? windDirDay,
  String? windScaleDay,
  String? windSpeedDay,
  String? wind360Night,
  String? windDirNight,
  String? windScaleNight,
  String? windSpeedNight,
  String? humidity,
  String? precip,
  String? pressure,
  String? vis,
  String? cloud,
  String? uvIndex,
}) => Daily(  fxDate: fxDate ?? _fxDate,
  sunrise: sunrise ?? _sunrise,
  sunset: sunset ?? _sunset,
  moonrise: moonrise ?? _moonrise,
  moonset: moonset ?? _moonset,
  moonPhase: moonPhase ?? _moonPhase,
  moonPhaseIcon: moonPhaseIcon ?? _moonPhaseIcon,
  tempMax: tempMax ?? _tempMax,
  tempMin: tempMin ?? _tempMin,
  iconDay: iconDay ?? _iconDay,
  textDay: textDay ?? _textDay,
  iconNight: iconNight ?? _iconNight,
  textNight: textNight ?? _textNight,
  wind360Day: wind360Day ?? _wind360Day,
  windDirDay: windDirDay ?? _windDirDay,
  windScaleDay: windScaleDay ?? _windScaleDay,
  windSpeedDay: windSpeedDay ?? _windSpeedDay,
  wind360Night: wind360Night ?? _wind360Night,
  windDirNight: windDirNight ?? _windDirNight,
  windScaleNight: windScaleNight ?? _windScaleNight,
  windSpeedNight: windSpeedNight ?? _windSpeedNight,
  humidity: humidity ?? _humidity,
  precip: precip ?? _precip,
  pressure: pressure ?? _pressure,
  vis: vis ?? _vis,
  cloud: cloud ?? _cloud,
  uvIndex: uvIndex ?? _uvIndex,
);
  String? get fxDate => _fxDate;
  String? get sunrise => _sunrise;
  String? get sunset => _sunset;
  String? get moonrise => _moonrise;
  String? get moonset => _moonset;
  String? get moonPhase => _moonPhase;
  String? get moonPhaseIcon => _moonPhaseIcon;
  String? get tempMax => _tempMax;
  String? get tempMin => _tempMin;
  String? get iconDay => _iconDay;
  String? get textDay => _textDay;
  String? get iconNight => _iconNight;
  String? get textNight => _textNight;
  String? get wind360Day => _wind360Day;
  String? get windDirDay => _windDirDay;
  String? get windScaleDay => _windScaleDay;
  String? get windSpeedDay => _windSpeedDay;
  String? get wind360Night => _wind360Night;
  String? get windDirNight => _windDirNight;
  String? get windScaleNight => _windScaleNight;
  String? get windSpeedNight => _windSpeedNight;
  String? get humidity => _humidity;
  String? get precip => _precip;
  String? get pressure => _pressure;
  String? get vis => _vis;
  String? get cloud => _cloud;
  String? get uvIndex => _uvIndex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fxDate'] = _fxDate;
    map['sunrise'] = _sunrise;
    map['sunset'] = _sunset;
    map['moonrise'] = _moonrise;
    map['moonset'] = _moonset;
    map['moonPhase'] = _moonPhase;
    map['moonPhaseIcon'] = _moonPhaseIcon;
    map['tempMax'] = _tempMax;
    map['tempMin'] = _tempMin;
    map['iconDay'] = _iconDay;
    map['textDay'] = _textDay;
    map['iconNight'] = _iconNight;
    map['textNight'] = _textNight;
    map['wind360Day'] = _wind360Day;
    map['windDirDay'] = _windDirDay;
    map['windScaleDay'] = _windScaleDay;
    map['windSpeedDay'] = _windSpeedDay;
    map['wind360Night'] = _wind360Night;
    map['windDirNight'] = _windDirNight;
    map['windScaleNight'] = _windScaleNight;
    map['windSpeedNight'] = _windSpeedNight;
    map['humidity'] = _humidity;
    map['precip'] = _precip;
    map['pressure'] = _pressure;
    map['vis'] = _vis;
    map['cloud'] = _cloud;
    map['uvIndex'] = _uvIndex;
    return map;
  }

}