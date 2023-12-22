import 'dart:convert';

/// images : [{"startdate":"20231221","fullstartdate":"202312211600","enddate":"20231222","url":"/th?id=OHR.WinterSolstice2023_ZH-CN4450201916_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp","urlbase":"/th?id=OHR.WinterSolstice2023_ZH-CN4450201916","copyright":"天鹅泉湿地公园，伊犁，新疆，中国 (© 500px Asia/Getty images)","copyrightlink":"https://www.bing.com/search?q=%E6%96%B0%E7%96%86%E5%A4%A9%E9%B9%85%E6%B3%89%E6%B9%BF%E5%9C%B0%E5%85%AC%E5%9B%AD&form=hpcapt&mkt=zh-cn","title":"冬季仙境中的精灵","quiz":"/search?q=Bing+homepage+quiz&filters=WQOskey:%22HPQuiz_20231221_WinterSolstice2023%22&FORM=HPQUIZ","wp":true,"hsh":"7c7dfa101b23f413158948722a8768c2","drk":1,"top":1,"bot":1,"hs":[]}]
/// tooltips : {"loading":"正在加载...","previous":"上一个图像","next":"下一个图像","walle":"此图片不能下载用作壁纸。","walls":"下载今日美图。仅限用作桌面壁纸。"}

BingDailyImageBean bingDailyImageBeanFromJson(String str) => BingDailyImageBean.fromJson(json.decode(str));

String bingDailyImageBeanToJson(BingDailyImageBean data) => json.encode(data.toJson());

class BingDailyImageBean {
  BingDailyImageBean({
    List<Images>? images,
    Tooltips? tooltips,
  }) {
    _images = images;
    _tooltips = tooltips;
  }

  BingDailyImageBean.fromJson(dynamic json) {
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    _tooltips = json['tooltips'] != null ? Tooltips.fromJson(json['tooltips']) : null;
  }

  List<Images>? _images;
  Tooltips? _tooltips;

  BingDailyImageBean copyWith({
    List<Images>? images,
    Tooltips? tooltips,
  }) =>
      BingDailyImageBean(
        images: images ?? _images,
        tooltips: tooltips ?? _tooltips,
      );

  List<Images>? get images => _images;

  Tooltips? get tooltips => _tooltips;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    if (_tooltips != null) {
      map['tooltips'] = _tooltips?.toJson();
    }
    return map;
  }
}

/// loading : "正在加载..."
/// previous : "上一个图像"
/// next : "下一个图像"
/// walle : "此图片不能下载用作壁纸。"
/// walls : "下载今日美图。仅限用作桌面壁纸。"

Tooltips tooltipsFromJson(String str) => Tooltips.fromJson(json.decode(str));

String tooltipsToJson(Tooltips data) => json.encode(data.toJson());

class Tooltips {
  Tooltips({
    String? loading,
    String? previous,
    String? next,
    String? walle,
    String? walls,
  }) {
    _loading = loading;
    _previous = previous;
    _next = next;
    _walle = walle;
    _walls = walls;
  }

  Tooltips.fromJson(dynamic json) {
    _loading = json['loading'];
    _previous = json['previous'];
    _next = json['next'];
    _walle = json['walle'];
    _walls = json['walls'];
  }

  String? _loading;
  String? _previous;
  String? _next;
  String? _walle;
  String? _walls;

  Tooltips copyWith({
    String? loading,
    String? previous,
    String? next,
    String? walle,
    String? walls,
  }) =>
      Tooltips(
        loading: loading ?? _loading,
        previous: previous ?? _previous,
        next: next ?? _next,
        walle: walle ?? _walle,
        walls: walls ?? _walls,
      );

  String? get loading => _loading;

  String? get previous => _previous;

  String? get next => _next;

  String? get walle => _walle;

  String? get walls => _walls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['loading'] = _loading;
    map['previous'] = _previous;
    map['next'] = _next;
    map['walle'] = _walle;
    map['walls'] = _walls;
    return map;
  }
}

