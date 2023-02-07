import 'package:sqflite/sqflite.dart';

/// 数据库帮助类
class DbHelper {
  // 数据库名称 一般不变
  final String _dbName = "good_weather.db";

  // 数据库中的表名字 这里是我存历史搜索记录的表
  static const provinceTab = "Province";

  // 我的城市表
  static const myCityTab = "MyCity";

  // 单例对象
  static final DbHelper _instance = DbHelper._internal();

  /// 数据库默认存储的路径
  /// SQLite 数据库是文件系统中由路径标识的文件。如果是relative，
  /// 这个路径是相对于 获取的路径getDatabasesPath()，
  /// Android默认的数据库目录，
  /// iOS/MacOS的documents目录。
  Future<Database>? _db;

  /// 私有构造
  DbHelper._internal();

  factory DbHelper.getInstance() => _instance;

  Future<Database>? getDb() {
    _db ??= _initDb();
    return _db;
  }

  // Guaranteed to be called only once.保证只调用一次
  Future<Database> _initDb() async {
    // 这里是我们真正创建数据库的地方 version代表数据库的版本，如果版本改变
    //，则db会调用onUpgrade方法进行更新操作
    final db =
        await openDatabase(_dbName, version: 1, onCreate: (db, version) async {
      // 数据库创建完成
      // 创建表 一个自增id 一个text
      await db.execute(
        "CREATE TABLE $provinceTab (id INTEGER PRIMARY KEY autoincrement, name TEXT not null, city TEXT)",
      );
      await db.execute(
        "CREATE TABLE $myCityTab (cityName TEXT PRIMARY KEY not null)",
      );
    }, onUpgrade: (db, oldV, newV) {
      // 升级数据库调用
      // db 数据库
      // oldV 旧版本号
      // newV 新版本号
      // 升级完成就不会在调用这个方法了
    });
    return db;
  }

  /// 关闭数据库
  close() async {
    await _db?.then((value) => value.close());
  }
}
