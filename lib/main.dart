import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'app_constants.dart';
import 'database_helper.dart';
import 'repositories.dart';
import 'providers.dart';
import 'home_screen.dart';
import 'create_match_screen.dart';
import 'player_selection_screen.dart';
import 'toss_screen.dart';
import 'live_scoring_screen.dart';
import 'scorecard_screen.dart';
import 'match_history_screen.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DkPopa11App());
}

class DkPopa11App extends StatefulWidget {
  const DkPopa11App({Key? key}) : super(key: key);

  @override
  State<DkPopa11App> createState() => _DkPopa11AppState();
}

class _DkPopa11AppState extends State<DkPopa11App> {
  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = _initializeApp();
  }

  Future<void> _initializeApp() async {
    final db = DatabaseHelper();
    await db.db;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.accentPrimary,
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: AppColors.primaryText),
                ),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            Provider(create: (_) => DatabaseHelper()),
            Provider(
              create: (context) =>
                  PlayerRepository(context.read<DatabaseHelper>()),
            ),
            Provider(
              create: (context) =>
                  MatchRepository(context.read<DatabaseHelper>()),
            ),
            Provider(
              create: (context) =>
                  InningsRepository(context.read<DatabaseHelper>()),
            ),
            Provider(
              create: (context) =>
                  BallRepository(context.read<DatabaseHelper>()),
            ),
            Provider(
              create: (context) =>
                  DismissalRepository(context.read<DatabaseHelper>()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  PlayerProvider(playerRepo: context.read<PlayerRepository>()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  MatchProvider(matchRepo: context.read<MatchRepository>()),
            ),
            ChangeNotifierProvider(
              create: (context) => ScoreProvider(
                ballRepo: context.read<BallRepository>(),
                inningsRepo: context.read<InningsRepository>(),
                dismissalRepo: context.read<DismissalRepository>(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => HistoryProvider(
                matchRepo: context.read<MatchRepository>(),
                inningsRepo: context.read<InningsRepository>(),
                ballRepo: context.read<BallRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: AppStrings.appName,
            theme: AppTheme.darkTheme(),
            home: const SplashScreen(),
            routes: {
              '/home': (context) => const HomeScreen(),
              '/createMatch': (context) => const CreateMatchScreen(),
              '/playerSelection': (context) => const PlayerSelectionScreen(),
              '/toss': (context) => const TossScreen(),
              '/scoring': (context) => const LiveScoringScreen(),
              '/scorecard': (context) => const ScorecardScreen(),
              '/matchHistory': (context) => const MatchHistoryScreen(),
            },
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}