import 'package:flutter_good_weather/bean/ProvinceBean.dart';
import 'package:flutter_good_weather/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

/// 数据操作类
class ProvinceDao {

  // 单例对象
  static final ProvinceDao _instance = ProvinceDao._internal();

  /// 私有构造
  ProvinceDao._internal();

  factory ProvinceDao.getInstance() => _instance;

  /// 插入，如果已经插入过了，则替换之前的。
  insert(List<ProvinceBean> provinceList) async {
    final db = await DbHelper.getInstance().getDb();
    final batch = db?.batch();
    for (var data in provinceList) {
      batch?.insert(DbHelper.provinceTab, data.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return await batch?.commit(continueOnError: true);
  }

  /// 删除 全部
  deleteAll() async {
    return await DbHelper.getInstance()
        .getDb()
        ?.then((value) => value.delete(DbHelper.provinceTab));
  }

  /// 更新
  update(ProvinceBean provinceBean) async {
    return await DbHelper.getInstance().getDb()?.then((value) => value.update(
        DbHelper.provinceTab, provinceBean.toJson(),
        where: "name = ?", whereArgs: [provinceBean.name]));
  }

  /// 查询 全部
  Future<List<ProvinceBean>> queryAll() async {
    List<ProvinceBean> list = [];
    await DbHelper.getInstance()
        .getDb()
        ?.then((db) => db.query(DbHelper.provinceTab).then((value) {
              for (var data in value) {
                list.add(ProvinceBean.fromJson(data));
              }
            }));
    return list;
  }
}
