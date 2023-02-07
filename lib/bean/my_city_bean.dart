/// cityName : ""

class MyCityBean {
  MyCityBean({
    String? cityName,
  }) {
    _cityName = cityName;
  }

  MyCityBean.fromJson(dynamic json) {
    _cityName = json['cityName'];
  }

  String? _cityName;

  MyCityBean copyWith({
    String? cityName,
  }) =>
      MyCityBean(
        cityName: cityName ?? _cityName,
      );

  String? get cityName => _cityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cityName'] = _cityName;
    return map;
  }
}
