import 'package:sqflite/sqflite.dart';
import 'package:exam_6/data/models/income_model.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class IncomeLocalService {
  final String _tableName = "income_table";
  final String _dbName = "income_database.db";

  IncomeLocalService._();

  static final _singleton = IncomeLocalService._();

  factory IncomeLocalService() => _singleton;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        amount REAL,
        date INTEGER,
        incomingCategory TEXT
      )
    """);
  }

  Future<int> insertIncome(IncomeModel income) async {
    final db = await database;
    return await db.insert(_tableName, income.toMap());
  }

  Future<List<IncomeModel>> getAllIncomes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) => IncomeModel.fromMap(maps[i]));
  }

  Future<int> updateIncome(IncomeModel income) async {
    final db = await database;
    return await db.update(
      _tableName,
      income.toMap(),
      where: 'id = ?',
      whereArgs: [income.id],
    );
  }

  Future<int> deleteIncome(String id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
