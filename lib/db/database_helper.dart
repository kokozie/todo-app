import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/todo_model.dart';

class DatabaseHelper{

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'Todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('CREATE TABLE todo_data'
        '(id INTEGER PRIMARY KEY, '
        'title TEXT, '
        'details TEXT,'
        'completed TEXT)'
    );
  }

  Future<List<TodoModel>> getTodoModel() async{
    Database db = await instance.database;
    var todos = await db.query('todo_data',orderBy: 'id');
    List<TodoModel> todoItemsList = todos.isNotEmpty ? todos.map((c) => TodoModel.fromMap((c))).toList() : [] ;
    return todoItemsList;
  }

  Future<void> add(TodoModel todo) async{
    Database db = await instance.database;
    await db.insert('todo_data', todo.toJson());
  }

  Future<void> remove(int id) async {
    final db = await database;
    await db.delete(
      'todo_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> update(TodoModel todo) async {


    Database db = await instance.database;
    var result = await db.update('todo_data', todo.toJson(),
        where: 'id = ?',
        whereArgs: [todo.id]);
    return result;
  }

}