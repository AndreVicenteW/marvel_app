import 'package:marvel_app/app/core/services/local_database_service/local_database_service.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ComicsDao implements LocalDatabaseService<ComicDto> {

  static const _databaseName = 'marvel_app_andre_database';
  static const _tableName = 'comics_table';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _columnTitle = 'title';
  static const _columnDescription = 'description';
  static const _columnThumb = 'thumbnail';
  static const _columnRead = 'read';

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE $_tableName(
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $_columnTitle TEXT NOT NULL,
            $_columnDescription TEXT,
            $_columnThumb TEXT,
            $_columnRead INTEGER default 0
          )
        ''');
      },
      version: _databaseVersion,
    );
  }

  @override
  Future<List<ComicDto>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    return List.generate(result.length, (i) {
      return ComicDto.fromDatabase(result[i]);
    });
  }

  @override
  Future<void> insert(ComicDto object) async {
    final db = await database;
    final dto = object.toDatabase();
    await db.transaction((txn) async {
      await txn.insert(
        _tableName,
        dto,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  @override
  Future<void> delete(ComicDto object) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [object.id],
    );
  }
}