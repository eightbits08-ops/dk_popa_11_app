import 'models.dart';
import 'app_constants.dart';

class BallScoringService {
  static Map<String, dynamic> processScore(int score) {
    int runs = 0;
    int extras = 0;
    String ballType = 'normal';

    switch (score) {
      case 0:
        runs = 0;
        ballType = 'normal';
        break;
      case 1:
        runs = 1;
        ballType = 'normal';
        break;
      case 2:
        runs = 2;
        ballType = 'normal';
        break;
      case 3:
        runs = 3;
        ballType = 'normal';
        break;
      case 4:
        runs = 4;
        ballType = 'normal';
        break;
      case 6:
        runs = 6;
        ballType = 'normal';
        break;
      case 100:
        runs = 1;
        extras = 1;
        ballType = 'wide';
        break;
      case 101:
        runs = 1;
        extras = 1;
        ballType = 'noBall';
        break;
      case 102:
        runs = 1;
        extras = 1;
        ballType = 'bye';
        break;
      case 103:
        runs = 1;
        extras = 1;
        ballType = 'legBye';
        break;
    }

    return {
      'runs': runs,
      'ballType': ballType,
      'extras': extras,
    };
  }

  static Map<String, dynamic> calculateInningsStats(List<Ball> balls) {
    int totalRuns = 0;
    int totalWickets = 0;
    int validBalls = 0;

    for (final ball in balls) {
      totalRuns += ball.runs;
      if (ball.isWicket) {
        totalWickets++;
      }
      if (ball.ballType != 'wide' && ball.ballType != 'noBall') {
        validBalls++;
      }
    }

    return {
      'totalRuns': totalRuns,
      'totalWickets': totalWickets,
      'validBalls': validBalls,
      'totalBalls': balls.length,
    };
  }

  static Map<String, dynamic> calculateRunsBreakdown(List<Ball> balls) {
    int batsmanRuns = 0;
    int extraRuns = 0;
    Map<String, int> bowlerRuns = {};
    List<String> dismissals = [];

    for (final ball in balls) {
      if (ball.ballType == 'wide' ||
          ball.ballType == 'noBall' ||
          ball.ballType == 'bye' ||
          ball.ballType == 'legBye') {
        extraRuns += ball.runs;
      } else {
        batsmanRuns += ball.runs;
      }

      if (!bowlerRuns.containsKey(ball.bowlerPlayerId)) {
        bowlerRuns[ball.bowlerPlayerId] = 0;
      }
      bowlerRuns[ball.bowlerPlayerId] = bowlerRuns[ball.bowlerPlayerId]! + ball.runs;

      if (ball.isWicket) {
        dismissals.add(ball.id);
      }
    }

    return {
      'batsmanRuns': batsmanRuns,
      'extraRuns': extraRuns,
      'bowlerRuns': bowlerRuns,
      'dismissals': dismissals,
    };
  }
}

class OverCalculationService {
  static Map<String, int> getOverAndBall(int totalBalls) {
    int overNumber = totalBalls ~/ CricketConstants.ballsPerOver;
    int ballInOver = totalBalls % CricketConstants.ballsPerOver;

    return {
      'over': overNumber,
      'ball': ballInOver,
    };
  }

  static bool isOverComplete(int ballsInOver) {
    return ballsInOver % CricketConstants.ballsPerOver == 0;
  }

  static String getFormattedOvers(int totalBalls) {
    int overs = totalBalls ~/ CricketConstants.ballsPerOver;
    int balls = totalBalls % CricketConstants.ballsPerOver;
    return '$overs.$balls';
  }

  static bool isMatchOverComplete(int totalBalls, int maxOvers) {
    int oversCompleted = totalBalls ~/ CricketConstants.ballsPerOver;
    return oversCompleted >= maxOvers;
  }

  static Map<String, String> rotateStrike(
    String currentStriker,
    String currentNonStriker,
    int ballsInOver,
  ) {
    bool oddRuns = ballsInOver % 2 == 1;

    if (oddRuns) {
      return {
        'striker': currentNonStriker,
        'nonStriker': currentStriker,
      };
    }

    return {
      'striker': currentStriker,
      'nonStriker': currentNonStriker,
    };
  }

  static int getOversRemaining(int totalBalls, int maxOvers) {
    int oversCompleted = totalBalls ~/ CricketConstants.ballsPerOver;
    return maxOvers - oversCompleted;
  }

