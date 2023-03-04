import 'package:sqflite/sqflite.dart';

class DBManager{
  static Database? _db;
  static Future<Database> get instance async{
    return _db ??= await openDatabase('xd.db',version: 1,onCreate: (db,version) async{
      await db.execute('sql');
      await db.execute('sql');
    });
  }

}