/// startdate : "20231221"
/// fullstartdate : "202312211600"
/// enddate : "20231222"
/// url : "/th?id=OHR.WinterSolstice2023_ZH-CN4450201916_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"
/// urlbase : "/th?id=OHR.WinterSolstice2023_ZH-CN4450201916"
/// copyright : "天鹅泉湿地公园，伊犁，新疆，中国 (© 500px Asia/Getty images)"
/// copyrightlink : "https://www.bing.com/search?q=%E6%96%B0%E7%96%86%E5%A4%A9%E9%B9%85%E6%B3%89%E6%B9%BF%E5%9C%B0%E5%85%AC%E5%9B%AD&form=hpcapt&mkt=zh-cn"
/// title : "冬季仙境中的精灵"
/// quiz : "/search?q=Bing+homepage+quiz&filters=WQOskey:%22HPQuiz_20231221_WinterSolstice2023%22&FORM=HPQUIZ"
/// wp : true
/// hsh : "7c7dfa101b23f413158948722a8768c2"
/// drk : 1
/// top : 1
/// bot : 1
/// hs : []

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));

String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    String? startdate,
    String? fullstartdate,
    String? enddate,
    String? url,
    String? urlbase,
    String? copyright,
    String? copyrightlink,
    String? title,
    String? quiz,
    bool? wp,
    String? hsh,
    num? drk,
    num? top,
    num? bot,
    List<dynamic>? hs,
  }) {
    _startdate = startdate;
    _fullstartdate = fullstartdate;
    _enddate = enddate;
    _url = url;
    _urlbase = urlbase;
    _copyright = copyright;
    _copyrightlink = copyrightlink;
    _title = title;
    _quiz = quiz;
    _wp = wp;
    _hsh = hsh;
    _drk = drk;
    _top = top;
    _bot = bot;
    _hs = hs;
  }

  Images.fromJson(dynamic json) {
    _startdate = json['startdate'];
    _fullstartdate = json['fullstartdate'];
    _enddate = json['enddate'];
    _url = json['url'];
    _urlbase = json['urlbase'];
    _copyright = json['copyright'];
    _copyrightlink = json['copyrightlink'];
    _title = json['title'];
    _quiz = json['quiz'];
    _wp = json['wp'];
    _hsh = json['hsh'];
    _drk = json['drk'];
    _top = json['top'];
    _bot = json['bot'];
    if (json['hs'] != null) {
      _hs = [];
      json['hs'].forEach((v) {
        _hs?.add(v.toString());
      });
    }
  }

  String? _startdate;
  String? _fullstartdate;
  String? _enddate;
  String? _url;
  String? _urlbase;
  String? _copyright;
  String? _copyrightlink;
  String? _title;
  String? _quiz;
  bool? _wp;
  String? _hsh;
  num? _drk;
  num? _top;
  num? _bot;
  List<dynamic>? _hs;

  Images copyWith({
    String? startdate,
    String? fullstartdate,
    String? enddate,
    String? url,
    String? urlbase,
    String? copyright,
    String? copyrightlink,
    String? title,
    String? quiz,
    bool? wp,
    String? hsh,
    num? drk,
    num? top,
    num? bot,
    List<dynamic>? hs,
  }) =>
      Images(
        startdate: startdate ?? _startdate,
        fullstartdate: fullstartdate ?? _fullstartdate,
        enddate: enddate ?? _enddate,
        url: url ?? _url,
        urlbase: urlbase ?? _urlbase,
        copyright: copyright ?? _copyright,
        copyrightlink: copyrightlink ?? _copyrightlink,
        title: title ?? _title,
        quiz: quiz ?? _quiz,
        wp: wp ?? _wp,
        hsh: hsh ?? _hsh,
        drk: drk ?? _drk,
        top: top ?? _top,
        bot: bot ?? _bot,
        hs: hs ?? _hs,
      );

  String? get startdate => _startdate;

  String? get fullstartdate => _fullstartdate;

  String? get enddate => _enddate;

  String? get url => _url;

  String? get urlbase => _urlbase;

  String? get copyright => _copyright;

  String? get copyrightlink => _copyrightlink;

  String? get title => _title;

  String? get quiz => _quiz;

  bool? get wp => _wp;

  String? get hsh => _hsh;

  num? get drk => _drk;

  num? get top => _top;

  num? get bot => _bot;

  List<dynamic>? get hs => _hs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startdate'] = _startdate;
    map['fullstartdate'] = _fullstartdate;
    map['enddate'] = _enddate;
    map['url'] = _url;
    map['urlbase'] = _urlbase;
    map['copyright'] = _copyright;
    map['copyrightlink'] = _copyrightlink;
    map['title'] = _title;
    map['quiz'] = _quiz;
    map['wp'] = _wp;
    map['hsh'] = _hsh;
    map['drk'] = _drk;
    map['top'] = _top;
    map['bot'] = _bot;
    if (_hs != null) {
      map['hs'] = _hs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
