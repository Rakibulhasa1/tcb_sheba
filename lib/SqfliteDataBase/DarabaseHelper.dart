// ignore_for_file: file_names

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import 'package:tcb/SqfliteDataBase/Model/SaveBenificaryDataModel.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if(_db !=null){
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'beneficiary.db');
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version)async{
    await db.execute('CREATE TABLE beneficiaryInfo(id INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT, ''nidNumber TEXT, isPaid boolean)');
  }

  Future<SaveBenificaryDataModel> insert(SaveBenificaryDataModel model)async{

    var dbClient = await db;
    await dbClient!.insert('beneficiaryInfo', model.toMap());
    return model;
  }

  Future<List<SaveBenificaryDataModel>> getData()async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('beneficiaryInfo');
    return queryResult.map((e)=> SaveBenificaryDataModel.fromMap(e)).toList();
  }

  Future<int> delete(int id)async{
    var dbClient = await db;
    return await dbClient!.delete(
      'beneficiaryInfo',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}






