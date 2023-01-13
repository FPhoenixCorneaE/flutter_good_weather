import 'package:flutter_good_weather/bean/ProvinceBean.dart';
import 'package:flutter_good_weather/db/db_helper.dart';

class ProvinceDao {
  /// 删除 全部
  static deleteAll() {
    DbHelper.getInstance()
        .getDb()
        ?.then((value) => value.delete(DbHelper.provinceTab));
  }

  /// 查询 全部
  static queryAll() async {
    List<ProvinceBean> list = [];
    await DbHelper.getInstance()
        .getDb()
        ?.then((db) => db.query(DbHelper.provinceTab).then((value) => {
              for (var data in value) {list.add(ProvinceBean.fromJson(data))}
            }));
    return list;
  }
}
