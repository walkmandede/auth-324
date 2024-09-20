import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../_common/constants/app_functions.dart';
import 'm_logger_model.dart';

class LoggerController extends GetxController {
  Database? database;
  static const String loggerDbName = "Logger";

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  @override
  void onClose() {
    if (database != null) {
      database!.close();
    }
    super.onClose();
  }

  Future<void> initLoad() async {
    await initDatabase();
  }

  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/myDb.db';
    // deleteDatabase(path);
    database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              '''CREATE TABLE $loggerDbName (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              dateTime TEXT,
              enumLoggerType TEXT,
              title TEXT,
              content TEXT,
              currentPage TEXT
              )'''
          );
          superPrint("done");
        });

  }

  Future<void> insertNewLog({required LoggerModel log}) async {
    if(database!=null){
      await database!.insert(
        loggerDbName,
        log.toMap(),
      );
    }
  }

  ///pageStartedFrom1
  Future<List<LoggerModel>> fetchData({required int pageCount,required int pageSize,required Function(int) getTotalItem}) async{
    final r1 = await database!.rawQuery("SELECT COUNT(*) FROM $loggerDbName");
    final total = int.tryParse( r1.first["COUNT(*)"].toString())??0;
    getTotalItem(total);
    int si = (pageCount-1)*pageSize;
    int startIndex = total - (si+pageSize);
    if(startIndex>-pageSize && startIndex<0){
      startIndex = startIndex+pageSize;
      final result = await database!.rawQuery("SELECT * FROM $loggerDbName WHERE id <= $startIndex LIMIT $pageSize");
      return result.map((e) => LoggerModel.fromMap(data: e),).toList();
    }
    else{
      if(startIndex<0){
        return [];
      }
      else{
        final result = await database!.rawQuery("SELECT * FROM $loggerDbName WHERE id > $startIndex LIMIT $pageSize");
        return result.map((e) => LoggerModel.fromMap(data: e),).toList();
      }
    }

  }

}
