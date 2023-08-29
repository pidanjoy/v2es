import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:v2es/model/topic_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'v2es_sqlite.db');

    return await openDatabase(dbPath, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE topics (
        id INTEGER PRIMARY KEY,
        title TEXT,
        href TEXT,
        authorName TEXT,
        authorHref TEXT,
        avatar TEXT,
        nodeTitle TEXT,
        nodeHref TEXT,
        replyQty INTEGER,
        rankUp INTEGER,
        lastReplyTime TEXT,
        lastReplyName TEXT,
        lastReplyHref TEXT
      )
    ''');
  }

  Future<void> insertTopic(TopicHead topic) async {
    final db = await instance.database;
    await db.insert('topics', topic.toMap());
  }
}
