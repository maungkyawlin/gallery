

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart'; 
import 'package:path/path.dart ' as path;


 
 class DbConn{

  static Future<Database> datadb() async{
    final dataPath=await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dataPath,'image.db'),
    onCreate: (db,version){
      return db.execute("CREATE TABLE images (id TEXT PRIMARY KEY,title, TEXT,content TEXT,image TEXT)");
    },version: 1
    );
}
 static Future<void> insert(String table,Map<String,Object>data) async{
  final db=await DbConn.datadb();
  db.insert(table, data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
 }

 static Future<List<Map<String,dynamic>>> getData(String table) async{
  final db=await DbConn.datadb();
  return db.query(table);
 }

 }
 