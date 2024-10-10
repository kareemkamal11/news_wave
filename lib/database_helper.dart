import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      log('Database already exists');
      return _database!;
    }
    _database = await _initDatabase();
    log('Database created');
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE, 
        name TEXT,
        username TEXT UNIQUE, 
        phone TEXT,
        imagePath TEXT
      )
    ''');
  }

  // اريد دالة تقوم بعمل فحص عن الايميل هل موجود في قاعدة البيانات ام غير موجود

  emailFound(String email) async {
    final db = await database;
    var existingUser = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingUser.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.update(
      'users',
      user,
      where: 'email = ?',
      whereArgs: [user['email']],
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<void> deleteUser(String email) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<void> deleteDatabase() async {
    final db = await database;
    await db.delete('users');
  }
}
