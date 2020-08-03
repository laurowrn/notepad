import 'package:notepad/src/model/NoteModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConstants{
  static final String databaseName = "notepad_database.db";
  static final String notesTable = "notesTable";
}

class DatabaseRepository{
  static final DatabaseRepository _databaseRepository = DatabaseRepository._internal();
  Database _database;

  DatabaseRepository._internal();

  factory DatabaseRepository(){
    return _databaseRepository;
  }

  get database async{
    if(_database != null){
      return _database;
    }
    else{
      _database = await initializeDatabase();
      return _database;
    }
  }

  initializeDatabase()async{
    final databasePath = await getDatabasesPath();
    final databaseLocal = join(databasePath, DatabaseConstants.databaseName);

    Database database = await openDatabase(databaseLocal, version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database database, int version)async{
    String sql = "CREATE TABLE ${DatabaseConstants.notesTable}"
        "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title VARCHAR,"
        "body TEXT)";
    await database.execute(sql);
  }

  Future<int> saveNote(NoteModel note)async{
    Database tempDatabase = await database;

    int result = await tempDatabase.insert(DatabaseConstants.notesTable, note.toMap());
    return result;
  }

  Future<List>recoverNotes()async{
    Database tempDatabase = await database;
    String sql = "SELECT * FROM ${DatabaseConstants.notesTable} ORDER BY id ASC";
    List<Map<String, dynamic>> notes = await tempDatabase.rawQuery(sql);

    List<NoteModel> tempNotes = notes.map(
            (map){
              return NoteModel.fromMap(map);
            }
    ).toList();

    return tempNotes;

  }

  Future<int>removeNote(int id)async{
    Database tempDatabase = await database;
    return await tempDatabase.delete(
      DatabaseConstants.notesTable,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<int> updateNote(NoteModel note)async{
    Database tempDatabase = await database;
    return await tempDatabase.update(
        DatabaseConstants.notesTable,
        note.toMap(),
        where: "id = ?",
        whereArgs: [note.id]
    );
  }

  Future<NoteModel> getNote(int id)async{
    Database tempDatabase = await database;
    List<Map> notes = await tempDatabase.query(
      DatabaseConstants.notesTable,
      where: "id = ?",
      whereArgs: [id]
    );

    List<NoteModel> tempNotes = notes.map(
            (map){
          return NoteModel.fromMap(map);
        }
    ).toList();

    NoteModel nota = NoteModel(
        title: tempNotes[0].title,
        body: tempNotes[0].body,
        id: tempNotes[0].id,
    );
    return nota;
  }


}