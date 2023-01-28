/// code : "200"
/// updateTime : "2023-01-28T16:36+08:00"
/// fxLink : "http://hfx.link/2ax2"
/// daily : [{"date":"2023-01-28","type":"1","name":"运动指数","level":"2","category":"较适宜","text":"天气较好，无雨水困扰，较适宜进行各种运动，但因气温较低，在户外运动请注意增减衣物。"},{"date":"2023-01-28","type":"2","name":"洗车指数","level":"2","category":"较适宜","text":"较适宜洗车，未来一天无雨，风力较小，擦洗一新的汽车至少能保持一天。"},{"date":"2023-01-28","type":"3","name":"穿衣指数","level":"2","category":"冷","text":"天气冷，建议着棉服、羽绒服、皮夹克加羊毛衫等冬季服装。年老体弱者宜着厚棉衣、冬大衣或厚羽绒服。"},{"date":"2023-01-28","type":"4","name":"钓鱼指数","level":"2","category":"较适宜","text":"较适合垂钓，但天气稍凉，会对垂钓产生一定的影响。"},{"date":"2023-01-28","type":"5","name":"紫外线指数","level":"2","category":"弱","text":"紫外�\n2023-01-28 17:42:36.414 6296-6352/com.fphoenixcorneae.flutter_good_weather I/flutter: 凉，不过也是个好天气哦。适宜旅游，可不要错过机会呦！"},{"date":"2023-01-28","type":"7","name":"过敏指数","level":"1","category":"极不易发","text":"天气条件极不易诱发过敏，可放心外出，享受生活。"},{"date":"2023-01-28","type":"8","name":"舒适度指数","level":"2","category":"较舒适","text":"白天虽然天气晴好，但早晚会感觉偏凉，午后舒适、宜人。"},{"date":"2023-01-28","type":"9","name":"感冒指数","level":"2","category":"较易发","text":"昼夜温差较大，较易发生感冒，请适当增减衣服。体质较弱的朋友请注意防护。"}]
/// refer : {"sources":["QWeather"],"license":["CC BY-SA 4.0"]}

class LifeIndexBean {
  LifeIndexBean({
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

  LifeIndexBean.fromJson(dynamic json) {
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
LifeIndexBean copyWith({  String? code,
  String? updateTime,
  String? fxLink,
  List<Daily>? daily,
  Refer? refer,
}) => LifeIndexBean(  code: code ?? _code,
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

/// sources : ["QWeather"]
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

/// date : "2023-01-28"
/// type : "1"
/// name : "运动指数"
/// level : "2"
/// category : "较适宜"
/// text : "天气较好，无雨水困扰，较适宜进行各种运动，但因气温较低，在户外运动请注意增减衣物。"

class Daily {
  Daily({
      String? date, 
      String? type, 
      String? name, 
      String? level, 
      String? category, 
      String? text,}){
    _date = date;
    _type = type;
    _name = name;
    _level = level;
    _category = category;
    _text = text;
}

  Daily.fromJson(dynamic json) {
    _date = json['date'];
    _type = json['type'];
    _name = json['name'];
    _level = json['level'];
    _category = json['category'];
    _text = json['text'];
  }
  String? _date;
  String? _type;
  String? _name;
  String? _level;
  String? _category;
  String? _text;
Daily copyWith({  String? date,
  String? type,
  String? name,
  String? level,
  String? category,
  String? text,
}) => Daily(  date: date ?? _date,
  type: type ?? _type,
  name: name ?? _name,
  level: level ?? _level,
  category: category ?? _category,
  text: text ?? _text,
);
  String? get date => _date;
  String? get type => _type;
  String? get name => _name;
  String? get level => _level;
  String? get category => _category;
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['type'] = _type;
    map['name'] = _name;
    map['level'] = _level;
    map['category'] = _category;
    map['text'] = _text;
    return map;
  }

}