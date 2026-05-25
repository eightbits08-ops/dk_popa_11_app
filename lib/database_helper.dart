import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const String dbName = 'dk_popa_11.db';
  static const int dbVersion = 1;

  static const String tblMatches = 'matches';
  static const String tblPlayers = 'players';
  static const String tblInnings = 'innings';
  static const String tblBalls = 'balls';
  static const String tblDismissals = 'dismissals';

  late Database _db;

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db.isOpen) {
      return _db;
    }
    _db = await _initDatabase();
    return _db;
  }

  Future<Database> _initDatabase() async {
    final docDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docDir.path, dbName);
    return openDatabase(
      dbPath,
      version: dbVersion,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Matches table
    await db.execute('''
      CREATE TABLE $tblMatches (
        id TEXT PRIMARY KEY,
        teamName TEXT NOT NULL,
        opponent TEXT NOT NULL,
        overs INTEGER NOT NULL,
        date TEXT NOT NULL,
        venue TEXT NOT NULL,
        tossWinner TEXT,
        battingFirst TEXT,
        status TEXT DEFAULT 'ongoing',
        finalScore INTEGER,
        wicketsLost INTEGER,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // Players table
    await db.execute('''
      CREATE TABLE $tblPlayers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        role TEXT DEFAULT 'batsman',
        createdAt TEXT NOT NULL,
        UNIQUE(name)
      )
    ''');

    // Innings table
    await db.execute('''
      CREATE TABLE $tblInnings (
        id TEXT PRIMARY KEY,
        matchId TEXT NOT NULL,
        inningsNumber INTEGER NOT NULL,
        battingTeam TEXT NOT NULL,
        totalRuns INTEGER DEFAULT 0,
        totalWickets INTEGER DEFAULT 0,
        totalBalls INTEGER DEFAULT 0,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (matchId) REFERENCES $tblMatches(id)
      )
    ''');

    // Balls table
    await db.execute('''
      CREATE TABLE $tblBalls (
        id TEXT PRIMARY KEY,
        inningsId TEXT NOT NULL,
        overNumber INTEGER NOT NULL,
        ballNumber INTEGER NOT NULL,
        strikerPlayerId TEXT NOT NULL,
        bowlerPlayerId TEXT NOT NULL,
        runs INTEGER DEFAULT 0,
        ballType TEXT DEFAULT 'normal',
        isWicket INTEGER DEFAULT 0,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (inningsId) REFERENCES $tblInnings(id),
        FOREIGN KEY (strikerPlayerId) REFERENCES $tblPlayers(id),
        FOREIGN KEY (bowlerPlayerId) REFERENCES $tblPlayers(id)
      )
    ''');

    // Dismissals table
    await db.execute('''
      CREATE TABLE $tblDismissals (
        id TEXT PRIMARY KEY,
        ballId TEXT NOT NULL,
        batsmanPlayerId TEXT NOT NULL,
        dismissalType TEXT NOT NULL,
        bowlerPlayerId TEXT,
        fielderId TEXT,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (ballId) REFERENCES $tblBalls(id),
        FOREIGN KEY (batsmanPlayerId) REFERENCES $tblPlayers(id),
        FOREIGN KEY (bowlerPlayerId) REFERENCES $tblPlayers(id),
        FOREIGN KEY (fielderId) REFERENCES $tblPlayers(id)
      )
    ''');
  }

  Future<void> _upgradeTables(Database db, int oldVersion, int newVersion) async {
    // Add migration logic here if needed in future versions
  }

  // Helper methods for common operations

  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool distinct = false,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final database = await db;
    return database.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final database = await db;
    return database.insert(table, values);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final database = await db;
    return database.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final database = await db;
    return database.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<void> closeDb() async {
    await _db.close();
  }
}