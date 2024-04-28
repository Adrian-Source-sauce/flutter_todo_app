import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolistwithsqllite/data/models/note.dart';

class LocalDatasource {
  final String dbName = 'notes_local01.db';
  final String tableName = 'notes';

  Future<Database> _openDatabase () async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT,
            content TEXT,
            date TEXT )''',
        );
      },
     
    );
    // insert note
  }

  Future<int> insert(Note note) async {
    final  db = await _openDatabase();
    return await db.insert(
      tableName,
      note.toMap(),
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await _openDatabase();
    final maps = await db.query(tableName,orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  // get note by id
  Future<Note> getNoteById(int id) async {
    final db = await _openDatabase();
    final maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return Note.fromMap(maps.first);
  }

  // update note
  Future<int> update(Note note) async {
    final Database db = await _openDatabase();
    return await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // delete note
  Future<int> delete(Note note) async {
    final db = await _openDatabase();
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
