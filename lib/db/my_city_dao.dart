import 'package:flutter_good_weather/bean/my_city_bean.dart';
import 'package:flutter_good_weather/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

/// 数据操作类
class MyCityDao {
  // 单例对象
  static final MyCityDao _instance = MyCityDao._internal();

  /// 私有构造
  MyCityDao._internal();

  factory MyCityDao.getInstance() => _instance;

  /// 插入，如果已经插入过了，则替换之前的。
  insert(List<MyCityBean> myCityList) async {
    final db = await DbHelper.getInstance().getDb();
    final batch = db?.batch();
    for (var data in myCityList) {
      batch?.insert(DbHelper.myCityTab, data.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return await batch?.commit(continueOnError: true);
  }

  /// 删除 全部
  deleteAll() async {
    return await DbHelper.getInstance()
        .getDb()
        ?.then((value) => value.delete(DbHelper.myCityTab));
  }

  /// 更新
  update(MyCityBean myCityBean) async {
    return await DbHelper.getInstance().getDb()?.then((value) => value.update(
        DbHelper.myCityTab, myCityBean.toJson(),
        where: "cityName = ?", whereArgs: [myCityBean.cityName]));
  }

  /// 查询 全部
  Future<List<MyCityBean>> queryAll() async {
    List<MyCityBean> list = [];
    await DbHelper.getInstance()
        .getDb()
        ?.then((db) => db.query(DbHelper.myCityTab).then((value) {
              for (var data in value) {
                list.add(MyCityBean.fromJson(data));
              }
            }));
    return list;
  }
}
