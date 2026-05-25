import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Match {
  final String id;
  final String teamName;
  final String opponent;
  final int overs;
  final String date;
  final String venue;
  final String? tossWinner;
  final String? battingFirst;
  final String status; // ongoing, completed
  final int? finalScore;
  final int? wicketsLost;
  final DateTime createdAt;
  final DateTime updatedAt;

  Match({
    String? id,
    required this.teamName,
    required this.opponent,
    required this.overs,
    required this.date,
    required this.venue,
    this.tossWinner,
    this.battingFirst,
    this.status = 'ongoing',
    this.finalScore,
    this.wicketsLost,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teamName': teamName,
      'opponent': opponent,
      'overs': overs,
      'date': date,
      'venue': venue,
      'tossWinner': tossWinner,
      'battingFirst': battingFirst,
      'status': status,
      'finalScore': finalScore,
      'wicketsLost': wicketsLost,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'],
      teamName: map['teamName'],
      opponent: map['opponent'],
      overs: map['overs'],
      date: map['date'],
      venue: map['venue'],
      tossWinner: map['tossWinner'],
      battingFirst: map['battingFirst'],
      status: map['status'] ?? 'ongoing',
      finalScore: map['finalScore'],
      wicketsLost: map['wicketsLost'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Match copyWith({
    String? id,
    String? teamName,
    String? opponent,
    int? overs,
    String? date,
    String? venue,
    String? tossWinner,
    String? battingFirst,
    String? status,
    int? finalScore,
    int? wicketsLost,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Match(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      opponent: opponent ?? this.opponent,
      overs: overs ?? this.overs,
      date: date ?? this.date,
      venue: venue ?? this.venue,
      tossWinner: tossWinner ?? this.tossWinner,
      battingFirst: battingFirst ?? this.battingFirst,
      status: status ?? this.status,
      finalScore: finalScore ?? this.finalScore,
      wicketsLost: wicketsLost ?? this.wicketsLost,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() => 'Match(id: $id, opponent: $opponent, overs: $overs)';
}

class Player {
  final String id;
  final String name;
  final String role; // batsman, bowler, allrounder
  final DateTime createdAt;

  Player({
    String? id,
    required this.name,
    this.role = 'batsman',
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'],
      name: map['name'],
      role: map['role'] ?? 'batsman',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Player copyWith({
    String? id,
    String? name,
    String? role,
    DateTime? createdAt,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'Player(id: $id, name: $name, role: $role)';
}

class Innings {
  final String id;
  final String matchId;
  final int inningsNumber;
  final String battingTeam;
  final int totalRuns;
  final int totalWickets;
  final int totalBalls;
  final DateTime createdAt;

  Innings({
    String? id,
    required this.matchId,
    required this.inningsNumber,
    required this.battingTeam,
    this.totalRuns = 0,
    this.totalWickets = 0,
    this.totalBalls = 0,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matchId': matchId,
      'inningsNumber': inningsNumber,
      'battingTeam': battingTeam,
      'totalRuns': totalRuns,
      'totalWickets': totalWickets,
      'totalBalls': totalBalls,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Innings.fromMap(Map<String, dynamic> map) {
    return Innings(
      id: map['id'],
      matchId: map['matchId'],
      inningsNumber: map['inningsNumber'],
      battingTeam: map['battingTeam'],
      totalRuns: map['totalRuns'] ?? 0,
      totalWickets: map['totalWickets'] ?? 0,
      totalBalls: map['totalBalls'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Innings copyWith({
    String? id,
    String? matchId,
    int? inningsNumber,
    String? battingTeam,
    int? totalRuns,
    int? totalWickets,
    int? totalBalls,
    DateTime? createdAt,
  }) {
    return Innings(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      inningsNumber: inningsNumber ?? this.inningsNumber,
      battingTeam: battingTeam ?? this.battingTeam,
      totalRuns: totalRuns ?? this.totalRuns,
      totalWickets: totalWickets ?? this.totalWickets,
      totalBalls: totalBalls ?? this.totalBalls,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get oversCompleted => '${(totalBalls ~/ 6)}.${totalBalls % 6}';

  @override
  String toString() => 'Innings(id: $id, team: $battingTeam, runs: $totalRuns/$totalWickets)';
}

class Ball {
  final String id;
  final String inningsId;
  final int overNumber;
  final int ballNumber;
  final String strikerPlayerId;
  final String bowlerPlayerId;
  final int runs;
  final String ballType; // normal, wide, noBall
  final bool isWicket;
  final DateTime createdAt;

  Ball({
    String? id,
    required this.inningsId,
    required this.overNumber,
    required this.ballNumber,
    required this.strikerPlayerId,
    required this.bowlerPlayerId,
    this.runs = 0,
    this.ballType = 'normal',
    this.isWicket = false,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inningsId': inningsId,
      'overNumber': overNumber,
      'ballNumber': ballNumber,
      'strikerPlayerId': strikerPlayerId,
      'bowlerPlayerId': bowlerPlayerId,
      'runs': runs,
      'ballType': ballType,
      'isWicket': isWicket ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Ball.fromMap(Map<String, dynamic> map) {
    return Ball(
      id: map['id'],
      inningsId: map['inningsId'],
      overNumber: map['overNumber'],
      ballNumber: map['ballNumber'],
      strikerPlayerId: map['strikerPlayerId'],
      bowlerPlayerId: map['bowlerPlayerId'],
      runs: map['runs'] ?? 0,
      ballType: map['ballType'] ?? 'normal',
      isWicket: map['isWicket'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Ball copyWith({
    String? id,
    String? inningsId,
    int? overNumber,
    int? ballNumber,
    String? strikerPlayerId,
    String? bowlerPlayerId,
    int? runs,
    String? ballType,
    bool? isWicket,
    DateTime? createdAt,
  }) {
    return Ball(
      id: id ?? this.id,
      inningsId: inningsId ?? this.inningsId,
      overNumber: overNumber ?? this.overNumber,
      ballNumber: ballNumber ?? this.ballNumber,
      strikerPlayerId: strikerPlayerId ?? this.strikerPlayerId,
      bowlerPlayerId: bowlerPlayerId ?? this.bowlerPlayerId,
      runs: runs ?? this.runs,
      ballType: ballType ?? this.ballType,
      isWicket: isWicket ?? this.isWicket,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'Ball(over: $overNumber, ball: $ballNumber, runs: $runs)';
}

class Dismissal {
  final String id;
  final String ballId;
  final String batsmanPlayerId;
  final String dismissalType; // bowled, caught, lbw, runout, etc.
  final String? bowlerPlayerId;
  final String? fielderId;
  final DateTime createdAt;

  Dismissal({
    String? id,
    required this.ballId,
    required this.batsmanPlayerId,
    required this.dismissalType,
    this.bowlerPlayerId,
    this.fielderId,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ballId': ballId,
      'batsmanPlayerId': batsmanPlayerId,
      'dismissalType': dismissalType,
      'bowlerPlayerId': bowlerPlayerId,
      'fielderId': fielderId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Dismissal.fromMap(Map<String, dynamic> map) {
    return Dismissal(
      id: map['id'],
      ballId: map['ballId'],
      batsmanPlayerId: map['batsmanPlayerId'],
      dismissalType: map['dismissalType'],
      bowlerPlayerId: map['bowlerPlayerId'],
      fielderId: map['fielderId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Dismissal copyWith({
    String? id,
    String? ballId,
    String? batsmanPlayerId,
    String? dismissalType,
    String? bowlerPlayerId,
    String? fielderId,
    DateTime? createdAt,
  }) {
    return Dismissal(
      id: id ?? this.id,
      ballId: ballId ?? this.ballId,
      batsmanPlayerId: batsmanPlayerId ?? this.batsmanPlayerId,
      dismissalType: dismissalType ?? this.dismissalType,
      bowlerPlayerId: bowlerPlayerId ?? this.bowlerPlayerId,
      fielderId: fielderId ?? this.fielderId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'Dismissal(batsman: $batsmanPlayerId, type: $dismissalType)';
}