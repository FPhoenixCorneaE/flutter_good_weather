/// code : "200"
/// location : [{"name":"北京","id":"101010100","lat":"39.90499","lon":"116.40529","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"10","fxLink":"http://hfx.link/2ax1"},{"name":"海淀","id":"101010200","lat":"39.95607","lon":"116.31032","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"15","fxLink":"http://hfx.link/2ay1"},{"name":"朝阳","id":"101010300","lat":"39.92149","lon":"116.48641","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"15","fxLink":"http://hfx.link/2az1"},{"name":"昌平","id":"101010700","lat":"40.21809","lon":"116.23591","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"23","fxLink":"http://hfx.link/2b31"},{"name":"房山","id":"101011200","lat":"39.73554","lon":"116.13916","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"23","fxLink":"http://hfx.link/2b81"},{"name":"通州","id":"101010600","lat":"39.90249","lon":"116.65860","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"23","fxLink":"http://hfx.link/2b21"},{"name":"丰台","id":"101010900","lat":"39.86364","lon":"116.28696","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"25","fxLink":"http://hfx.link/2b51"},{"name":"大兴","id":"101011100","lat":"39.72891","lon":"116.33804","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"25","fxLink":"http://hfx.link/2b71"},{"name":"延庆","id":"101010800","lat":"40.46532","lon":"115.98501","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"33","fxLink":"http://hfx.link/2b41"},{"name":"平谷","id":"101011500","lat":"40.14478","lon":"117.11234","adm2":"北京","adm1":"北京市","country":"中国","tz":"Asia/Shanghai","utcOffset":"+08:00","isDst":"0","type":"city","rank":"33","fxLink":"http://hfx.link/2bb1"}]
/// refer : {"sources":["QWeather"],"license":["QWeather Developers License"]}

class SearchCityBean {
  SearchCityBean({
    String? code,
    List<Location>? location,
    Refer? refer,
  }) {
    _code = code;
    _location = location;
    _refer = refer;
  }

  SearchCityBean.fromJson(dynamic json) {
    _code = json['code'];
    if (json['location'] != null) {
      _location = [];
      json['location'].forEach((v) {
        _location?.add(Location.fromJson(v));
      });
    }
    _refer = json['refer'] != null ? Refer.fromJson(json['refer']) : null;
  }

  String? _code;
  List<Location>? _location;
  Refer? _refer;

  SearchCityBean copyWith({
    String? code,
    List<Location>? location,
    Refer? refer,
  }) =>
      SearchCityBean(
        code: code ?? _code,
        location: location ?? _location,
        refer: refer ?? _refer,
      );

  String? get code => _code;

  List<Location>? get location => _location;

  Refer? get refer => _refer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_location != null) {
      map['location'] = _location?.map((v) => v.toJson()).toList();
    }
    if (_refer != null) {
      map['refer'] = _refer?.toJson();
    }
    return map;
  }
}

/// sources : ["QWeather"]
/// license : ["QWeather Developers License"]

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

/// name : "北京"
/// id : "101010100"
/// lat : "39.90499"
/// lon : "116.40529"
/// adm2 : "北京"
/// adm1 : "北京市"
/// country : "中国"
/// tz : "Asia/Shanghai"
/// utcOffset : "+08:00"
/// isDst : "0"
/// type : "city"
/// rank : "10"
/// fxLink : "http://hfx.link/2ax1"

class Location {
  Location({
    String? name,
    String? id,
    String? lat,
    String? lon,
    String? adm2,
    String? adm1,
    String? country,
    String? tz,
    String? utcOffset,
    String? isDst,
    String? type,
    String? rank,
    String? fxLink,
  }) {
    _name = name;
    _id = id;
    _lat = lat;
    _lon = lon;
    _adm2 = adm2;
    _adm1 = adm1;
    _country = country;
    _tz = tz;
    _utcOffset = utcOffset;
    _isDst = isDst;
    _type = type;
    _rank = rank;
    _fxLink = fxLink;
  }

  Location.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _lat = json['lat'];
    _lon = json['lon'];
    _adm2 = json['adm2'];
    _adm1 = json['adm1'];
    _country = json['country'];
    _tz = json['tz'];
    _utcOffset = json['utcOffset'];
    _isDst = json['isDst'];
    _type = json['type'];
    _rank = json['rank'];
    _fxLink = json['fxLink'];
  }

  String? _name;
  String? _id;
  String? _lat;
  String? _lon;
  String? _adm2;
  String? _adm1;
  String? _country;
  String? _tz;
  String? _utcOffset;
  String? _isDst;
  String? _type;
  String? _rank;
  String? _fxLink;

  Location copyWith({
    String? name,
    String? id,
    String? lat,
    String? lon,
    String? adm2,
    String? adm1,
    String? country,
    String? tz,
    String? utcOffset,
    String? isDst,
    String? type,
    String? rank,
    String? fxLink,
  }) =>
      Location(
        name: name ?? _name,
        id: id ?? _id,
        lat: lat ?? _lat,
        lon: lon ?? _lon,
        adm2: adm2 ?? _adm2,
        adm1: adm1 ?? _adm1,
        country: country ?? _country,
        tz: tz ?? _tz,
        utcOffset: utcOffset ?? _utcOffset,
        isDst: isDst ?? _isDst,
        type: type ?? _type,
        rank: rank ?? _rank,
        fxLink: fxLink ?? _fxLink,
      );

  String? get name => _name;

  String? get id => _id;

  String? get lat => _lat;

  String? get lon => _lon;

  String? get adm2 => _adm2;

  String? get adm1 => _adm1;

  String? get country => _country;

  String? get tz => _tz;

  String? get utcOffset => _utcOffset;

  String? get isDst => _isDst;

  String? get type => _type;

  String? get rank => _rank;

  String? get fxLink => _fxLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['adm2'] = _adm2;
    map['adm1'] = _adm1;
    map['country'] = _country;
    map['tz'] = _tz;
    map['utcOffset'] = _utcOffset;
    map['isDst'] = _isDst;
    map['type'] = _type;
    map['rank'] = _rank;
    map['fxLink'] = _fxLink;
    return map;
  }
}
