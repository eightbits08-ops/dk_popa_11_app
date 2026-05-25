import 'database_helper.dart';
import 'models.dart';

class PlayerRepository {
  final DatabaseHelper _db;

  PlayerRepository(this._db);

  Future<String> addPlayer(Player player) async {
    await _db.insert(DatabaseHelper.tblPlayers, player.toMap());
    return player.id;
  }

  Future<Player?> getPlayer(String id) async {
    final result = await _db.query(
      DatabaseHelper.tblPlayers,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Player.fromMap(result.first);
  }

  Future<List<Player>> getAllPlayers() async {
    final result = await _db.query(
      DatabaseHelper.tblPlayers,
      orderBy: 'name ASC',
    );
    return result.map((map) => Player.fromMap(map)).toList();
  }

  Future<int> updatePlayer(Player player) async {
    return _db.update(
      DatabaseHelper.tblPlayers,
      player.toMap(),
      where: 'id = ?',
      whereArgs: [player.id],
    );
  }

  Future<int> deletePlayer(String id) async {
    return _db.delete(
      DatabaseHelper.tblPlayers,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getPlayerCount() async {
    final result = await _db.query(DatabaseHelper.tblPlayers);
    return result.length;
  }
}

class MatchRepository {
  final DatabaseHelper _db;

  MatchRepository(this._db);

  Future<String> addMatch(Match match) async {
    await _db.insert(DatabaseHelper.tblMatches, match.toMap());
    return match.id;
  }

  Future<Match?> getMatch(String id) async {
    final result = await _db.query(
      DatabaseHelper.tblMatches,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Match.fromMap(result.first);
  }

  Future<List<Match>> getAllMatches() async {
    final result = await _db.query(
      DatabaseHelper.tblMatches,
      orderBy: 'createdAt DESC',
    );
    return result.map((map) => Match.fromMap(map)).toList();
  }

  Future<List<Match>> getCompletedMatches() async {
    final result = await _db.query(
      DatabaseHelper.tblMatches,
      where: 'status = ?',
      whereArgs: ['completed'],
      orderBy: 'createdAt DESC',
    );
    return result.map((map) => Match.fromMap(map)).toList();
  }

  Future<Match?> getOngoingMatch() async {
    final result = await _db.query(
      DatabaseHelper.tblMatches,
      where: 'status = ?',
      whereArgs: ['ongoing'],
    );
    if (result.isEmpty) return null;
    return Match.fromMap(result.first);
  }

  Future<int> updateMatch(Match match) async {
    return _db.update(
      DatabaseHelper.tblMatches,
      match.toMap(),
      where: 'id = ?',
      whereArgs: [match.id],
    );
  }

  Future<int> deleteMatch(String id) async {
    return _db.delete(
      DatabaseHelper.tblMatches,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getMatchCount() async {
    final result = await _db.query(DatabaseHelper.tblMatches);
    return result.length;
  }
}

class InningsRepository {
  final DatabaseHelper _db;

  InningsRepository(this._db);

  Future<String> addInnings(Innings innings) async {
    await _db.insert(DatabaseHelper.tblInnings, innings.toMap());
    return innings.id;
  }

  Future<Innings?> getInnings(String id) async {
    final result = await _db.query(
      DatabaseHelper.tblInnings,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Innings.fromMap(result.first);
  }

  Future<List<Innings>> getInningsByMatch(String matchId) async {
    final result = await _db.query(
      DatabaseHelper.tblInnings,
      where: 'matchId = ?',
      whereArgs: [matchId],
      orderBy: 'inningsNumber ASC',
    );
    return result.map((map) => Innings.fromMap(map)).toList();
  }

  Future<int> updateInnings(Innings innings) async {
    return _db.update(
      DatabaseHelper.tblInnings,
      innings.toMap(),
      where: 'id = ?',
      whereArgs: [innings.id],
    );
  }

  Future<int> deleteInnings(String id) async {
    return _db.delete(
      DatabaseHelper.tblInnings,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class BallRepository {
  final DatabaseHelper _db;

  BallRepository(this._db);

  Future<String> addBall(Ball ball) async {
    await _db.insert(DatabaseHelper.tblBalls, ball.toMap());
    return ball.id;
  }

  Future<Ball?> getBall(String id) async {
    final result = await _db.query(
      DatabaseHelper.tblBalls,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Ball.fromMap(result.first);
  }

  Future<List<Ball>> getBallsByInnings(String inningsId) async {
    final result = await _db.query(
      DatabaseHelper.tblBalls,
      where: 'inningsId = ?',
      whereArgs: [inningsId],
      orderBy: 'overNumber ASC, ballNumber ASC',
    );
    return result.map((map) => Ball.fromMap(map)).toList();
  }

  Future<List<Ball>> getBallsByOver(String inningsId, int overNumber) async {
    final result = await _db.query(
      DatabaseHelper.tblBalls,
      where: 'inningsId = ? AND overNumber = ?',
      whereArgs: [inningsId, overNumber],
      orderBy: 'ballNumber ASC',
    );
    return result.map((map) => Ball.fromMap(map)).toList();
  }

  Future<int> updateBall(Ball ball) async {
    return _db.update(
      DatabaseHelper.tblBalls,
      ball.toMap(),
      where: 'id = ?',
      whereArgs: [ball.id],
    );
  }

  Future<int> deleteBall(String id) async {
    return _db.delete(
      DatabaseHelper.tblBalls,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getBallCount(String inningsId) async {
    final result = await _db.query(
      DatabaseHelper.tblBalls,
      where: 'inningsId = ?',
      whereArgs: [inningsId],
    );
    return result.length;
  }
}

class DismissalRepository {
  final DatabaseHelper _db;

  DismissalRepository(this._db);

  Future<String> addDismissal(Dismissal dismissal) async {
    await _db.insert(DatabaseHelper.tblDismissals, dismissal.toMap());
    return dismissal.id;
  }

  Future<Dismissal?> getDismissal(String id) async {
    final result = await _db.query(
      DatabaseHelper.tblDismissals,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Dismissal.fromMap(result.first);
  }

  Future<Dismissal?> getDismissalByBall(String ballId) async {
    final result = await _db.query(
      DatabaseHelper.tblDismissals,
      where: 'ballId = ?',
      whereArgs: [ballId],
    );
    if (result.isEmpty) return null;
    return Dismissal.fromMap(result.first);
  }

  Future<int> updateDismissal(Dismissal dismissal) async {
    return _db.update(
      DatabaseHelper.tblDismissals,
      dismissal.toMap(),
      where: 'id = ?',
      whereArgs: [dismissal.id],
    );
  }

  Future<int> deleteDismissal(String id) async {
    return _db.delete(
      DatabaseHelper.tblDismissals,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}