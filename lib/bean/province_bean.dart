/// name : "北京市"
/// city : [{"name":"北京市","area":["东城区","西城区","朝阳区","丰台区","石景山区","海淀区","顺义区","门头沟区","房山区","通州区","昌平区","大兴区","平谷区","怀柔区","密云区","延庆区"]}]

class ProvinceBean {
  ProvinceBean({
    String? name,
    List<City>? city,
  }) {
    _name = name;
    _city = city;
  }

  ProvinceBean.fromJson(dynamic json) {
    _name = json['name'];
    if (json['city'] != null) {
      _city = [];
      json['city'].forEach((v) {
        _city?.add(City.fromJson(v));
      });
    }
  }

  String? _name;
  List<City>? _city;

  ProvinceBean copyWith({
    String? name,
    List<City>? city,
  }) =>
      ProvinceBean(
        name: name ?? _name,
        city: city ?? _city,
      );

  String? get name => _name;

  List<City>? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_city != null) {
      map['city'] = _city?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "北京市"
/// area : ["东城区","西城区","朝阳区","丰台区","石景山区","海淀区","顺义区","门头沟区","房山区","通州区","昌平区","大兴区","平谷区","怀柔区","密云区","延庆区"]

class City {
  City({
    String? name,
    List<String>? area,
  }) {
    _name = name;
    _area = area;
  }

  City.fromJson(dynamic json) {
    _name = json['name'];
    _area = json['area'] != null ? json['area'].cast<String>() : [];
  }

  String? _name;
  List<String>? _area;

  City copyWith({
    String? name,
    List<String>? area,
  }) =>
      City(
        name: name ?? _name,
        area: area ?? _area,
      );

  String? get name => _name;

  List<String>? get area => _area;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['area'] = _area;
    return map;
  }
}