  static int getBallsRemainingInOver(int totalBalls) {
    int ballsInOver = totalBalls % CricketConstants.ballsPerOver;
    return CricketConstants.ballsPerOver - ballsInOver;
  }
}

class StatsCalculationService {
  static Map<String, dynamic> calculateBatsmanStats(
    List<Ball> balls,
    String playerId,
  ) {
    int runs = 0;
    int ballsFaced = 0;
    int fours = 0;
    int sixes = 0;
    int dotBalls = 0;

    for (final ball in balls) {
      if (ball.strikerPlayerId == playerId) {
        runs += ball.runs;
        if (ball.ballType == 'normal') {
          ballsFaced++;
          if (ball.runs == 0) dotBalls++;
          if (ball.runs == 4) fours++;
          if (ball.runs == 6) sixes++;
        }
      }
    }

    double strikeRate = ballsFaced > 0 ? (runs / ballsFaced) * 100 : 0;

    return {
      'playerId': playerId,
      'runs': runs,
      'ballsFaced': ballsFaced,
      'fours': fours,
      'sixes': sixes,
      'dotBalls': dotBalls,
      'strikeRate': strikeRate,
    };
  }

  static Map<String, dynamic> calculateBowlerStats(
    List<Ball> balls,
    String playerId,
  ) {
    int runs = 0;
    int ballsBowled = 0;
    int wickets = 0;
    int maidens = 0;
    int extras = 0;

    Map<int, List<Ball>> ballsByOver = {};
    for (final ball in balls) {
      if (ball.bowlerPlayerId == playerId) {
        ballsByOver.putIfAbsent(ball.overNumber, () => []);
        ballsByOver[ball.overNumber]!.add(ball);
      }
    }

    for (final over in ballsByOver.values) {
      int overRuns = 0;
      for (final ball in over) {
        runs += ball.runs;
        if (ball.ballType == 'normal') {
          ballsBowled++;
        } else {
          extras += ball.runs;
        }
        if (ball.isWicket) wickets++;
        overRuns += ball.runs;
      }
      if (overRuns == 0 && over.every((b) => b.ballType == 'normal')) {
        maidens++;
      }
    }

    double economy = ballsBowled > 0 ? (runs / (ballsBowled / 6)) : 0;

    return {
      'playerId': playerId,
      'runs': runs,
      'ballsBowled': ballsBowled,
      'wickets': wickets,
      'maidens': maidens,
      'extras': extras,
      'economy': economy,
    };
  }

  static List<String> getUniqueBatsmen(List<Ball> balls) {
    Set<String> batsmen = {};
    for (final ball in balls) {
      batsmen.add(ball.strikerPlayerId);
    }
    return batsmen.toList();
  }

  static List<String> getUniqueBowlers(List<Ball> balls) {
    Set<String> bowlers = {};
    for (final ball in balls) {
      bowlers.add(ball.bowlerPlayerId);
    }
    return bowlers.toList();
  }
}

class WicketHandlingService {
  static Dismissal createDismissal({
    required String ballId,
    required String batsmanId,
    required String dismissalType,
    String? bowlerId,
    String? fielderId,
  }) {
    return Dismissal(
      ballId: ballId,
      batsmanPlayerId: batsmanId,
      dismissalType: dismissalType,
      bowlerPlayerId: bowlerId,
      fielderId: fielderId,
    );
  }

  static String getDismissalDescription(Dismissal dismissal) {
    switch (dismissal.dismissalType) {
      case 'bowled':
        return 'b ${dismissal.bowlerPlayerId}';
      case 'caught':
        return 'c ${dismissal.fielderId} b ${dismissal.bowlerPlayerId}';
      case 'lbw':
        return 'lbw b ${dismissal.bowlerPlayerId}';
      case 'runout':
        return 'run out';
      case 'hitWicket':
        return 'hit wicket';
      case 'handled':
        return 'handled the ball';
      case 'obstruction':
        return 'obstructing the field';
      case 'timedOut':
        return 'timed out';
      default:
        return 'dismissed';
    }
  }

  static String? getNextBatsman(List<String> battingOrder, int currentIndex) {
    if (currentIndex + 1 < battingOrder.length) {
      return battingOrder[currentIndex + 1];
    }
    return null;
  }
}