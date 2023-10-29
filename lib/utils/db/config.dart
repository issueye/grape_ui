import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ConfigDB {
  static late Database _db;
  static late StoreRef _configStore;
  
  static Future<void> initDb() async {
    String dbPath = 'config.db';
    DatabaseFactory dbFactory = databaseFactoryIo;
    _db = await dbFactory.openDatabase(dbPath);
    _configStore = StoreRef<String, String>.main();
  }

  // set 
  static Future<void> setStr(String key, value) async {
    await _configStore.record(key).put(_db, value);
  }

  // get
  static Future<String> getStr(String key) async {
    var data = await _configStore.record(key).get(_db);
    return data.toString();
  }

  // delete
  static Future<void> delete(String key) async {
    await _configStore.record(key).delete(_db);
  }
}